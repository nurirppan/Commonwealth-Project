//
//  ListArticleVC.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import UIKit
import RxSwift
import RxCocoa
import JGProgressHUD
import Kingfisher

class ListArticleVC: UIViewController {
    
    var model: String! {
        didSet {
            self.modelRelay.accept(self.model)
        }
    }
    var onArticleTapped: ((WebviewResourceType) -> Void)?
    
    private var articles = [HeadlineResponseDetail]()
    
    private let hud = JGProgressHUD(style: .dark)
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let modelRelay = BehaviorRelay<String?>(value: nil)
    private let disposeBag = DisposeBag()
    
    internal var presenter: ListArticleViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.presenter?.viewDidLoad()
        
//        self.bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupNavigation()
    }
    
    private func setupNavigation() {
        self.setupTitleForNavigation(title: "News Articles")
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupUI() {
        self.setupLoading()
        self.setupTableView()
        self.setupSearchBar()
    }
    
    private func setupLoading() {
        hud.vibrancyEnabled = true
        hud.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        hud.textLabel.text = "Loading"
    }
    
    private func setupSearchBar() {
        self.searchBar.delegate = self
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
//    func bindViewModel() {
//        let input = ListArticleVM.Input(searchRelay: self.searchBar.rx.text.asObservable(),
//                                        sourceRelay: self.modelRelay.asObservable())
//        let output = self.viewModel.transform(input)
//        
//        output.articles.drive { (responses) in
//            self.articles = responses
//            self.tableView.reloadData()
//        }.disposed(by: self.disposeBag)
//        output.state.drive { (state) in
//            switch state {
//            case .loading:
//                self.showLoading()
//            case .close:
//                self.hideLoading()
//            case .failure(let message):
//                self.showAlert(message: message)
//            case .warning(let message):
//                self.showAlert(message: message)
//            case .success(let message):
//                self.showAlert(message: message, isSuccess: true)
//            }
//        }.disposed(by: self.disposeBag)
//    }

}

extension ListArticleVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter?.onSearchArticles(keyword: searchText)
    }
}

extension ListArticleVC: ListArticleViewInput {
    func onFetchArticles(articles: [HeadlineResponseDetail]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.articles = articles
            self.tableView.reloadData()
        }
    }
    
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

extension ListArticleVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let target = self.articles[indexPath.row]
        cell.textLabel?.text = target.title
        cell.detailTextLabel?.text = target.description
        if let urlString = target.urlToImage, let url = URL(string: urlString) {
            cell.imageView?.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (_) in
                cell.setNeedsLayout()
            })
        }
        return cell
    }
}

extension ListArticleVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let target = self.articles[indexPath.row]
        guard let url = target.urlResource else { return }
        self.presenter?.onArticleTapped(resource: url)
    }
}

extension ListArticleVC {
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

extension ListArticleVC: Viewable { }

