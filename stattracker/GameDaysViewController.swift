//
//  GameDaysViewController.swift
//  stattracker
//
//  Created by Vithushan Namasivayasivam on 7/21/19.
//  Copyright © 2019 CardillSports. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import SwiftyJSON

class GameDaysViewController: UITableViewController, FUIAuthDelegate {

    var gameDays = [GameDay]()
    var firebaseViewController = FirebaseViewController();
    var cardillService = CardillService()
    var authService = AuthService()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (firebaseViewController.getCurrentUser() != nil) {
            firebaseViewController.getTokenForCurrentUser(completionHandler: {firebaseToken in
                self.authService.authenticate(firebaseToken: firebaseToken, completionHandler: {idToken, playerId  in
                    UserDefaults.standard.set(idToken, forKey: "id_token")
                    UserDefaults.standard.set(playerId, forKey: "player_id")
                    
                    self.fetchGameDays()
                })
            })
            
        } else {
           firebaseViewController.handleNoUser(withDelegate: self)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "showBoxScore") {
        
            let upcoming: BoxScoreViewController = segue.destination
                as! BoxScoreViewController
            // indexPath is set to the path that was tapped
            let indexPath = self.tableView.indexPathForSelectedRow
            // titleString is set to the title at the row in the objects array.
            let titleString = self.gameDays[indexPath!.row].title
            // the titleStringViaSegue property of NewViewController is set.
            upcoming.titleStringViaSegue = titleString
            upcoming.boxScoreViaSegue = self.gameDays[indexPath!.row]
            self.tableView.deselectRow(at: indexPath!, animated: true)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameDays.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "GameDayTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GameDayTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let gameDay = gameDays[indexPath.row]
        
        cell.textLabel?.text = gameDay.title;
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "showBoxScore", sender: self)
    }
    
    func fetchGameDays() {
        
        let playerId = UserDefaults.standard.string(forKey: "player_id")!
        
        cardillService.getLeagues(withPlayerId: playerId, completionHandler: {leagueResponse in
            self.leaguesDidLoad(leagueResponse: leagueResponse)
            self.cardillService.getGameDays(completionHandler: {gameDayResponse in
                var loadedGameDays = [GameDay]()
                for gameDay in gameDayResponse["gameDays"].arrayValue {
                    loadedGameDays.append(GameDay(withTitle: gameDay["gameDate"].stringValue))
                }
                self.gameDays = loadedGameDays
                self.tableView.reloadData()
            })
        })
    }
    
  
    func leaguesDidLoad(leagueResponse: JSON) {
        let leagueID = leagueResponse["leagues"][0]["_id"].stringValue
        UserDefaults.standard.set(leagueID, forKey: "current_league_id")
    }

}

