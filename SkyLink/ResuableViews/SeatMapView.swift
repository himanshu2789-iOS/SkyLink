////
////  SeatMapView.swift
////  SkyLink
////
////  Created by Himanshu Sharma on 09/07/26.
////
//import SwiftUI
//
//struct SeatMapView: View {
//
//    @Bindable var viewModel: FlightSearchViewModel
//
//    private let leftColumns = ["A","B","C"]
//    private let rightColumns = ["D","E","F"]
//
//    var body: some View {
//
//        if let flight = viewModel.selectedFlight {
//
//            let layout = flight.cabinLayout
//
//            VStack(spacing: 18) {
//
//                Text("Front of Aircraft")
//                    .font(.caption)
//                    .fontWeight(.bold)
//                    .foregroundStyle(.secondary)
//
//                ForEach(1...layout.rows, id: \.self) { row in
//
//                    HStack(spacing: 14) {
//
//                        leftSide(row: row)
//
//                        rowNumber(row)
//
//                        rightSide(row: row)
//                    }
//                }
//
//                Text("Rear of Aircraft")
//                    .font(.caption2)
//                    .foregroundStyle(.secondary)
//                    .padding(.top,12)
//
//            }
//            .padding(.horizontal)
//            .padding(.vertical,24)
//
//        }
//
//    }
//
//}
//
//// MARK: Left
//
//private extension SeatMapView {
//
//    @ViewBuilder
//    func leftSide(row: Int) -> some View {
//
//        HStack(spacing: 8) {
//
//            ForEach(leftColumns,id:\.self) { column in
//
//                seat(row: row, column: column)
//
//            }
//
//        }
//
//    }
//
//    @ViewBuilder
//    func rightSide(row: Int) -> some View {
//
//        HStack(spacing: 8) {
//
//            ForEach(rightColumns,id:\.self) { column in
//
//                seat(row: row, column: column)
//
//            }
//
//        }
//
//    }
//
//    @ViewBuilder
//    func rowNumber(_ row:Int) -> some View {
//
//        Text("\(row)")
//            .font(.caption)
//            .fontWeight(.bold)
//            .foregroundStyle(.secondary)
//            .frame(width:24)
//
//    }
//
//    @ViewBuilder
//    func seat(row:Int,column:String) -> some View {
//
//        if let seat = seatFor(row: row, column: column) {
//
//            SeatCell(seat: seat) {
//
//                viewModel.toggleSeatSelection(seat: seat)
//
//            }
//
//        } else {
//
//            Color.clear
//                .frame(width:44,height:44)
//
//        }
//
//    }
//
//    func seatFor(row:Int,column:String) -> Seat? {
//
//        viewModel.selectedFlight?
//            .cabinLayout
//            .seats
//            .first {
//
//                $0.row == row &&
//                $0.number == column
//
//            }
//
//    }
//
//}

//
//  SeatMapView.swift
//  SkyLink
//

import SwiftUI

struct SeatMapView: View {

    @Bindable var viewModel: FlightSearchViewModel

    private let letters = ["A","B","C","D","E","F"]

