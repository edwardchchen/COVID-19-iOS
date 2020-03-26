//
//  FirstViewController.swift
//  COVID-19
//
//  Created by Edward Chen on 2020-03-12.
//  Copyright © 2020 Edward Chen. All rights reserved.
//

import UIKit
import Charts
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
class FirstViewController: UIViewController {
    @IBOutlet var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
              
        let months = ["Deaths", "Infected", "Recovered"]
        let unitsSold = [55.0,12.0,33.0]
        fetchdata()
              
        setChart(dataPoints: months, values: unitsSold)
              
}
          
func setChart(dataPoints: [String], values: [Double]) {
              
              var dataEntries: [ChartDataEntry] = []
              
              for i in 0..<dataPoints.count {
                let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
                  dataEntries.append(dataEntry)
              }
              
            let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "World Data")
              let pieChartData = PieChartData(dataSet: pieChartDataSet)
              pieChartView.data = pieChartData
              
            let colors: [UIColor] = [UIColor.red,UIColor.blue,UIColor.darkGray]
            pieChartDataSet.colors = colors

          }



}
