import Foundation
import Observation

/// Modern iOS 17+ State Container using the brand new Swift @Observable macro
@available(iOS 17.0, *)
@Observable
class FlightSearchViewModel {
    
    // Services
    private let flightService: FlightServiceProtocol
    
    // Search Criteria
    var departureCity: String = "New York"
    var arrivalCity: String = "London"
    var departureDate: Date = Date()
    var passengerCount: Int = 1
    
    // Application States
    var flights: [Flight] = []
    var filteredFlights: [Flight] = []
    var isSearching: Bool = false
    var errorMessage: String? = nil
    
    // Booking States
    var selectedFlight: Flight? = nil
    var selectedSeats: [Seat] = []
    var passengers: [Passenger] = []
    
    // Pricing Breakdowns
    var baseFareTotal: Double {
        guard let flight = selectedFlight else { return 0.0 }
        return flight.basePrice * Double(passengerCount)
    }
    
    var seatMarkupTotal: Double {
        guard let flight = selectedFlight else { return 0 }

        return flight.cabinLayout.seats
            .filter { $0.status == .selected }
            .reduce(0) { $0 + $1.priceMarkup }
    }
    
    var taxesAndFees: Double {
        return (baseFareTotal + seatMarkupTotal) * 0.12 // 12% standard taxes
    }
    
    var grandTotal: Double {
        return baseFareTotal + seatMarkupTotal + taxesAndFees
    }
    
    init(flightService: FlightServiceProtocol = MockFlightService()) {
        self.flightService = flightService
        setupInitialPassengers()
    }
    
    func setupInitialPassengers() {
        passengers = (0..<passengerCount).map { _ in Passenger() }
    }
    
    /// Updates passenger slots dynamically when seat count / user selection updates
    func updatePassengerCount(to count: Int) {
        passengerCount = max(1, min(6, count))
        setupInitialPassengers()
        selectedSeats.removeAll()
    }
    
    /// Fetches and queries flight structures asynchronously using protocols
    func performSearch() async {
        isSearching = true
        errorMessage = nil
        
        do {
            let allFlights = try await flightService.fetchFlights()
            self.flights = allFlights
            
            // Refine flights based on departure and arrival criteria (case-insensitive)
            self.filteredFlights = allFlights.filter { flight in
                flight.departureCity.lowercased().contains(departureCity.lowercased()) &&
                flight.arrivalCity.lowercased().contains(arrivalCity.lowercased())
            }
            
            isSearching = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isSearching = false
        }
    }
    
    /// Handle seat selection logic safely
    func toggleSeatSelection(seat: Seat) {

        guard selectedFlight != nil,
              let seatIndex = selectedFlight?.cabinLayout.seats.firstIndex(where: {
                  $0.id == seat.id
              }) else {
            return
        }

        // Current seat from the flight
        var currentSeat = selectedFlight!.cabinLayout.seats[seatIndex]

        // Occupied seats cannot be selected
        guard currentSeat.status != .occupied else { return }

        // MARK: - Deselect
        if let selectedIndex = selectedSeats.firstIndex(where: { $0.id == currentSeat.id }) {

            selectedSeats.remove(at: selectedIndex)

            selectedFlight!.cabinLayout.seats[seatIndex].status = .available

            if let passengerIndex = passengers.firstIndex(where: {
                $0.assignedSeatId == currentSeat.id
            }) {
                passengers[passengerIndex].assignedSeatId = nil
            }

            return
        }

        // MARK: - Maximum seats reached
        guard selectedSeats.count < passengerCount else {
            return
        }

        // MARK: - Select
        selectedFlight!.cabinLayout.seats[seatIndex].status = .selected

        // Read updated seat
        currentSeat = selectedFlight!.cabinLayout.seats[seatIndex]

        selectedSeats.append(currentSeat)

        if let passengerIndex = passengers.firstIndex(where: {
            $0.assignedSeatId == nil
        }) {
            passengers[passengerIndex].assignedSeatId = currentSeat.id
        }
    }
    
    /// Resets booking context to facilitate new flight search routes
    func resetBookingState() {
        selectedFlight = nil
        selectedSeats.removeAll()
        setupInitialPassengers()
    }
}
