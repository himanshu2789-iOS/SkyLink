//
//  SeatPricingBadge.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 09/07/26.
//
import SwiftUI

struct SeatPricingBadge: View {

    let seat: Seat

    var body: some View {

        if seat.priceMarkup > 0 {

            HStack(spacing:4){

                Image(systemName: "plus.circle.fill")
                    .font(.caption2)

                Text("+$\(Int(seat.priceMarkup))")

            }
            .font(.caption2.bold())
            .padding(.horizontal,8)
            .padding(.vertical,5)
            .background(background)
            .clipShape(Capsule())

        }

    }

    private var background: Color {

        switch seat.cabinClass {

        case .first:
            return .orange.opacity(0.2)

        case .business:
            return .blue.opacity(0.2)

        case .premium:
            return .purple.opacity(0.2)

        case .economy:
            return .green.opacity(0.15)

        }

    }

}
