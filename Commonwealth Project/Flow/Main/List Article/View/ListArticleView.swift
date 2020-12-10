//
//  ListArticleView.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation


protocol ListArticleViewInput: AnyObject {
    func onFetchArticles(articles: [HeadlineResponseDetail])
    func onViewState(_ state: BasicUIState)
}

protocol ListArticleViewOutput: AnyObject {
    func viewDidLoad()
    func onArticleTapped(resource: WebviewResourceType)
    func onSearchArticles(keyword: String)
}
