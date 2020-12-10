//
//  ListSourceVC.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import UIKit
import RxSwift
import RxCocoa
import JGProgressHUD

class ListSourceVC: UIViewController {
    
    var model: [SourceResponseDetail]! {
        didSet {
            self.modelRelay.accept(self.model)
        }
    }
    var onSourceTapped: ((String) -> Void)?
    
    private var sources = [SourceResponseDetail]()
    
    private let hud = JGProgressHUD(style: .dark)
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let modelRelay = BehaviorRelay<[SourceResponseDetail]>(value: [])
    private let disposeBag = DisposeBag()
    
    internal var presenter: ListSourceViewOutput?
    
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
        self.setupTitleForNavigation(title: "News Sources")
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

}

extension ListSourceVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter?.onSearchSources(keyword: searchText)
    }
}

extension ListSourceVC: ListSourceViewInput {
    func onFetchSources(sources: [SourceResponseDetail]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.sources = sources
            self.tableView.reloadData()
        }
    }
}

extension ListSourceVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let target = self.sources[indexPath.row]
        cell.textLabel?.text = target.name
        cell.detailTextLabel?.text = target.description
        return cell
    }
}

extension ListSourceVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let target = self.sources[indexPath.row]
        guard let sourceId = target.id else { return }
        self.presenter?.onSourceTapped(sourceId: sourceId)
    }
}

extension ListSourceVC: Viewable { }

