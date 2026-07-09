//
//  Flight.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import Foundation

/// Defines the cabin class of a seat
enum CabinClass: String, Codable, CaseIterable {
    case first = "first"
    case business = "business"
    case premium = "premium"
    case economy = "economy"
    
    var displayName: String {
        switch self {
        case .first: return "First Class"
        case .business: return "Business Class"
        case .premium: return "Premium Economy"
        case .economy: return "Economy Class"
        }
    }
}

/// Defines the visual and booking state of an aircraft seat
enum SeatStatus: String, Codable {
    case available = "available"
    case occupied = "occupied"
    case selected = "selected"
}

/// Individual Airplane Seat Model
struct Seat: Codable, Identifiable, Hashable {
    let id: String // E.g., "12A"
    let row: Int
    let number: String // "A", "B", "C", "D", "E", "F"
    let cabinClass: CabinClass
    var status: SeatStatus
    let priceMarkup: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case row
        case number
        case cabinClass = "class"
        case status
        case priceMarkup
    }
}

/// Airplane Cabin Layout configuration
struct CabinLayout: Codable {
    let aircraft: String // E.g., "Boeing 787-9"
    let rows: Int
    let configuration: String // E.g. "3-3" or "2-3-2"
    var seats: [Seat]
}

/// High-level Flight Model
struct Flight: Codable, Identifiable {
    let id: String // Flight number, E.g., "FL-102"
    let airline: String
    let airlineLogo: String // System icon name or asset name
    let departureCity: String
    let departureCode: String
    let arrivalCity: String
    let arrivalCode: String
    let departureTime: Date
    let arrivalTime: Date
    let duration: String
    let basePrice: Double
    var cabinLayout: CabinLayout
    let airlineLogoUrl: String
}

/// Passenger Details Model
struct Passenger: Identifiable, Hashable {
    let id = UUID()
    var name: String = ""
    var email: String = ""
    var passportNumber: String = ""
    var assignedSeatId: String? = nil
}
