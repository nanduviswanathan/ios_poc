//
//  UserData.swift
//  iOS POC
//
//  Created by NanduV on 01/03/22.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userData = try? newJSONDecoder().decode(UserData.self, from: jsonData)

import Foundation

// MARK: - UserData
struct UserData: Codable {
    let lastname, uid: String
    let age: Int
    let firstname: String
}
