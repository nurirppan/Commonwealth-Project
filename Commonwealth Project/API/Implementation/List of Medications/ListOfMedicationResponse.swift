//
//  ListOfMedicationResponse.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 03/12/20.
//

import Foundation

struct ListOfMedicationResponse: Codable {
    let sources: [ListOfMedication]
}

struct ListOfMedication: Codable {
    let id: Int?
    let status: String?
    let fullName: String?
    let totalPrice: Int?
    let currency: String?
    let updatedAt: String?
}

