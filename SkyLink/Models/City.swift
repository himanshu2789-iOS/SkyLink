//
//  City.swift.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 09/07/26.
//

struct City: Identifiable, Hashable {
    var id: String { code }
    let name: String
    let code: String
}

extension City {
    static let all: [City] = [
        City(name: "New York", code: "JFK"),
        City(name: "London", code: "LHR"),
        City(name: "Paris", code: "CDG"),
        City(name: "San Francisco", code: "SFO"),
        City(name: "Tokyo", code: "HND"),
        City(name: "Dubai", code: "DXB"),
        City(name: "Doha", code: "DOH"),
        City(name: "Singapore", code: "SIN"),
        City(name: "Los Angeles", code: "LAX"),
        City(name: "Frankfurt", code: "FRA"),
        City(name: "Chicago", code: "ORD"),
        City(name: "Sydney", code: "SYD"),
        City(name: "Hong Kong", code: "HKG"),
        City(name: "Amsterdam", code: "AMS"),
        City(name: "Toronto", code: "YYZ"),
        City(name: "Mumbai", code: "BOM"),
        City(name: "Delhi", code: "DEL"),
        City(name: "Bangkok", code: "BKK"),
        City(name: "Istanbul", code: "IST"),
        City(name: "Rome", code: "FCO")
    ]
}
