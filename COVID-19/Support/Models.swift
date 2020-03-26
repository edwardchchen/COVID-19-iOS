//
//  Models.swift
//  COVID-19
//
//  Created by Edward Chen on 2020-03-26.
//  Copyright © 2020 Edward Chen. All rights reserved.
//

import Foundation
struct Countries:Decodable{
//    let id : Int
    let name : String
//    let death : Int
//    let recovered : Int
//    let infected :Int
    init(json:[String:Any]){
//        id = json["id"] as? Int ?? -1
        name = json["Taiwan*"]as? String ?? ""
//        death = json["deaths"] as? Int ?? -1
//        recovered = json["recovered"] as? Int ?? -1
//        infected = json["confirmed"] as? Int ?? -1
        
    }
}
struct Global:Decodable{
    var count : Int
    var date : String
//    let deaths :Int
//    let recovered : Int
//    let date : String
}
