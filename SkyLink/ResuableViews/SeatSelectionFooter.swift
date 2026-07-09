//
//  SeatSelectionFooter.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 09/07/26.
//

import Foundation
import SwiftUI

struct SeatSelectionFooter: View {

    @Bindable var viewModel: FlightSearchViewModel

    var continueAction: () -> Void

    var body: some View {

        VStack(spacing:12){

            HStack{

                VStack(alignment:.leading,spacing:4){

                    Text("Selected Seats")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text(seatNames)
                        .font(.headline)

                }

                Spacer()

                VStack(alignment:.trailing){

                    Text("Total")

                    Text(viewModel.grandTotal,
                         format: .currency(code: "USD"))
                    .font(.title3.bold())

                }

            }

            Button {

                continueAction()

            } label: {

                Text("Continue")

                    .fontWeight(.bold)

                    .frame(maxWidth:.infinity)

                    .frame(height:54)

                    .background(canContinue ? Color.blue : Color.gray)

                    .foregroundStyle(.white)

                    .clipShape(RoundedRectangle(cornerRadius:16))

            }

            .disabled(!canContinue)

        }

        .padding()

        .background(.regularMaterial)

    }

}

private extension SeatSelectionFooter {

    var seatNames:String{

        if viewModel.selectedSeats.isEmpty {

            return "None"

        }

        return viewModel.selectedSeats
            .map{$0.id}
            .joined(separator: ", ")

    }

    var canContinue:Bool{

        viewModel.selectedSeats.count ==
        viewModel.passengerCount

    }

}
