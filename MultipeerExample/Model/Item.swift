//
//  Item.swift
//  MultipeerExample
//
//  Created by Daud on 30/05/24.
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
