//
//  Models.swift
//  COVID-19
//
//  Created by Edward Chen on 2020-03-26.
//  Copyright © 2020 Edward Chen. All rights reserved.
//

import Foundation
import SwiftyJSON
class Countries{
    var date : String
    var death : Int
    var recovered : Int
    var confirmed : Int
    
    init(){
        self.date = " "
        self.death = 0
        self.recovered = 0
        self.confirmed = 0

    }
    
    init(date:String,death:Int,recovered:Int,confirmed:Int) {
        self.date = date
        self.death = death
        self.recovered = recovered
        self.confirmed = confirmed
    }
}
