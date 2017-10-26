//
//  Partner.swift
//  Umzugscoach
//
//  Created by Mikle Kusmenko on 10/25/17.
//  Copyright © 2017 mk. All rights reserved.
//

import Foundation

struct Partner {
    var name: String?
    var selected: Bool = false
    
    init(name: String?, selected: Bool = false) {
        self.name = name
        self.selected = selected
    }
    
    static func getPartners() -> [Partner] {
        return [
            Partner(name: "Deutsche Telekom"),
            Partner(name: "Techniker Krankenkasse"),
            Partner(name: "McFit Studio "),
            Partner(name: "fino digital GmbH")
        ]
    }
}
