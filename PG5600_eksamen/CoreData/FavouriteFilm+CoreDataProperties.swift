//
//  FavouriteFilm+CoreDataProperties.swift
//  PG5600_eksamen
//
//  Created by Ole Martin Larsen on 29/11/2018.
//  Copyright © 2018 Høyskolen Kristiania. All rights reserved.
//
//

import Foundation
import CoreData


extension FavouriteFilm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteFilm> {
        return NSFetchRequest<FavouriteFilm>(entityName: "FavouriteFilm")
    }

    @NSManaged public var director: String?
    @NSManaged public var producer: String?
    @NSManaged public var releasedate: String?
    @NSManaged public var title: String?

}
