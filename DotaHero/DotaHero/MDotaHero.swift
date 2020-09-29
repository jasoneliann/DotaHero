//
//  MDotaHero.swift
//  DotaHero
//
//  Created by Jason Elian on 26/09/20.
//  Copyright © 2020 Gua Corp. All rights reserved.
//

import Foundation

let BASE_URL: String = "https://api.opendota.com"

class MDotaHero: Decodable {
    let id: Int
    let name: String
    let imageUrl: URL?
    let roles: [Role]
    let type: AttackType
    let attribute: Attribute
    let health: Int
    let attackMax: Int
    let movementSpeed: Int
    let manaPoint: Int

    var image: Data?
    
    init(id: Int, name: String, url: String, roles: [Role], type: AttackType, attribute: Attribute, health: Int, attackMax: Int, movementSpeed: Int, manaPoint: Int) {
        self.id = id
        self.name = name
        self.image = nil
        self.roles = roles
        self.type = type
        self.attribute = attribute
        self.health = health
        self.attackMax = attackMax
        self.movementSpeed = movementSpeed
        self.manaPoint = manaPoint
        
        guard let newURL: URL = URL(string: url) else {
            self.imageUrl = nil
            return }
        self.imageUrl = newURL
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        roles = try container.decode([Role].self, forKey: .roles)
        type = try container.decode(AttackType.self, forKey: .type)
        attribute = try container.decode(Attribute.self, forKey: .attribute)
        health = try container.decode(Int.self, forKey: .health)
        attackMax = try container.decode(Int.self, forKey: .health)
        movementSpeed = try container.decode(Int.self, forKey: .movementSpeed)
        manaPoint = try container.decode(Int.self, forKey: .manaPoint)
        
        image = nil
        
        
        
        let url = try container.decode(String.self, forKey: .imageUrl)
        let newURL = URL(string: BASE_URL + url)

        imageUrl = newURL
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "localized_name"
        case imageUrl = "img"
        case image
        case roles
        
        case type = "attack_type"
        case attribute = "primary_attr"
        case health = "base_health"
        case attackMax = "base_attack_max"
        case movementSpeed = "move_speed"
        case manaPoint = "base_mana"
    }
    
    enum Role: String, Codable {
        case carry = "Carry"
        case disabler = "Disabler"
        case durable = "Durable"
        case escape = "Escape"
        case initiator = "Initiator"
        case jungler = "Jungler"
        case nuker = "Nuker"
        case pusher = "Pusher"
        case support = "Support"
    }
    
    enum AttackType: String, Codable {
        case melee = "Melee"
        case ranged = "Ranged"
    }

    enum Attribute: String, Codable {
        case agi = "agi"
        case int = "int"
        case str = "str"
    }
}
