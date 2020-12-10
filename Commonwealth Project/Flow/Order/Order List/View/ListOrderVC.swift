//
//  ListOrderVC.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import RxSwift
import RxCocoa
import JGProgressHUD

class ListOrderVC: UIViewController {
    
    internal var presenter: ListOrderViewOutput?
    
    private let hud = JGProgressHUD(style: .dark)
    
    private var orders = [ListOfMedication]()

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
        self.setupTitleForNavigation(title: "My Med")
    }
    
    private func setupUI() {
        self.setupLoading()
        self.setupTableView()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "OrderListCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "OrderListCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.isHidden = true
    }
    
    private func setupLoading() {
        hud.vibrancyEnabled = true
        hud.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        hud.textLabel.text = "Loading"
    }
    

}

extension ListOrderVC: ListOrderViewInput {
    func onFetchOrders(orders: [ListOfMedication]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.orders = orders
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

extension ListOrderVC {
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


extension ListOrderVC: Viewable { }

extension ListOrderVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListCell", for: indexPath) as! OrderListCell

        cell.selectionStyle = .none

        let target = self.orders[indexPath.row]
        
        cell.setupModel(model: target)
        return cell
    }
}

extension ListOrderVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let target = self.orders[indexPath.row].id ?? 0
        self.presenter?.onOrderTapped(id: target)
    }
    
}
