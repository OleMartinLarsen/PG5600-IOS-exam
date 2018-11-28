//
//  FavouriteCharacter+CoreDataProperties.swift
//  PG5600_eksamen
//
//  Created by Ole Martin Larsen on 27/11/2018.
//  Copyright © 2018 Høyskolen Kristiania. All rights reserved.
//
//

import Foundation
import CoreData


extension FavouriteCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteCharacter> {
        return NSFetchRequest<FavouriteCharacter>(entityName: "FavouriteCharacter")
    }

    @NSManaged public var name: String?
    @NSManaged public var films: String?

}
