//
//  SkyLinkApp.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import SwiftUI
import SwiftData
//
//@main
//struct SkyLinkApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//        .modelContainer(sharedModelContainer)
//    }
//}

import SwiftUI

@main
struct SkyLinkApp: App {
    var body: some Scene {
        WindowGroup {
            FlightSearchView()
        }
    }
}
