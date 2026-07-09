//
//   CityPickerSheet.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 09/07/26.
//

import Foundation
import SwiftUI

struct CityPickerSheet: View {

    @Binding var selection: String
    let title: String
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""

    private var filteredCities: [City] {
        guard !searchText.isEmpty else { return City.all }
        return City.all.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.code.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredCities) { city in
                Button {
                    selection = city.name
                    dismiss()
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(city.name)
                                .font(.headline)
                                .foregroundStyle(.primary)
                            Text(city.code)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        if selection == city.name {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.blue)
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search city or airport code")
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
