//
//  BreedsListResponse.swift
//  Random Dog
//
//  Created by Elina Mansurova on 2020-09-22.
//

import Foundation

struct BreedsListResponse: Codable {
    let status: String
    let message: [String: [String]]
}
