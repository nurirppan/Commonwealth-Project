//
//  ArticleVC.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 29/11/20.
//

import UIKit
import WebKit

class ArticleVC: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var webViewFrame: UIView!

    var webView: WKWebView!
    
    var model: WebviewResourceType!
    
    internal var presenter: DetailArticleViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.presenter?.viewDidLoad()
        
        //self.loadWebview()

    }

    override func viewWillAppear(_ animated: Bool) {
        self.setupNavigation()
    }

    private func setupNavigation() {
        self.setupTitleForNavigation(title: "Article")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeTapped))
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc private func closeTapped() {
        self.presenter?.onDoneTapped()
    }

    func loadWebview() {
        if let resource = model {
            webView.load(resource)
        } else {
            fatalError("please set resourceType variable!")
        }
    }

    private func setupUI() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: self.webViewFrame.bounds, configuration: webConfiguration)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.uiDelegate = self
        self.webViewFrame.addSubview(webView)
    }

    func bindViewModel() { }

}

extension ArticleVC: DetailArticleViewInput {
    func onWebview(resource: WebviewResourceType) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.webView.load(resource)
        }
    }
    
}

extension ArticleVC: Viewable { }
