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
func fetchGlobalData(country: Countries,link:String){
    let semaphore = DispatchSemaphore(value: 0)
    let url = URL(string:link)
    let session = URLSession.shared
        let dataTask = session.dataTask(with: url!){
        (data,response,error)in
            do{
                let json = try JSON(data: data!)
                country.date = json["date"].string!
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
    
    func fetchCountryData(country: Countries,link:String){
        let semaphore = DispatchSemaphore(value: 0)
        let url = URL(string:link)
        let session = URLSession.shared
            let dataTask = session.dataTask(with: url!){
            (data,response,error)in
                do{
                    let json = try JSON(data: data!)
                    country.confirmed = json["result"][country.date]["confirmed"].int!
                    country.death = json["result"][country.date]["deaths"].int!
                    country.recovered = json["result"][country.date]["recovered"].int!
                }catch{
                    print("Error")
                }
            semaphore.signal()
            }

            dataTask.resume()
        _ = semaphore.wait(wallTimeout: .distantFuture)

    }
    func getCountriesList(countryList:inout [String], countryMap : inout [String : String]){
        if let path = Bundle.main.path(forResource: "countriesList", ofType: "json") {
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSON(data:data)
                for (_,subJson):(String, JSON) in json {
                    let countryName = subJson["name"].string
                    let countryCode = subJson["alpha-3"].string
                    countryList.append(countryName!)
                    countryMap[countryName!] = countryCode!
                }
            }catch{
                print("error")
            }
        }

    }
    func getLatestDate()->String{
        let semaphore = DispatchSemaphore(value: 0)
        var date = "NULL"
        let url = URL(string:"https://covidapi.info/api/v1/latest-date")
        let session = URLSession.shared
            let dataTask = session.dataTask(with: url!){
            (data,response,error)in
                do{
                    let json = try JSON(data: data!)
                    date = json[0].string ?? "NULL"
                    print(date)
                }catch{
                    print("Error")
                }
            semaphore.signal()
            }

            dataTask.resume()
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return date

    }
    
    
}
