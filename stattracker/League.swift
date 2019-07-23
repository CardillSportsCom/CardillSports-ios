//
//  League.swift
//  stattracker
//
//  Created by Vithushan Namasivayasivam on 7/23/19.
//  Copyright © 2019 CardillSports. All rights reserved.
//

import Foundation

struct League {
    let id: String
    let name: String
    
}

extension League : Decodable {
    enum CodingKeys: String, CodingKey {
        case league
        
        enum LeagueKeys: String, CodingKey {
            case id = "_id"
            case name
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let leaguesContainer = try container.nestedContainer(keyedBy: CodingKeys.LeagueKeys.self, forKey: .league)
        name = try leaguesContainer.decode(String.self, forKey: .name)
        id = try leaguesContainer.decode(String.self, forKey: .id)
        
    }
}
