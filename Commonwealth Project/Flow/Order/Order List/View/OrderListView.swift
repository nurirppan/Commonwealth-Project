//
//  OrderListView.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 30/11/20.
//

import Foundation


protocol ListOrderViewInput: AnyObject {
    func onViewState(_ state: BasicUIState)
    func onFetchOrders(orders: [ListOfMedication])
}

protocol ListOrderViewOutput: AnyObject {
    func viewDidLoad()
    func onOrderTapped(id: Int)
}
