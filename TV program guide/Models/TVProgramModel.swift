//
//  TVProgramModel.swift
//  TV program guide
//
//  Created by Александр on 21.01.2022.
//

import Foundation

struct TVProgram: Decodable {
    let channels: [Channel]
}

struct Channel: Decodable {
    let name: String
    let image: String
    let current: Current?
    
    enum CodingKeys: String, CodingKey {
        case name = "name_ru"
        case image
        case current
    }
}

struct Current: Decodable {
    let title: String
}


