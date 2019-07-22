//
//  FirstViewController.swift
//  stattracker
//
//  Created by Vithushan Namasivayasivam on 7/21/19.
//  Copyright © 2019 CardillSports. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class FirstViewController: UIViewController, FUIAuthDelegate {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (Auth.auth().currentUser != nil) {
            authenticateAndGetLeagues(user: Auth.auth().currentUser!)
        } else {
           handleNoUser()
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        // handle user and error as necessary
        print("VITHUSHAN")
    }
    
    func authenticateAndGetLeagues(user: User) {
        print(user.email)
        user.getIDToken { (idToken, error) in
            print(idToken)
            let defaults = `UserDefaults`.standard
            
            defaults.set(idToken, forKey: "idToken")
            defaults.synchronize()
            
            let authService = AuthService()
            authService.authenticate(firebaseToken: idToken!)
            
        }
    }
    
    func handleNoUser() {
        let authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI?.delegate = self
        
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth()
        ]
        authUI!.providers = providers
        let authViewController = authUI!.authViewController()
        self.present(authViewController, animated: true)
    }

}

