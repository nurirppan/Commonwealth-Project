//
//  MedicationDetailResponse.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 03/12/20.
//

import Foundation

struct MedicationDetailResponse: Codable {
    let id: String
    let prescriptionImage: String
    let status: String
    let patient: Patient
    let address: Address
}

// MARK: - Address
struct Address: Codable {
    let id, postalCode: String
    let latitude, longitude: Double
    let firstLine, secondLine, note, province: String
    let district, subDistrict: String
}

// MARK: - Patient
struct Patient: Codable {
    let id: Int
    let fullName, phoneNumber: String

}
