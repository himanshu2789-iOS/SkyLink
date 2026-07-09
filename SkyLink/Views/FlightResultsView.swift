//
//  FlightResultsView.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import SwiftUI

struct FlightResultsView: View {

    @Bindable var viewModel: FlightSearchViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var navigateToSeats = false

    @State private var selectedSort = "Cheapest"

    private let sorts = [
        "Cheapest",
        "Fastest",
        "Non-stop"
    ]

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [
                    Color.blue.opacity(0.10),
                    Color.white,
                    Color.white
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            if viewModel.isSearching {

                loadingView

            } else if viewModel.filteredFlights.isEmpty {

                emptyView

            } else {

                ScrollView(showsIndicators: false) {

                    VStack(spacing: 24) {

                        headerSection

                        filterSection

                        LazyVStack(spacing: 20) {

                            ForEach(Array(viewModel.filteredFlights.enumerated()),
                                    id: \.element.id) { index, flight in

                                FlightCard(flight: flight) {

                                    viewModel.selectedFlight = flight

                                    navigateToSeats = true
                                }
                                .transition(
                                    .move(edge: .bottom)
                                    .combined(with: .opacity)
                                )
                            }

                        }

                        .padding(.horizontal)

                    }
                    .padding(.top)

                }

            }

        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)

        .navigationDestination(isPresented: $navigateToSeats) {

            if viewModel.selectedFlight != nil {

                SeatSelectionView(viewModel: viewModel)

            }

        }

    }

}

// MARK: HEADER

private extension FlightResultsView {

    var headerSection: some View {

        VStack(alignment: .leading,
               spacing: 18) {

            HStack {

                Button {

                    dismiss()

                } label: {

                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .frame(width: 42,
                               height: 42)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())

                }

                Spacer()

                Image(systemName: "slider.horizontal.3")
                    .font(.headline)
                    .frame(width: 42,
                           height: 42)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())

            }

            VStack(alignment: .leading,
                   spacing: 8) {

                Text("\(viewModel.departureCity) ✈︎ \(viewModel.arrivalCity)")
                    .font(.system(size: 34,
                                  weight: .bold,
                                  design: .rounded))

                Text("\(viewModel.filteredFlights.count) Flights Available")
                    .font(.headline)
                    .foregroundStyle(.secondary)

            }

            HStack {

                Label(
                    viewModel.departureDate.formatted(
                        date: .abbreviated,
                        time: .omitted
                    ),
                    systemImage: "calendar"
                )

                Spacer()

                Label(
                    "\(viewModel.passengerCount) Passenger",
                    systemImage: "person.fill"
                )

            }
            .font(.subheadline)
            .foregroundStyle(.secondary)

        }
        .padding(.horizontal)

    }

}

// MARK: FILTER BAR

private extension FlightResultsView {

    var filterSection: some View {

        ScrollView(.horizontal,
                   showsIndicators: false) {

            HStack(spacing: 12) {

                ForEach(sorts,
                        id: \.self) { item in

                    SortChip(
                        title: item,
                        selected: selectedSort == item
                    ) {

                        selectedSort = item

                    }

                }

            }
            .padding(.horizontal)

        }

    }

}

// MARK: LOADING

private extension FlightResultsView {

    var loadingView: some View {

        VStack(spacing: 25) {

            Spacer()

            ProgressView()
                .scaleEffect(1.5)

            Text("Searching the best fares...")
                .font(.headline)

            Text("Comparing hundreds of flights")
                .foregroundStyle(.secondary)

            Spacer()

        }

    }

}

// MARK: EMPTY

private extension FlightResultsView {

    var emptyView: some View {

        VStack(spacing: 24) {

            Spacer()

            Image(systemName: "airplane.circle.fill")
                .font(.system(size: 90))
                .foregroundStyle(.blue)

            Text("No Flights Found")
                .font(.largeTitle.bold())

            Text("Try changing your destination or travel date.")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Button {

                dismiss()

            } label: {

                Text("Modify Search")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [
                                .blue,
                                .cyan
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 18
                        )
                    )

            }
            .padding(.horizontal, 40)

            Spacer()

        }

    }

}

#Preview {

    NavigationStack {

        FlightResultsView(
            viewModel: FlightSearchViewModel()
        )

    }

}
