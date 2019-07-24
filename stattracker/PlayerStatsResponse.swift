//
//  PlayerStatsResponse.swift
//  stattracker
//
//  Created by Vithushan Namasivayasivam on 7/23/19.
//  Copyright © 2019 CardillSports. All rights reserved.
//

import Foundation

struct PlayerStatsResponse {
    let averageStats: PlayerAverageStats
    let totalStats: PlayerTotalStatsForGameDay
}

extension PlayerStatsResponse : Decodable {
    enum CodingKeys: String, CodingKey {
        case averageStats = "playerAverageStats"
        case totalStats = "playerTotalStats"
        
        case player
        enum PlayerCodingKeys: String, CodingKey {
            case id
            case firstName
            case lastName
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)

        let averageStatsContainer = try! container.nestedContainer(keyedBy: PlayerAverageStats.CodingKeys.PlayerAverageStatsCodingKeys.self, forKey: .averageStats)
        
        let totalStatsContainer = try! container.nestedContainer(keyedBy: PlayerTotalStatsForGameDay.CodingKeys.PlayerTotalStatsCodingKeys.self, forKey: .totalStats)
        
        let playerContainer = try!
            container.nestedContainer(keyedBy: CodingKeys.PlayerCodingKeys.self, forKey: .player)
        
        let id = try! playerContainer.decode(String.self, forKey: .id)
        let firstName = try! playerContainer.decode(String.self, forKey: .firstName)
        let lastName = try! playerContainer.decode(String.self, forKey: .lastName)
        
        let gamesPlayedTotal = try! totalStatsContainer.decode(Int.self, forKey: .gamesPlayed)
        let gamesWonTotal = try! totalStatsContainer.decode(Int.self, forKey: .gamesWon)
        
        let fieldGoalsAttemptedTotal = try! totalStatsContainer.decode(Int.self, forKey: .fieldGoalsAttemped)
        let fieldGoalsMadeTotal = try! totalStatsContainer.decode(Int.self, forKey: .fieldsGoalsMade)
        
        let assistsTotal = try! totalStatsContainer.decode(Int.self, forKey: .assists)
        let reboundsTotal = try! totalStatsContainer.decode(Int.self, forKey: .rebounds)
        
        let stealsTotal = try! totalStatsContainer.decode(Int.self, forKey: .steals)
        let blocksTotal = try! totalStatsContainer.decode(Int.self, forKey: .blocks)
        
        let turnoversTotal = try! totalStatsContainer.decode(Int.self, forKey: .turnovers)
        
        totalStats = PlayerTotalStatsForGameDay(id: id, firstName: firstName, lastName: lastName, gamesPlayed: gamesPlayedTotal, gamesWon: gamesWonTotal, fieldGoalsAttempted: fieldGoalsAttemptedTotal, fieldGoalsMade: fieldGoalsMadeTotal, assists: assistsTotal, rebounds: reboundsTotal, steals: stealsTotal, blocks: blocksTotal, turnovers: turnoversTotal)
        
        let fieldGoalsAttemptedAverage = try averageStatsContainer.decode(String.self, forKey: .fieldGoalsAttemped)
        let fieldGoalsMadeAverage = try averageStatsContainer.decode(String.self, forKey: .fieldsGoalsMade)
        
        let assistsAverage = try averageStatsContainer.decode(String.self, forKey: .assists)
        let reboundsAverage = try averageStatsContainer.decode(String.self, forKey: .rebounds)
        
        let stealsAverage = try averageStatsContainer.decode(String.self, forKey: .steals)
        let blocksAverage = try averageStatsContainer.decode(String.self, forKey: .blocks)
        
        let turnoversAverage = try averageStatsContainer.decode(String.self, forKey: .turnovers)
        
        averageStats = PlayerAverageStats(id: id, firstName: firstName, lastName: lastName, fieldGoalsAttempted: fieldGoalsAttemptedAverage, fieldGoalsMade: fieldGoalsMadeAverage, assists: assistsAverage, rebounds: reboundsAverage, steals: stealsAverage, blocks: blocksAverage, turnovers: turnoversAverage)
        
    }
}
