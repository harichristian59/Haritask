//
//  ContentView.swift
//  Task
//
//  Created by Apple on 1/24/25.
//


import Foundation
import SwiftUI
import Combine


struct ContentView: View {
    @StateObject private var viewModel = CitiesViewModel()
    @State private var reversed = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.groupedCities.keys.sorted(by: viewModel.reversed ? (>) : (<)), id: \ .self) { state in
                        Section(header: headerView(for: state)) {
                            if viewModel.expandedStates.contains(state) {
                                ForEach(viewModel.groupedCities[state] ?? []) { city in
                                    Text(city.city)
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())

                HStack {
//                    Button(action: {
////                        viewModel.reverseOrder()
//                        viewModel.reversed.toggle()
//                        print(viewModel.cities)
//
//                    }) {
//                        Text(viewModel.reversed ? "Normal Order" : "Reverse Order")
//
//                            .font(.headline)
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.accentColor)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
                    
                    Button(action: {
                        viewModel.toggleOrder()
                        print(viewModel.reversed)
                    }) {
                        Text(viewModel.reversed ? "Normal Order" : "Reverse Order")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                   

//                    Button(action: {
//                        viewModel.refreshData()
//                    }) {
//                        Text("Refresh Data")
//                            .font(.headline)
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Australian Cities")
        }
        .preferredColorScheme(nil)
    }

    private func headerView(for state: String) -> some View {
        HStack {
            Text(state)
                .font(.headline)

            Spacer()

            Button(action: {
                viewModel.toggleStateExpansion(state: state)
            }) {
                Image(systemName: viewModel.expandedStates.contains(state) ? "chevron.down" : "chevron.right")
                    .foregroundColor(.gray)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.toggleStateExpansion(state: state)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
