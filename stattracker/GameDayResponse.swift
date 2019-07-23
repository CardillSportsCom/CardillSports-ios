//
//  GameDayResponse.swift
//  stattracker
//
//  Created by Vithushan Namasivayasivam on 7/23/19.
//  Copyright © 2019 CardillSports. All rights reserved.
//

import Foundation

struct GameDayResponse {
    let gameDate: String
    let playerStats: [PlayerTotalStatsForGameDay]
}

extension GameDayResponse : Decodable {
    
    enum CodingKeys: String, CodingKey {
        case gameDate
        case playerStatsForGameDay = "gameDayStatTotals"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gameDate = try container.decode(String.self, forKey: .gameDate)
        playerStats = try container.decode([PlayerTotalStatsForGameDay].self, forKey: .playerStatsForGameDay)
    }
}
