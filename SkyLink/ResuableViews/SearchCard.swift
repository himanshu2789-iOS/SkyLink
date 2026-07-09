//
//  SearchCard.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import SwiftUI

struct SearchCard: View {

    @Binding var departure: String
    @Binding var arrival: String
    @Binding var departureDate: Date
    @Binding var passengerCount: Int
    @Binding var rotateSwap: Bool

    var onSwap: () -> Void
    var onSearch: () -> Void

    var body: some View {

        VStack(spacing: 24) {

            Text("Search Flight")
                .font(.title3.weight(.bold))

            AirportField(
                title: "FROM",
                icon: "airplane.departure",
                placeholder: "Departure City",
                text: $departure
            )

            SwapButton(
                rotate: rotateSwap,
                action: onSwap
            )

            AirportField(
                title: "TO",
                icon: "airplane.arrival",
                placeholder: "Arrival City",
                text: $arrival
            )

            HStack(spacing: 16) {

                InfoCard {

                    DatePicker(
                        "",
                        selection: $departureDate,
                        displayedComponents: .date
                    )
                    .labelsHidden()

                } icon: {

                    Image(systemName: "calendar")

                } title: {

                    Text("Departure")

                }

                InfoCard {

                    VStack(alignment: .leading) {

                        Text("\(passengerCount)")
                            .font(.title2.bold())

                        Stepper(
                            "",
                            value: $passengerCount,
                            in: 1...6
                        )
                    }

                } icon: {

                    Image(systemName: "person.2.fill")

                } title: {

                    Text("Passengers")

                }

            }

            GradientButton(
                title: "Search Flights",
                icon: "airplane"
            ) {

                onSearch()

            }

        }
        .padding(24)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 30)
        )
        .shadow(
            color: .black.opacity(0.08),
            radius: 18,
            y: 10
        )

    }

}
