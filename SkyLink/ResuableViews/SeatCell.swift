//
//  SeatCell.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 09/07/26.
//

import Foundation
import SwiftUI

struct SeatCell: View {

    let seat: Seat

    var action: () -> Void

    var body: some View {

        Button(action: action) {

            RoundedRectangle(cornerRadius: 10)

                .fill(fillColor)

                .frame(width: 42,height: 42)

                .overlay {

                    RoundedRectangle(cornerRadius: 10)
                        .stroke(borderColor,lineWidth:2)

                }

                .overlay {

                    Text(seat.number)
                        .font(.system(size:12,weight:.bold))
                        .foregroundStyle(textColor)

                }

                .shadow(
                    color: shadowColor,
                    radius: seat.status == .selected ? 6 : 0
                )

        }

        .buttonStyle(.plain)
        .disabled(seat.status == .occupied)

    }

}

private extension SeatCell {

    var fillColor: Color {

        switch seat.status {

        case .available:

            switch seat.cabinClass {

            case .first:
                return .orange.opacity(0.18)

            case .business:
                return .blue.opacity(0.18)

            case .premium:
                return .purple.opacity(0.18)

            case .economy:
                return Color(.systemGray6)

            }

        case .occupied:

            return .red.opacity(0.15)

        case .selected:

            return .green

        }

    }

    var borderColor: Color {

        switch seat.status {

        case .available:

            switch seat.cabinClass {

            case .first:
                return .orange

            case .business:
                return .blue

            case .premium:
                return .purple

            case .economy:
                return .gray

            }

        case .occupied:

            return .red

        case .selected:

            return .green

        }

    }

    var textColor: Color {

        switch seat.status {

        case .selected:
            return .white

        case .occupied:
            return .red

        default:
            return .primary

        }

    }

    var shadowColor: Color {

        seat.status == .selected ? .green.opacity(0.45) : .clear

    }

}
