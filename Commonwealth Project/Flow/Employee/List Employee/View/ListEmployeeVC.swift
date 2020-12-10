//
//  ListEmployeeVC.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 10/12/20.
//

import RxSwift
import RxCocoa
import JGProgressHUD

class ListEmployeeVC: UIViewController {
    
    internal var presenter: ListEmployeeViewOutput?
    
    private let hud = JGProgressHUD(style: .dark)
    
    private var models = [Datum]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupTitleForNavigation(title: "Employee List")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupModels()
    }
    
    private func setupUI() {
        self.setupLoading()
        self.setupTableView()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "ListEmployeeCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ListEmployeeCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    private func setupLoading() {
        hud.vibrancyEnabled = true
        hud.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        hud.textLabel.text = "Loading"
    }
    
    private func setupModels() {
        self.models.append(Datum(id: "01", employeeName: "Nur", employeeSalary: "Rp 1.000", employeeAge: "24"))
        self.models.append(Datum(id: "02", employeeName: "Irfan", employeeSalary: "Rp 2.000", employeeAge: "25"))
        self.models.append(Datum(id: "03", employeeName: "Pangestu", employeeSalary: "Rp 3.000", employeeAge: "26"))
        self.models.append(Datum(id: "04", employeeName: "Nur One", employeeSalary: "Rp 1.000", employeeAge: "24"))
        self.models.append(Datum(id: "05", employeeName: "Irfan One", employeeSalary: "Rp 2.000", employeeAge: "25"))
        self.models.append(Datum(id: "06", employeeName: "Pangestu One", employeeSalary: "Rp 3.000", employeeAge: "26"))
        self.models.append(Datum(id: "07", employeeName: "Nur Two", employeeSalary: "Rp 1.000", employeeAge: "24"))
        self.models.append(Datum(id: "08", employeeName: "Irfan Two", employeeSalary: "Rp 2.000", employeeAge: "25"))
        self.models.append(Datum(id: "09", employeeName: "Pangestu Two", employeeSalary: "Rp 3.000", employeeAge: "26"))
        self.models.append(Datum(id: "10", employeeName: "Pangestu Two", employeeSalary: "Rp 3.000", employeeAge: "26"))
        
        self.tableView.reloadData()
    }
    
    func showPopupError(title: String, error: String) {
        let alert = UIAlertController(title: title, message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}

extension ListEmployeeVC {
    private func showLoading() {
        hud.show(in: self.view)
    }
    
    private func hideLoading() {
        hud.dismiss(animated: true)
    }
    
    private func showAlert(message: String, isSuccess: Bool = false) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.hud.indicatorView = nil
            self.hud.textLabel.font = .systemFont(ofSize: 21)
            self.hud.textLabel.text = message
            if isSuccess {
                self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            } else {
                self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
            }
            self.hud.dismiss(afterDelay: 1.0)
        }
    }
}

extension ListEmployeeVC: ListEmployeeViewInput {
    
    func onViewState(_ state: BasicUIState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.showLoading()
            case .close:
                self.hideLoading()
            case .failure(let message):
                self.showAlert(message: message)
            case .warning(let message):
                self.showAlert(message: message)
            case .success(let message):
                self.showAlert(message: message, isSuccess: true)
            }
        }
    }
}


extension ListEmployeeVC: Viewable { }

extension ListEmployeeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListEmployeeCell", for: indexPath) as! ListEmployeeCell
        
        cell.selectionStyle = .none
        
        let target = self.models[indexPath.row]
        
        cell.setupModel(model: target)
        cell.setupBackground(row: indexPath.row)
        
        // MARK :- Setup Action
        cell.onEditTapped = { [weak self] (value) in
            guard let self = self else { return }
            print("\(value)")
            self.showPopupError(title: "Berhasil Edit", error: "\(value.id)\n\(value.employeeName)\n\(value.employeeSalary)\n\(value.employeeAge)")
        }
        cell.onDeleteTapped = { [weak self] (value) in
            guard let self = self else { return }
            self.showPopupError(title: "Berhasil Hapus", error: "\(value.id)\n\(value.employeeName)\n\(value.employeeSalary)\n\(value.employeeAge)")
        }
        return cell
    }
}

extension ListEmployeeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        tableView.deselectRow(at: indexPath, animated: true)
    //        let target = self.orders[indexPath.row].id ?? 0
    //    }
    
}
