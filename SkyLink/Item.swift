//
//  Item.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
