//
//  Character.swift
//  PG5600_eksamen
//
//  Created by Ole Martin Larsen on 26/11/2018.
//  Copyright © 2018 Høyskolen Kristiania. All rights reserved.
//

import Foundation

struct CharacterRoot: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Character]
}

struct Character: Decodable {
    let name: String?
}
