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
    
    let decoder = JSONDecoder()
    
    func authenticate(firebaseToken: String, completionHandler: @escaping (AuthResponse) -> Void) {
        let url = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as! String
        
        let parameters: Parameters = [
            "token": firebaseToken,
        ]
        AF.request(url + "/auth", method: .post, parameters: parameters).responseData { (response) -> Void in
      
            let authResponse : AuthResponse = try! self.decoder.decode(AuthResponse.self, from: response.result.get())
            completionHandler(authResponse)
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
