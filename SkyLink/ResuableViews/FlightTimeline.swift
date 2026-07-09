//
//  FlightTimeline.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 09/07/26.
//

import SwiftUI

struct FlightTimeline: View {

    let flight: Flight
    @State private var planeOffset: CGFloat = -16
    
    var body: some View {

        VStack(spacing: 18) {

            // MARK: Time Row

            HStack(alignment: .center) {

                // Departure
                VStack(alignment: .leading, spacing: 4) {

                    Text(
                        flight.departureTime,
                        format: .dateTime.hour().minute()
                    )
                    .font(.title2.bold())

                    Text(flight.departureCode)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                }

                Spacer()

                // Flight Route
                VStack(spacing: 8) {

                    HStack(spacing: 0) {

                        Circle()
                            .fill(Color.blue)
                            .frame(width: 8, height: 8)

                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        .blue.opacity(0.8),
                                        .cyan.opacity(0.8)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(height: 2)

                        Image(systemName: "plane")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.blue)
                            .rotationEffect(.degrees(90))
                            .offset(x: planeOffset)
                            .onAppear {
                                withAnimation(
                                    .easeInOut(duration: 2.0)
                                        .repeatForever(autoreverses: true)
                                ) {
                                    planeOffset = 16
                                }
                            }
                            .padding(.horizontal, 6)

                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        .cyan.opacity(0.8),
                                        .blue.opacity(0.8)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(height: 2)

                        Circle()
                            .fill(Color.cyan)
                            .frame(width: 8, height: 8)

                    }
                    .frame(width: 170)

                    Text(flight.duration)
                        .font(.caption.bold())
                        .foregroundStyle(.secondary)

                }

                Spacer()

                // Arrival
                VStack(alignment: .trailing, spacing: 4) {

                    Text(
                        flight.arrivalTime,
                        format: .dateTime.hour().minute()
                    )
                    .font(.title2.bold())

                    Text(flight.arrivalCode)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                }

            }

            // MARK: Route Details

            HStack {

                Label(
                    "Non-stop",
                    systemImage: "checkmark.circle.fill"
                )
                .foregroundStyle(.green)

                Spacer()

                Label(
                    flight.cabinLayout.aircraft,
                    systemImage: "airplane.departure"
                )

            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }
}
