//
//  OrderDetailView.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 02/12/20.
//

import Foundation

protocol OrderDetailViewInput: AnyObject {
    func onViewState(_ state: BasicUIState)
    func onFetchCategories(model: MedicationDetailResponse)
}

protocol OrderDetailViewOutput: AnyObject {
    func viewDidLoad()
}
