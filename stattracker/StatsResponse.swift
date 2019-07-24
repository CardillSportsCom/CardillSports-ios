//
//  StatsResponse.swift
//  stattracker
//
//  Created by Vithushan Namasivayasivam on 7/23/19.
//  Copyright © 2019 CardillSports. All rights reserved.
//

import Foundation

struct StatsResponse {
    let playerStatsResponses : [PlayerStatsResponse]
}

extension StatsResponse : Decodable {
    enum CodingKeys: String, CodingKey {
        case playerStatsResponses = "leagueStats"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        playerStatsResponses = try container.decode([PlayerStatsResponse].self, forKey: .playerStatsResponses)
    }
}
