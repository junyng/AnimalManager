//
//  Animal.swift
//  AnimalKeeper
//
//  Created by BLU on 23/10/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation
import UIKit

struct Animal: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case type
    }
    
    var cryingSound: String? {
        switch self.type {
        case .cat:
            return "야옹!"
        case .dog:
            return "멍멍!"
        default:
            return nil
        }
    }
    
    var image: UIImage {
        switch self.type {
        case .cat:
            return #imageLiteral(resourceName: "cat")
        case .dog:
            return #imageLiteral(resourceName: "dog")
        case .lizard:
            return #imageLiteral(resourceName: "lizard")
        case .parrot:
            return #imageLiteral(resourceName: "parrot")
        }
    }
    
    let name: String
    let type: AnimalType
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(AnimalType.self, forKey: .type)
    }
    
    init(name: String, type: AnimalType) {
        self.name = name
        self.type = type
    }
}

enum AnimalType: String, Codable, CustomStringConvertible, CaseIterable {
    case cat, dog, lizard, parrot
    
    var description: String {
        switch self {
        case .cat:
            return "고양이"
        case .dog:
            return "개"
        case .lizard:
            return "도마뱀"
        case .parrot:
            return "앵무새"
        }
    }
}
