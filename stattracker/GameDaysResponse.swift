//
//  GameDaysResponse.swift
//  stattracker
//
//  Created by Vithushan Namasivayasivam on 7/23/19.
//  Copyright © 2019 CardillSports. All rights reserved.
//

import Foundation

struct GameDaysResponse : Decodable {
    let gameDays : [GameDayResponse]
}
