//
//  JsonParser.swift
//  COVID-19
//
//  Created by Edward Chen on 2020-03-26.
//  Copyright © 2020 Edward Chen. All rights reserved.
//

import Foundation
import SwiftyJSON
class JsonParser{
func fetchdata(country: Countries,link:String){
    let semaphore = DispatchSemaphore(value: 0)
    let url = URL(string:link)
    let session = URLSession.shared
        let dataTask = session.dataTask(with: url!){
        (data,response,error)in
            do{
                let json = try JSON(data: data!)
                country.confirmed = json["result"]["confirmed"].int!
                country.death = json["result"]["deaths"].int!
                country.recovered = json["result"]["recovered"].int!
            }catch{
                print("Error")
            }
        semaphore.signal()
        }

        dataTask.resume()
    _ = semaphore.wait(wallTimeout: .distantFuture)

    }
    
}
