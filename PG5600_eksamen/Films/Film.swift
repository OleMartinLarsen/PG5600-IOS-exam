//
//  Film.swift
//  PG5600_eksamen
//
//  Created by Ole Martin Larsen on 26/11/2018.
//  Copyright © 2018 Høyskolen Kristiania. All rights reserved.
//

import Foundation

struct FilmRoot: Decodable {
    let count: Int?
    let next: Int?
    let previous: Int?
    let results: [Film]
}

struct Film: Decodable {
    let title: String?
    let director: String?
    let producer: String?
    let release_date: String?
}
