//
//  AirportField.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import SwiftUI

struct AirportField: View {

    let title: String
    let icon: String
    let placeholder: String
    @Binding var text: String

    @State private var showDropdown = false
    @FocusState private var isFocused: Bool

    private var filteredCities: [City] {
        if text.isEmpty { return City.all }
        return City.all.filter {
            $0.name.localizedCaseInsensitiveContains(text) ||
            $0.code.localizedCaseInsensitiveContains(text)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            HStack(spacing: 14) {

                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(.blue)
                    .frame(width: 32)

                VStack(alignment: .leading, spacing: 3) {

                    Text(title)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)

                    TextField(placeholder, text: $text)
                        .font(.headline)
                        .focused($isFocused)
                        .onChange(of: isFocused) { _, focused in
                            withAnimation { showDropdown = focused }
                        }
                }

                Spacer()

                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 16))

            if showDropdown {
                dropdownList
            }
        }
    }

    private var dropdownList: some View {
        VStack(spacing: 0) {

            if filteredCities.isEmpty {

                Text("No matching city")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding()

            } else {

                ForEach(filteredCities) { city in

                    Button {
                        text = city.name
                        isFocused = false
                        withAnimation { showDropdown = false }
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(city.name)
                                    .font(.subheadline.weight(.medium))
                                    .foregroundStyle(.primary)
                                Text(city.code)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 14)
                    }
                    .buttonStyle(.plain)

                    if city.id != filteredCities.last?.id {
                        Divider().padding(.leading, 14)
                    }
                }
            }
        }
        .background(Color(.systemGray6).opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.top, 6)
        .transition(.opacity.combined(with: .move(edge: .top)))
    }
}
