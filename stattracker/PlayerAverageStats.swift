//
//  PlayerAverageStatsForGameDay.swift
//  stattracker
//
//  Created by Vithushan Namasivayasivam on 7/23/19.
//  Copyright © 2019 CardillSports. All rights reserved.
//

import Foundation

struct PlayerAverageStats {
    
    let id: String
    let firstName: String
    let lastName: String
    
    let fieldGoalsAttempted: String
    let fieldGoalsMade: String
    
    let assists: String
    let rebounds: String
    
    let steals: String
    let blocks: String
    
    let turnovers: String
}

extension PlayerAverageStats : Decodable {
    enum CodingKeys: String, CodingKey {
        case playerAverageStats
        
        enum PlayerAverageStatsCodingKeys: String, CodingKey {
            
            case fieldGoalsAttemped = "FGA"
            case fieldsGoalsMade = "FGM"
            
            case assists
            case rebounds
            
            case steals
            case blocks
            
            case turnovers
        }
        
        case player
        
        enum PlayerCodingKeys: String, CodingKey {
            case id
            case firstName
            case lastName
            
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let playerStatsContainer = try container.nestedContainer(keyedBy: CodingKeys.PlayerAverageStatsCodingKeys.self, forKey: .playerAverageStats)
        let playerContainer = try container.nestedContainer(keyedBy: CodingKeys.PlayerCodingKeys.self, forKey: .player)
        
        id = try playerContainer.decode(String.self, forKey: .id)
        firstName = try playerContainer.decode(String.self, forKey: .firstName)
        lastName = try playerContainer.decode(String.self, forKey: .lastName)
        
        fieldGoalsAttempted = try playerStatsContainer.decode(String.self, forKey: .fieldGoalsAttemped)
        fieldGoalsMade = try playerStatsContainer.decode(String.self, forKey: .fieldsGoalsMade)
        
        assists = try playerStatsContainer.decode(String.self, forKey: .assists)
        rebounds = try playerStatsContainer.decode(String.self, forKey: .rebounds)
        
        steals = try playerStatsContainer.decode(String.self, forKey: .steals)
        blocks = try playerStatsContainer.decode(String.self, forKey: .blocks)
        
        turnovers = try playerStatsContainer.decode(String.self, forKey: .turnovers)
    }
}
