//
//  Model.swift
//  APIExercise
//
//  Created by THUY Nguyen Duong Thu on 8/31/20.
//  Copyright © 2020 THUY Nguyen Duong Thu. All rights reserved.
//

import Foundation

struct LocationData: Codable {
    var data: [Location]
}
struct Location: Codable {
    let userName: String
    let image: String
    let location: String
    let age: Int
    let gender: String
}
