//
//  CreateEmployeeVC.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 10/12/20.


import RxSwift
import RxCocoa
import JGProgressHUD

class CreateEmployeeVC: UIViewController {
    
    internal var presenter: CreateEmployeeViewOutput?
    
    private let hud = JGProgressHUD(style: .dark)
    
    private var createEmployee: CreateEmployeeRequest?
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfSalary: UITextField!
    @IBOutlet weak var tfAge: UITextField!
    @IBOutlet weak var btnCreateEmployee: UIButton!
    @IBOutlet weak var btnShowAllEmployess: UILabel!
    @IBOutlet weak var btnApiOne: UIButton!
    @IBOutlet weak var btnApiTwo: UIButton!
    
    var name: String { return self.tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""}
    var salary: String { return self.tfSalary.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""}
    var age: String { return self.tfAge.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""}
    
    var forms = [String: String]()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupActions()
        
    }
    
    private func setupUI() {
        self.setupLoading()
    }
    
    private func setupActions() {
        self.btnCreateEmployee.addTapGestureRecognizer {
            self.forms = [
                "Nama Tidak Boleh Kosong" : self.name,
                "Gaji Tidak Boleh Kosong" : self.salary,
                "Umur Tidak Boleh Kosong" : self.age
            ]
            
            for (error, value) in self.forms {
                if value.isEmpty {
                    self.showPopupError(error: error)
                    break
                }
            }
            
            self.showPopupError(error: "Berhasil Simpan Data")
            
        }
        
        self.btnShowAllEmployess.addTapGestureRecognizer {
            self.presenter?.onShowAllEmployeeTapped()
        }
        
        self.btnApiOne.addTapGestureRecognizer {
            self.presenter?.onShowAPIOne()
        }
        
        self.btnApiTwo.addTapGestureRecognizer {
            self.presenter?.onShowAPITwo()
        }
    }
    
    private func setupLoading() {
        hud.vibrancyEnabled = true
        hud.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        hud.textLabel.text = "Loading"
    }
    
    private func showPopupError(error: String) {
        let alert = UIAlertController(title: "Alert", message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}


extension CreateEmployeeVC {
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

extension CreateEmployeeVC: CreateEmployeeViewInput {
    
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


extension CreateEmployeeVC: Viewable { }
