//
//  ViewModel.swift
//  Task
//
//  Created by Apple on 1/24/25.
//

import Foundation
import Combine

class CitiesViewModel: ObservableObject {
    @Published var groupedCities: [String: [City]] = [:]
    @Published var reversed: Bool = false
    @Published var expandedStates: Set<String> = []

    private let dataService: DataServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(dataService: DataServiceProtocol = DataService()) {
        self.dataService = dataService
        fetchCities()
    }

    func fetchCities() {
        dataService.fetchCities()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching cities: \(error)")
                }
            }, receiveValue: { [weak self] cities in
                self?.updateGroupedCities(with: cities)
            })
            .store(in: &cancellables)
    }

    func updateGroupedCities(with cities: [City]) {
        let grouped = Dictionary(grouping: cities, by: { $0.city })
        groupedCities = grouped
            .sorted { reversed ? $0.key > $1.key : $0.key < $1.key }
            .reduce(into: [:]) { $0[$1.key] = $1.value }
    }

    func toggleOrder() {
        reversed.toggle()
        
        updateGroupedCities(with: groupedCities.flatMap { $0.value })
    }

    func toggleStateExpansion(state: String) {
        if expandedStates.contains(state) {
            expandedStates.remove(state)
        } else {
            expandedStates.insert(state)
        }
    }
}


