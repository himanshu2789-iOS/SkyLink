//
//  FlightSearchView.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

//import SwiftUI
//
//struct SeatSelectionView: View {
//    @Bindable var viewModel: FlightSearchViewModel
//    @State private var navigateToDetails = false
//    
//    var body: some View {
//        VStack(spacing: 16) {
//            VStack(spacing: 4) {
//                Text("Select \(viewModel.passengerCount) Seat\(viewModel.passengerCount > 1 ? "s" : "")")
//                    .font(.headline)
//                Text(viewModel.selectedFlight?.cabinLayout.aircraft ?? "")
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//            }
//            .padding(.top)
//            
//            // Legend
//            HStack(spacing: 20) {
//                LegendItem(label: "Open", color: .blue.opacity(0.15), strokeColor: .blue)
//                LegendItem(label: "Occupied", color: .red.opacity(0.15), strokeColor: .red)
//                LegendItem(label: "Selected", color: .green, strokeColor: .green)
//            }
//            .padding(.vertical, 8)
//            .frame(maxWidth: .infinity)
//            .background(Color(.systemGray6))
//            .cornerRadius(12)
//            .padding(.horizontal)
//            
//            // Aircraft Cabins Row Map Scroll
//            ScrollView {
//                VStack(spacing: 20) {
//                    Text("Front of Aircraft")
//                        .font(.caption2)
//                        .fontWeight(.bold)
//                        .foregroundColor(.secondary)
//                        .tracking(2)
//                    
//                    if let layout = viewModel.selectedFlight?.cabinLayout {
//                        VStack(spacing: 10) {
//                            ForEach(1...layout.rows, id: \.self) { row in
//                                HStack(spacing: 8) {
//                                    // Left side ABC
//                                    HStack(spacing: 6) {
//                                        ForEach(["A", "B", "C"], id: \.self) { num in
//                                            let seatId = "\(row)\(num)"
//                                            if let seat = layout.seats.first(where: { $0.id == seatId }) {
//                                                SeatButton(seat: seat) {
//                                                    viewModel.toggleSeatSelection(seat: seat)
//                                                }
//                                            } else {
//                                                Spacer().frame(width: 32, height: 32)
//                                            }
//                                        }
//                                    }
//                                    
//                                    // Aisle
//                                    Text("\(row)")
//                                        .font(.caption2)
//                                        .fontWeight(.bold)
//                                        .foregroundColor(.secondary)
//                                        .frame(width: 24)
//                                    
//                                    // Right side DEF
//                                    HStack(spacing: 6) {
//                                        ForEach(["D", "E", "F"], id: \.self) { num in
//                                            let seatId = "\(row)\(num)"
//                                            if let seat = layout.seats.first(where: { $0.id == seatId }) {
//                                                SeatButton(seat: seat) {
//                                                    viewModel.toggleSeatSelection(seat: seat)
//                                                }
//                                            } else {
//                                                Spacer().frame(width: 32, height: 32)
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                        .padding()
//                    }
//                }
//            }
//            
//            // Seat Sticky Indicator Footer
//            VStack(spacing: 12) {
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text("Selected Seats")
//                            .font(.caption)
//                            .foregroundColor(.secondary)
//                        Text(viewModel.selectedSeats.isEmpty ? "None" : viewModel.selectedSeats.map { $0.id }.joined(separator: ", "))
//                            .font(.headline)
//                    }
//                    Spacer()
//                    
//                    Button(action: { navigateToDetails = true }) {
//                        Text("Confirm Seats")
//                            .fontWeight(.semibold)
//                            .foregroundColor(.white)
//                            .padding(.horizontal, 24)
//                            .padding(.vertical, 12)
//                            .background(viewModel.selectedSeats.count == viewModel.passengerCount ? Color.blue : Color.gray)
//                            .cornerRadius(12)
//                    }
//                    .disabled(viewModel.selectedSeats.count != viewModel.passengerCount)
//                }
//                .padding()
//                .background(Color(.systemBackground))
//                .cornerRadius(18)
//                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: -2)
//            }
//        }
//        .navigationTitle("Select Seats")
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationDestination(isPresented: $navigateToDetails) {
//            PassengerDetailsView(viewModel: viewModel)
//        }
//    }
//}
//
//struct LegendItem: View {
//    let label: String
//    let color: Color
//    let strokeColor: Color
//    
//    var body: some View {
//        HStack(spacing: 6) {
//            RoundedRectangle(cornerRadius: 4)
//                .fill(color)
//                .stroke(strokeColor, lineWidth: 1)
//                .frame(width: 14, height: 14)
//            Text(label)
//                .font(.caption2)
//                .foregroundColor(.secondary)
//        }
//    }
//}
//
//struct SeatButton: View {
//    let seat: Seat
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            Text(seat.number)
//                .font(.system(size: 11, weight: .bold))
//                .foregroundColor(textColor)
//                .frame(width: 32, height: 32)
//                .background(backgroundColor)
//                .cornerRadius(6)
//                .shadow(color: shadowColor, radius: 2)
//        }
//        .disabled(seat.status == .occupied)
//    }
//    
//    private var backgroundColor: Color {
//        switch seat.status {
//        case .available:
//            switch seat.cabinClass {
//            case .first, .business: return Color.blue.opacity(0.12)
//            case .premium: return Color.purple.opacity(0.12)
//            case .economy: return Color(.systemGray5)
//            }
//        case .occupied:
//            return Color.red.opacity(0.08)
//        case .selected:
//            return Color.green
//        }
//    }
//    
//    private var textColor: Color {
//        switch seat.status {
//        case .available:
//            switch seat.cabinClass {
//            case .first, .business: return .blue
//            case .premium: return .purple
//            case .economy: return .primary
//            }
//        case .occupied:
//            return .red.opacity(0.4)
//        case .selected:
//            return .white
//        }
//    }
//    
//    private var shadowColor: Color {
//        seat.status == .selected ? Color.green.opacity(0.4) : Color.clear
//    }
//}

//
//  SeatSelectionView.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 09/07/26.
//

//
//  SeatSelectionView.swift
//  SkyLink
//

//import SwiftUI
//
//@available(iOS 17.0, *)
//struct SeatSelectionView: View {
//
//    @Bindable var viewModel: FlightSearchViewModel
//
//    @State private var navigateToPassengerDetails = false
//
//    var body: some View {
//
//        VStack(spacing: 0) {
//
//            headerSection
//
//            Divider()
//
//            ScrollView(showsIndicators: false) {
//
//                VStack(spacing: 24) {
//
//                    SeatLegend()
//
//                    if viewModel.selectedFlight != nil {
//
//                        SeatMapView(viewModel: viewModel)
//
//                    } else {
//
//                        emptyState
//
//                    }
//
//                }
//                .padding(.vertical)
//
//            }
//
//            Divider()
//
//            SeatSelectionFooter(viewModel: viewModel) {
//
//                navigateToPassengerDetails = true
//
//            }
//
//        }
//        .navigationTitle("Select Seats")
//        .navigationBarTitleDisplayMode(.inline)
//        .background(Color(.systemGroupedBackground))
//        .navigationDestination(isPresented: $navigateToPassengerDetails) {
//
//            PassengerDetailsView(viewModel: viewModel)
//
//        }
//
//    }
//}
//
//// MARK: - Header
//
//private extension SeatSelectionView {
//
//    var headerSection: some View {
//
//        VStack(spacing: 16) {
//
//            Image(systemName: "airplane")
//                .font(.system(size: 42))
//                .foregroundStyle(.blue)
//
//            if let flight = viewModel.selectedFlight {
//
//                Text(flight.airline)
//                    .font(.title2.bold())
//
//                Text(flight.cabinLayout.aircraft)
//                    .font(.subheadline)
//                    .foregroundStyle(.secondary)
//
//                HStack(spacing: 20) {
//
//                    Label(
//                        "\(viewModel.passengerCount) Passenger\(viewModel.passengerCount > 1 ? "s" : "")",
//                        systemImage: "person.2.fill"
//                    )
//
//                    Label(
//                        "\(viewModel.selectedSeats.count)/\(viewModel.passengerCount)",
//                        systemImage: "checkmark.circle.fill"
//                    )
//
//                }
//                .font(.caption)
//                .foregroundStyle(.secondary)
//
//            }
//
//        }
//        .frame(maxWidth: .infinity)
//        .padding(.vertical, 24)
//
//    }
//
//    var emptyState: some View {
//
//        VStack(spacing: 12) {
//
//            Image(systemName: "airplane.circle")
//                .font(.system(size: 60))
//                .foregroundStyle(.gray)
//
//            Text("No Flight Selected")
//                .font(.headline)
//
//            Text("Please select a flight first.")
//                .foregroundStyle(.secondary)
//
//        }
//        .padding(.top, 60)
//
//    }
//
//}
//
//#Preview {
//
//    if #available(iOS 17.0, *) {
//
//        NavigationStack {
//
//            SeatSelectionView(
//                viewModel: FlightSearchViewModel()
//            )
//
//        }
//
//    }
//
//}

//
//  SeatSelectionView.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 09/07/26.
//

import SwiftUI

@available(iOS 17.0, *)
struct SeatSelectionView: View {

    @Bindable var viewModel: FlightSearchViewModel

    @State private var navigateToPassengerDetails = false

    var body: some View {

        VStack(spacing: 0) {

            if let flight = viewModel.selectedFlight {

                AircraftHeaderView(
                    aircraft: viewModel.selectedFlight?.cabinLayout.aircraft ?? "",
                    configuration: viewModel.selectedFlight?.cabinLayout.configuration ?? ""
                )
                .padding(.horizontal)

            }

            ScrollView(showsIndicators: false) {

                LazyVStack(spacing: 24) {

                    SeatLegend()
                        .padding(.horizontal)

                    if viewModel.selectedFlight != nil {

                        cabinContent

                    } else {

                        emptyView

                    }

                    SeatSelectionSummaryCard(
                        viewModel: viewModel
                    )

                }
                .padding(.vertical)

            }

            SeatSelectionFooter(
                viewModel: viewModel
            ) {

                navigateToPassengerDetails = true

            }

        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Select Seats")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(
            isPresented: $navigateToPassengerDetails
        ) {

            PassengerDetailsView(
                viewModel: viewModel
            )

        }

    }

}

// MARK: - Cabin Sections

private extension SeatSelectionView {

    var cabinContent: some View {

        VStack(spacing: 28) {

            cabinSection(.first)

            cabinSection(.business)

            cabinSection(.premium)

            cabinSection(.economy)

        }

    }

}

private extension SeatSelectionView {

    var emptyView: some View {

        VStack(spacing: 16) {

            Image(systemName: "airplane.circle.fill")
                .font(.system(size: 70))
                .foregroundStyle(.blue)

            Text("No Flight Selected")
                .font(.title3.bold())

            Text("Choose a flight to begin seat selection.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

        }
        .padding(.top, 80)

    }

}

private extension SeatSelectionView {

    @ViewBuilder
    func cabinSection(_ cabin: CabinClass) -> some View {

        let rows = rows(for: cabin)

        if !rows.isEmpty {

            VStack(spacing: 18) {

                CabinSectionHeader(
                    cabinClass: cabin
                )

                ForEach(rows, id: \.self) { row in

                    seatRow(
                        row
                    )

                }

            }
            .padding(.horizontal)

        }

    }

}

// MARK: - Seat Row Builder

private extension SeatSelectionView {

    @ViewBuilder
    func seatRow(_ row: Int) -> some View {

        HStack(spacing: 14) {

            // Left Side (A B C)
            HStack(spacing: 8) {

                seatCell(row: row, column: "A")
                seatCell(row: row, column: "B")
                seatCell(row: row, column: "C")

            }

            // Row Number
            Text("\(row)")
                .font(.caption.weight(.bold))
                .foregroundStyle(.secondary)
                .frame(width: 28)

            // Right Side (D E F)
            HStack(spacing: 8) {

                seatCell(row: row, column: "D")
                seatCell(row: row, column: "E")
                seatCell(row: row, column: "F")

            }

        }
    }

}

// MARK: - Seat Cell

private extension SeatSelectionView {

    @ViewBuilder
    func seatCell(row: Int, column: String) -> some View {

        if let seat = seat(for: row, column: column) {

            VStack(spacing: 4) {

                SeatCell(seat: seat) {

                    withAnimation(.spring(response: 0.30,
                                          dampingFraction: 0.75)) {

                        viewModel.toggleSeatSelection(
                            seat: seat
                        )

                    }

                }

                if seat.priceMarkup > 0 {

                    SeatPricingBadge(
                        seat: seat
                    )

                }

            }

        } else {

            Color.clear
                .frame(width: 44, height: 44)

        }

    }

}

// MARK: - Seat Lookup

private extension SeatSelectionView {

    func seat(
        for row: Int,
        column: String
    ) -> Seat? {

        viewModel.selectedFlight?
            .cabinLayout
            .seats
            .first {

                $0.row == row &&
                $0.number == column

            }

    }

}

// MARK: - Cabin Helpers

private extension SeatSelectionView {

    func rows(
        for cabin: CabinClass
    ) -> [Int] {

        guard let seats = viewModel.selectedFlight?
            .cabinLayout
            .seats
        else {

            return []

        }

        let rows = seats

            .filter {

                $0.cabinClass == cabin

            }

            .map {

                $0.row

            }

        return Array(Set(rows))
            .sorted()

    }

}

// MARK: - Aisle Divider

private extension SeatSelectionView {

    var aisleDivider: some View {

        Rectangle()
            .fill(
                Color.gray.opacity(0.15)
            )
            .frame(width: 2)

    }

}

// MARK: - Selected Seats

private extension SeatSelectionView {

    var selectedSeatNames: String {

        if viewModel.selectedSeats.isEmpty {

            return "None"

        }

        return viewModel.selectedSeats

            .map {

                $0.id

            }

            .joined(separator: ", ")

    }

}
