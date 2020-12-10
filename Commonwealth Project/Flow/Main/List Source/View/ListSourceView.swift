//
//  ListSourceView.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation


protocol ListSourceViewInput: AnyObject {
    func onFetchSources(sources: [SourceResponseDetail])
}

protocol ListSourceViewOutput: AnyObject {
    func viewDidLoad()
    func onSourceTapped(sourceId: String)
    func onSearchSources(keyword: String)
}
