//
//  ListSourceInteractor.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation

protocol ListSourceInteractorOutput: AnyObject {
    func onSearchSources(_ sources: [SourceResponseDetail])
}

final class ListSourceInteractor: Interactorable {
    
    let originSources: [SourceResponseDetail]
    weak var presenter: ListSourceInteractorOutput?
    
    init(originSources: [SourceResponseDetail]) {
        self.originSources = originSources
    }
    
    func searchSources(keyword: String) {
        let sourcesFiltered = self.originSources.filter { (source) in
            if let name = source.name {
                let filter = NSPredicate(format: "%@ CONTAINS[c] %@", name, keyword)
                return filter.evaluate(with: nil)
            }
            return false
        }
        self.presenter?.onSearchSources(sourcesFiltered)
    }
}
