//
//  AircraftHeaderView.swift
//  SkyLink
//

import SwiftUI

struct AircraftHeaderView: View {

    let aircraft: String
    let configuration: String

    var body: some View {

        VStack(spacing: 18) {

            // Aircraft Nose
            ZStack {

                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.blue.opacity(0.15),
                                .white
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 170, height: 70)

                Image(systemName: "airplane")
                    .font(.system(size: 34))
                    .foregroundStyle(.blue)
            }

            VStack(spacing: 4) {

                Text(aircraft)
                    .font(.title3.bold())

                Text("Configuration • \(configuration)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 20) {

                Label("Window", systemImage: "square.leadinghalf.filled")

                Label("Aisle", systemImage: "rectangle.split.3x1")
            }
            .font(.caption)
            .foregroundStyle(.secondary)

        }
        .padding(.top)
        .padding(.bottom, 10)
    }
}
