//
//  ListCategoryVC.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import UIKit
import RxSwift
import RxCocoa
import JGProgressHUD

class ListCategoryVC: UIViewController {
    
    var onCategoryTapped: (([SourceResponseDetail]) -> Void)?
    
    private var categories = [String]()
    
    private let hud = JGProgressHUD(style: .dark)
    @IBOutlet weak var tableView: UITableView!
    
    private let viewDidLoadRelay = PublishRelay<Void>()
    private let categoryTappedRelay = BehaviorRelay<String?>(value: nil)
    private let disposeBag = DisposeBag()
    
    internal var presenter: ListCategoryViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.presenter?.viewDidLoad()
        
        //self.bindViewModel()
        
        //self.viewDidLoadRelay.accept(())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupNavigation()
    }
    
    private func setupNavigation() {
        self.setupTitleForNavigation(title: "News Categories")
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

}

extension ListCategoryVC: ListCategoryViewInput {
    func onFetchCategories(categories: [String]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.categories = categories
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

extension ListCategoryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let target = self.categories[indexPath.row]
        cell.textLabel?.text = target
        return cell
    }
}

extension ListCategoryVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let target = self.categories[indexPath.row]
        self.presenter?.onCategoryTapped(category: target)
    }
}

extension ListCategoryVC {
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

extension ListCategoryVC: Viewable {}
