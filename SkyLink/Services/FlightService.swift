import Foundation

/// Protocol for flexible flight data operations
protocol FlightServiceProtocol {
    func fetchFlights() async throws -> [Flight]
}

/// Error type for Flight Services
enum FlightServiceError: Error, LocalizedError {
    case fileNotFound
    case decodingError
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound: return "Could not find mock_flights.json in Bundle."
        case .decodingError: return "Failed to successfully decode Flight structures."
        case .serverError(let msg): return "Server error: \(msg)"
        }
    }
}

/// Professional Mock Service implementing Airline Protocols
class MockFlightService: FlightServiceProtocol {
    
    func fetchFlights() async throws -> [Flight] {
        // Simulating network latency for realistic modern iOS behavior
        try await Task.sleep(nanoseconds: 800_000_000) // 0.8 seconds
        
        // Load local JSON resource
        guard let url = Bundle.main.url(forResource: "mock_flights", withExtension: "json") else {
            throw FlightServiceError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            // Set up customized JSON decoder supporting ISO8601 Date Formats
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let result = try decoder.decode([String: [Flight]].self, from: data)
            return result["flights"] ?? []
        } catch {
            print("Decoding Failed: \(error)")
            throw FlightServiceError.decodingError
        }
    }
}
