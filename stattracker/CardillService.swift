//
//  CardillService.swift
//  stattracker
//
//  Created by Vithushan Namasivayasivam on 7/22/19.
//  Copyright © 2019 CardillSports. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CardillService: NSObject {
    
    let decoder = JSONDecoder()
    let url = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as! String
    
    func getStats(completionHandler: @escaping (StatsResponse) -> Void) {
        
        //let currentLeagueId = UserDefaults.standard.string(forKey: "current_league_id")!
        let currentLeagueId = "5bb15c65be2df207fc5a7221" //TODO stop hard coding this
        
        let idToken = UserDefaults.standard.string(forKey: "id_token")!
        
        let headers: HTTPHeaders = [
            "Authorization": idToken,
            "Accept": "application/json"
        ]
        AF.request(url + "/stat/league/" + currentLeagueId, headers: headers).responseData {
            (response) -> Void in
            
            print(try! JSON(response.result.get()))
            let statsResponse : StatsResponse = try! self.decoder.decode(StatsResponse.self, from: response.result.get())
            completionHandler(statsResponse)
        }
    }
    
    func getLeagues(completionHandler: @escaping (LeagueResponse) -> Void) {
        let idToken = UserDefaults.standard.string(forKey: "id_token")!
        let playerId = UserDefaults.standard.string(forKey: "player_id")!
        
        let headers: HTTPHeaders = [
            "Authorization": idToken,
            "Accept": "application/json"
        ]
        
        AF.request(url + "/player/leagues/" + playerId, headers: headers).responseData {
            (response) -> Void in
        
            let leagueResponse : LeagueResponse = try! self.decoder.decode(LeagueResponse.self, from: response.result.get())
            completionHandler(leagueResponse)
        }
    }
    
    func getGameDays(completionHandler: @escaping (GameDaysResponse) -> Void) {
    
        let idToken = UserDefaults.standard.string(forKey: "id_token")!
        let headers: HTTPHeaders = [
            "Authorization": idToken,
            "Accept": "application/json"
        ]
        
        //let currentLeagueId = UserDefaults.standard.string(forKey: "current_league_id")!
        let currentLeagueId = "5bb15c65be2df207fc5a7221" //TODO stop hard coding this
        
        AF.request(url + "/stat/score/" + currentLeagueId, headers: headers).responseData {
            (response) -> Void in
            let gameDaysResponse : GameDaysResponse = try! self.decoder.decode(GameDaysResponse.self, from: response.result.get())
            completionHandler(gameDaysResponse)
        }
    }
}
