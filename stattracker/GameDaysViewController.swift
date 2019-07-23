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

    var gameDays = [GameDayResponse]()
    var firebaseViewController = FirebaseViewController();
    var cardillService = CardillService()
    var authService = AuthService()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (firebaseViewController.getCurrentUser() != nil) {
            firebaseViewController.getTokenForCurrentUser(completionHandler: {firebaseToken in
                self.authService.authenticate(firebaseToken: firebaseToken, completionHandler: {authResponse  in
                    
                    UserDefaults.standard.set(authResponse.idToken, forKey: "id_token")
                    UserDefaults.standard.set(authResponse.playerId, forKey: "player_id")
                    
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
            let titleString = self.gameDays[indexPath!.row].gameDate
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
        
        cell.textLabel?.text = gameDay.gameDate
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "showBoxScore", sender: self)
    }
    
    func fetchGameDays() {
        cardillService.getLeagues(completionHandler: { leagueResponse in
            self.leaguesDidLoad(leagueResponse: leagueResponse)
            self.cardillService.getGameDays(completionHandler: {gameDayResponse in
                self.gameDays = gameDayResponse.gameDays
                self.tableView.reloadData()
            })
        })
    }
    
  
    func leaguesDidLoad(leagueResponse: LeagueResponse) {
        let leagueID = leagueResponse.leagues[0].id
        UserDefaults.standard.set(leagueID, forKey: "current_league_id")
    }

}

