//
//  User+CoreDataProperties.swift
//  TodayInHistory
//
//  Created by Joseph Kleinschmidt on 8/19/16.
//  Copyright © 2016 Joseph Kleinschmidt. All rights reserved.
//

import Foundation
import CoreData

extension User {
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var email: String?
    @NSManaged var password: String?
}