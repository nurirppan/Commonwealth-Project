//
//  ArticleView.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation


protocol DetailArticleViewInput: AnyObject {
    func onWebview(resource: WebviewResourceType)
}

protocol DetailArticleViewOutput: AnyObject {
    func viewDidLoad()
    func onDoneTapped()
}
