//
//  Services.swift
//  Task
//
//  Created by Apple on 1/24/25.
//

import Foundation
import Combine
 //MARK: - Services
protocol DataServiceProtocol {
    func fetchCities() -> AnyPublisher<[City], Error>
}

class DataService: DataServiceProtocol {
    private let dataURL = URL(string: "https://run.mocky.io/v3/fdfca769-412b-4d7b-8827-09abb01b96f8")!

    func fetchCities() -> AnyPublisher<[City], Error> {
        URLSession.shared.dataTaskPublisher(for: dataURL)
            .tryMap { output in
                if let jsonString = String(data: output.data, encoding: .utf8) {
                    print("Raw JSON: \(jsonString)")
                }
                return output.data
            }
            .decode(type: [City].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

