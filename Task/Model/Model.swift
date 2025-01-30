//
//  Model.swift
//  Task
//
//  Created by Apple on 1/24/25.
//

import SwiftUI
import Combine

// MARK: - Models
struct City: Identifiable, Codable {
    let id = UUID()
    let country: String
    let city: String

    private enum CodingKeys: String, CodingKey {
        case country = "country"
        case city = "city"
    }
}


