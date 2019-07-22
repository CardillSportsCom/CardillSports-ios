//
//  FirebaseViewController.swift
//  stattracker
//
//  Created by Vithushan Namasivayasivam on 7/22/19.
//  Copyright © 2019 CardillSports. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import FirebaseUI

class FirebaseViewController: UIViewController {
    
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    func getTokenForCurrentUser(completionHandler: @escaping (String) -> Void) {
        getCurrentUser()!.getIDToken { (firebaseToken, error) in
            if (firebaseToken == nil || error != nil) {
                print("COULD NOT GET FIREBASE TOKEN")
            } else {
                completionHandler(firebaseToken!)
            }
        }
    }
    
    func handleNoUser(withDelegate delegate : FUIAuthDelegate) {
        let authUI = FUIAuth.defaultAuthUI()
        
        authUI?.delegate = delegate
        
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth()
        ]
        authUI!.providers = providers
        let authViewController = authUI!.authViewController()
        self.present(authViewController, animated: true)
    }
}
