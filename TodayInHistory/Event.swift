//
//  Event.swift
//  TodayInHistory
//
//  Created by Joseph Kleinschmidt on 8/20/16.
//  Copyright © 2016 Joseph Kleinschmidt. All rights reserved.
//

import UIKit

class Event {
    // MARK Properties
    var year: String
    var text: String
    var links: NSArray
    
    init?(year: String, text: String){
        self.year = year
        self.text = text
        self.links = []
    }
}
