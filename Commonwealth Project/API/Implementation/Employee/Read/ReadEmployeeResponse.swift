//
//  ReadEmployeeResponse.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 10/12/20.
//

import Foundation

struct ReadEmployeeResponse: Codable {
    let status: String
    let data: [Datum]
}

struct Datum: Codable {
    let id, employeeName, employeeSalary, employeeAge: String

}
