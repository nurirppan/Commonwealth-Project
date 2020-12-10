//
//  OrderDetailVC.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 02/12/20.
//

import RxSwift
import RxCocoa
import JGProgressHUD

class OrderDetailVC: UIViewController {
    
    internal var presenter: OrderDetailViewOutput?
    
    private let hud = JGProgressHUD(style: .dark)
    private var models: MedicationDetailResponse?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupNavigation()
    }
    
    private func setupNavigation() {
        self.setupTitleForNavigation(title: "MyMed Detail")
    }
    
    private func setupUI() {
        self.setupLoading()
        self.setupTableView()
    }
    
    private func setupLoading() {
        hud.vibrancyEnabled = true
        hud.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        hud.textLabel.text = "Loading"
    }
    
    private func setupTableView() {
        let niba = UINib(nibName: "OrderDetailStatusCell", bundle: nil)
        self.tableView.register(niba, forCellReuseIdentifier: "OrderDetailStatusCell")
        
        let nibb = UINib(nibName: "OrderDetailCustomerCell", bundle: nil)
        self.tableView.register(nibb, forCellReuseIdentifier: "OrderDetailCustomerCell")
        
        let nibc = UINib(nibName: "OrderDetailPrescriptionCell", bundle: nil)
        self.tableView.register(nibc, forCellReuseIdentifier: "OrderDetailPrescriptionCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.isHidden = true
    }
    
}

extension OrderDetailVC: OrderDetailViewInput {
    func onFetchCategories(model: MedicationDetailResponse) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.models = model
            self.tableView.isHidden = false
            self.tableView.reloadData()
            
        }
    }
    
    
    func onViewState(_ state: BasicUIState) { // disini ke 3
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

extension OrderDetailVC {
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

extension OrderDetailVC: Viewable { }


extension OrderDetailVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailStatusCell", for: indexPath) as! OrderDetailStatusCell
            
            cell.selectionStyle = .none
            
            cell.setupModel(model: self.models)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailCustomerCell", for: indexPath) as! OrderDetailCustomerCell
            
            cell.selectionStyle = .none
            
            cell.setupModel(model: self.models)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailPrescriptionCell", for: indexPath) as! OrderDetailPrescriptionCell
            
            cell.selectionStyle = .none
            cell.setupModel(model: self.models)
            return cell
        }
        
    }
}

extension OrderDetailVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        } else if indexPath.row == 1 {
            return 250
        } else {
            return 300
        }
        
    }
    
}
