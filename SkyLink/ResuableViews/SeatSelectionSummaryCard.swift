//
//  SeatSelectionSummaryCard.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 09/07/26.
//

import SwiftUI

struct SeatSelectionSummaryCard: View {

    @Bindable var viewModel: FlightSearchViewModel

    var body: some View {

        VStack(alignment:.leading,spacing:18){

            Text("Booking Summary")
                .font(.headline)

            Divider()

            row(
                title: "Passengers",
                value: "\(viewModel.passengerCount)"
            )

            row(
                title: "Seats",
                value: seatList
            )

            row(
                title: "Base Fare",
                value: currency(viewModel.baseFareTotal)
            )

            row(
                title: "Seat Upgrade",
                value: currency(viewModel.seatMarkupTotal)
            )

            row(
                title: "Taxes",
                value: currency(viewModel.taxesAndFees)
            )

            Divider()

            HStack{

                Text("Grand Total")
                    .font(.headline)

                Spacer()

                Text(currency(viewModel.grandTotal))
                    .font(.title3.bold())
                    .foregroundStyle(.blue)

            }

        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius:22))
        .padding(.horizontal)

    }

}

private extension SeatSelectionSummaryCard {

    var seatList:String{

        if viewModel.selectedSeats.isEmpty {

            return "--"

        }

        return viewModel.selectedSeats
            .map{$0.id}
            .joined(separator: ", ")

    }

    func currency(_ value:Double)->String{

        value.formatted(
            .currency(code: "USD")
        )

    }

    @ViewBuilder
    func row(title:String,value:String)->some View{

        HStack{

            Text(title)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .fontWeight(.medium)

        }

    }

}
