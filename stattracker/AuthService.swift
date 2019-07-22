//
//  AuthService.swift
//  stattracker
//
//  Created by Vithushan Namasivayasivam on 7/22/19.
//  Copyright © 2019 CardillSports. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService: NSObject {
    
    func authenticate(firebaseToken: String) {
        let url = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as! String
        print(url)
        
        let parameters: Parameters = [
            "token": firebaseToken,
        ]
        AF.request(url + "/auth", method: .post, parameters: parameters).responseJSON { (response) -> Void in
      
            let json = try? JSON(response.result.get())
            let playerId = json!["player"]["id"].stringValue
            let idToken = json!["id_token"].stringValue
            
            let headers: HTTPHeaders = [
                "Authorization": idToken,
                "Accept": "application/json"
            ]
            
            AF.request(url + "/player/leagues/" + playerId, headers: headers).responseJSON { (response) -> Void in
                self.debugRequest(response: response)
            }
        }

        
        
    }
    
    func debugRequest(response: DataResponse<Any>) {
        
        print("Request: \(String(describing: response.request))")   // original url request
        print("Response: \(String(describing: response.response))") // http url response
        print("Result: \(response.result)")                         // response serialization result
        
        do {
            let json = try response.result.get()
            print("JSON: \(json)") // serialized json response
            
        } catch {
            print("ERRROR")
        }
        
        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            print("Data: \(utf8Text)") // original server data as UTF8 string
        }
    }
}
