//
//  DetailArticleInteractor.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation

import Foundation

protocol DetailArticleInteractorOutput: AnyObject {
    
}

final class DetailArticleInteractor: Interactorable {
    
    let resource: WebviewResourceType
    weak var presenter: DetailArticleInteractorOutput?
    
    init(resource: WebviewResourceType) {
        self.resource = resource
    }
}
