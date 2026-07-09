//
//  FlightCard.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 09/07/26.
//

import SwiftUI

struct FlightCard: View {

    let flight: Flight
    var action: () -> Void

    @State private var pressed = false

    var body: some View {

        Button(action: action) {

            VStack(spacing: 22) {
                HStack {
                    AirlineImageView(
                            urlString: flight.airlineLogoUrl,
                            fallbackName: flight.airline
                    )
                    VStack(alignment: .leading, spacing: 3) {

                        Text(flight.airline)
                            .font(.title3.bold())

                        Text(flight.id)
                            .font(.caption)
                            .foregroundStyle(.secondary)

                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 4) {

                        Text("From")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        PriceTag(price: flight.basePrice)

                    }

                }

                //----------------------------------------------------
                // Timeline
                //----------------------------------------------------

                FlightTimeline(flight: flight)

                //----------------------------------------------------
                // Aircraft + Cabin
                //----------------------------------------------------

                HStack(spacing: 10) {

                    Label(
                        flight.cabinLayout.aircraft,
                        systemImage: "airplane"
                    )

                    Spacer()

                    Label(
                        "Non-stop",
                        systemImage: "checkmark.circle.fill"
                    )
                    .foregroundStyle(.green)

                }
                .font(.caption)
                .foregroundStyle(.secondary)

                Divider()

                //----------------------------------------------------
                // Bottom
                //----------------------------------------------------

                HStack {

                    HStack(spacing: 8) {

                        cabinChip("Business")

                        cabinChip("Premium")

                        cabinChip("Economy")

                    }

                    Spacer()

                    HStack(spacing: 6) {

                        Text("View Seats")

                        Image(systemName: "arrow.right")

                    }
                    .font(.headline)
                    .foregroundStyle(.blue)

                }

            }
            .padding(22)
            .background(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 28)
            )
            .shadow(
                color: .black.opacity(0.08),
                radius: 15,
                y: 8
            )
            .scaleEffect(pressed ? 0.98 : 1)
            .animation(.spring(response: 0.3), value: pressed)

        }
        .buttonStyle(.plain)
        .onLongPressGesture(
            minimumDuration: 0.01,
            pressing: { value in
                pressed = value
            },
            perform: {}
        )

    }

}

// MARK: Cabin Chip

private extension FlightCard {

    func cabinChip(_ title: String) -> some View {

        Text(title)

            .font(.caption.bold())

            .padding(.horizontal, 10)

            .padding(.vertical, 6)

            .background(
                Color.blue.opacity(0.08)
            )

            .foregroundStyle(.blue)

            .clipShape(
                Capsule()
            )
    }
}

