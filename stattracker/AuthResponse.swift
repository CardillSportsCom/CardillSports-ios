//
//  AuthResponse.swift
//  stattracker
//
//  Created by Vithushan Namasivayasivam on 7/23/19.
//  Copyright © 2019 CardillSports. All rights reserved.
//

import Foundation

struct AuthResponse {
    let idToken : String
    let playerId : String
}

extension AuthResponse : Decodable {
    enum CodingKeys: String, CodingKey {
        case idToken = "id_token"
        case player
        
        enum PlayerKeys: String, CodingKey {
            case id = "_id"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idToken = try! container.decode(String.self, forKey: .idToken)
        
        let playerContainer = try container.nestedContainer(keyedBy: CodingKeys.PlayerKeys.self, forKey: .player)
        playerId = try! playerContainer.decode(String.self, forKey: .id)
    }
}