    var body: some View {

        if let layout = viewModel.selectedFlight?.cabinLayout {

            VStack(spacing: 28) {

                AircraftHeaderView(
                    aircraft: layout.aircraft,
                    configuration: layout.configuration
                )

                seatLegend

                LazyVStack(spacing: 0) {

                    ForEach(1...layout.rows, id: \.self) { row in

                        if shouldShowCabinHeader(before: row, layout: layout) {

                            CabinSectionHeader(
                                cabinClass: cabinClass(for: row, layout: layout)
                            )
                            .padding(.vertical,12)
                        }

                        SeatRowView(
                            row: row,
                            seats: seatsForRow(row, layout: layout),
                            viewModel: viewModel
                        )
                        .padding(.vertical,6)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom,40)
        }
    }
}

private extension SeatMapView {

    var seatLegend: some View {

        HStack(spacing:18) {

            LegendCell(
                color: Color.gray.opacity(0.18),
                title: "Available"
            )

            LegendCell(
                color: Color.green,
                title: "Selected"
            )

            LegendCell(
                color: Color.red.opacity(0.18),
                title: "Occupied"
            )

            Spacer()

            if let selectedSeat = viewModel.selectedSeats.first {
                SeatPricingBadge(seat: selectedSeat)
            }
        }
        .padding(.horizontal)
    }

    func seatsForRow(
        _ row:Int,
        layout: CabinLayout
    ) -> [Seat] {

        layout.seats
            .filter { $0.row == row }
            .sorted {
                $0.number < $1.number
            }
    }
}


// MARK: - Cabin Helpers

private extension SeatMapView {

    func shouldShowCabinHeader(
        before row: Int,
        layout: CabinLayout
    ) -> Bool {

        guard row > 1 else { return true }

        let current = cabinClass(for: row, layout: layout)
        let previous = cabinClass(for: row - 1, layout: layout)

        return current != previous
    }

    func cabinTitle(
        for row: Int,
        layout: CabinLayout
    ) -> String {

        cabinClass(for: row, layout: layout).displayName
    }

    func cabinClass(
        for row: Int,
        layout: CabinLayout
    ) -> CabinClass {

        layout.seats.first(where: { $0.row == row })?.cabinClass ?? .economy
    }
}

// MARK: - Seat Row

struct SeatRowView: View {

    let row: Int
    let seats: [Seat]

    @Bindable var viewModel: FlightSearchViewModel

    var body: some View {

        HStack(spacing: 18) {

            leftSeats

            rowNumber

            rightSeats
        }
        .padding(.horizontal, 4)
    }
}

private extension SeatRowView {

    var leftSeats: some View {

        HStack(spacing: 10) {

            seat(letter: "A")
            seat(letter: "B")
            seat(letter: "C")
        }
    }

    var rightSeats: some View {

        HStack(spacing: 10) {

            seat(letter: "D")
            seat(letter: "E")
            seat(letter: "F")
        }
    }

    var rowNumber: some View {

        Text("\(row)")
            .font(.caption)
            .fontWeight(.bold)
            .foregroundStyle(.secondary)
            .frame(width: 28)
    }

    @ViewBuilder
    func seat(letter: String) -> some View {

        if let seat = seats.first(where: { $0.number == letter }) {

            SeatCellView(
                seat: seat,
                action: {
                    viewModel.toggleSeatSelection(seat: seat)
                }
            )

        } else {

            Color.clear
                .frame(width: 44, height: 44)
        }
    }
}

// MARK: - Seat Cell

struct SeatCellView: View {

    let seat: Seat
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            VStack(spacing: 2) {

                Text(seat.number)
                    .font(.system(size: 11, weight: .bold))

                if seat.priceMarkup > 0 {
                    Text("+\(Int(seat.priceMarkup))")
                        .font(.system(size: 7, weight: .medium))
                }
            }
            .foregroundStyle(textColor)
            .frame(width: 42, height: 42)
            .background(background)
            .overlay(border)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(
                color: shadowColor,
                radius: shadowRadius,
                y: shadowOffset
            )
            .scaleEffect(seat.status == .selected ? 1.08 : 1.0)
            .animation(.spring(response: 0.30, dampingFraction: 0.75), value: seat.status)
        }
        .buttonStyle(.plain)
        .disabled(seat.status == .occupied)
    }
}

private extension SeatCellView {

    @ViewBuilder
    var background: some View {

        RoundedRectangle(cornerRadius: 10)
            .fill(backgroundColor)
    }

    @ViewBuilder
    var border: some View {

        RoundedRectangle(cornerRadius: 10)
            .stroke(borderColor, lineWidth: 1.4)
    }

    var backgroundColor: Color {

        switch seat.status {

        case .selected:
            return .blue

        case .occupied:
            return Color.red.opacity(0.18)

        case .available:

            switch seat.cabinClass {

            case .first:
                return Color.orange.opacity(0.22)

            case .business:
                return Color.indigo.opacity(0.18)

            case .premium:
                return Color.purple.opacity(0.18)

            case .economy:
                return Color.gray.opacity(0.15)
            }
        }
    }

    var borderColor: Color {

        switch seat.status {

        case .selected:
            return .blue

        case .occupied:
            return .red.opacity(0.7)

        case .available:

            switch seat.cabinClass {

            case .first:
                return .orange

            case .business:
                return .indigo

            case .premium:
                return .purple

            case .economy:
                return .gray.opacity(0.5)
            }
        }
    }

    var textColor: Color {

        switch seat.status {

        case .selected:
            return .white

        case .occupied:
            return .red

        case .available:

            switch seat.cabinClass {

            case .first:
                return .orange

            case .business:
                return .indigo

            case .premium:
                return .purple

            case .economy:
                return .primary
            }
        }
    }

    var shadowColor: Color {

        seat.status == .selected
            ? .blue.opacity(0.35)
            : .black.opacity(0.05)
    }

    var shadowRadius: CGFloat {
        seat.status == .selected ? 8 : 2
    }

    var shadowOffset: CGFloat {
        seat.status == .selected ? 4 : 1
    }
}

// MARK: - Legend

struct LegendCell: View {

    let color: Color
    let title: String

    var body: some View {

        HStack(spacing: 6) {

            RoundedRectangle(cornerRadius: 4)
                .fill(color)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.secondary.opacity(0.35), lineWidth: 1)
                )
                .frame(width: 14, height: 14)

            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}
