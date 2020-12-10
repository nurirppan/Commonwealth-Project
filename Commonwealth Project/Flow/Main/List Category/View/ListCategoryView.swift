//
//  ListCategoryView.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation

protocol ListCategoryViewInput: AnyObject {
    func onFetchCategories(categories: [String])
    func onViewState(_ state: BasicUIState)
}

protocol ListCategoryViewOutput: AnyObject {
    func viewDidLoad()
    func onCategoryTapped(category: String)
}
