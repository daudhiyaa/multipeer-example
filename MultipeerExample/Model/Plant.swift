//
//  Plant.swift
//  MultipeerExample
//
//  Created by Daud on 30/05/24.
//

import Foundation
import SwiftData

@Model
class Plant: Identifiable {
    var id: UUID
    var name: String
    var desc: String
    var location: String
    
    init(id: UUID = UUID(), name: String, desc: String, location: String) {
        self.id = id
        self.name = name
        self.desc = desc
        self.location = location
    }
}
