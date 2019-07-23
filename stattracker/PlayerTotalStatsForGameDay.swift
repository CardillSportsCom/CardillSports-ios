//
//  PlayerTotalStatsForGameDay.swift
//  stattracker
//
//  Created by Vithushan Namasivayasivam on 7/23/19.
//  Copyright © 2019 CardillSports. All rights reserved.
//

import Foundation

struct PlayerTotalStatsForGameDay {
    
    let id: String
    let firstName: String
    let lastName: String
    
    let gamesPlayed: Int
    let gamesWon: Int
    
    let fieldGoalsAttempted: Int
    let fieldGoalsMade: Int
    
    let assists: Int
    let rebounds: Int
    
    let steals: Int
    let blocks: Int
    
    let turnovers: Int
}

extension PlayerTotalStatsForGameDay : Decodable {
    enum CodingKeys: String, CodingKey {
        case playerTotalStats
        
        enum PlayerTotalStatsCodingKeys: String, CodingKey {
            case gamesPlayed
            case gamesWon
            
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
        let playerStatsContainer = try container.nestedContainer(keyedBy: CodingKeys.PlayerTotalStatsCodingKeys.self, forKey: .playerTotalStats)
        let playerContainer = try container.nestedContainer(keyedBy: CodingKeys.PlayerCodingKeys.self, forKey: .player)
        
        id = try playerContainer.decode(String.self, forKey: .id)
        firstName = try playerContainer.decode(String.self, forKey: .firstName)
        lastName = try playerContainer.decode(String.self, forKey: .lastName)
        
        gamesPlayed = try playerStatsContainer.decode(Int.self, forKey: .gamesPlayed)
        gamesWon = try playerStatsContainer.decode(Int.self, forKey: .gamesWon)
        
        fieldGoalsAttempted = try playerStatsContainer.decode(Int.self, forKey: .fieldGoalsAttemped)
        fieldGoalsMade = try playerStatsContainer.decode(Int.self, forKey: .fieldsGoalsMade)
        
        assists = try playerStatsContainer.decode(Int.self, forKey: .assists)
        rebounds = try playerStatsContainer.decode(Int.self, forKey: .rebounds)
        
        steals = try playerStatsContainer.decode(Int.self, forKey: .steals)
        blocks = try playerStatsContainer.decode(Int.self, forKey: .blocks)
        
        turnovers = try playerStatsContainer.decode(Int.self, forKey: .turnovers)
    }
}
