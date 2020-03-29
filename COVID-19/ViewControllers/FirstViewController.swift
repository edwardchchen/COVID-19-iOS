//
//  FirstViewController.swift
//  COVID-19
//
//  Created by Edward Chen on 2020-03-12.
//  Copyright © 2020 Edward Chen. All rights reserved.
//

import UIKit
import Charts

class FirstViewController: UIViewController{
    
    @IBOutlet var pieChartView: PieChartView!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var recoveredLabel: UILabel!
    
    let pickerData = ["World","Taiwan"]
    var confirmedDataEntry = PieChartDataEntry(value: 0)
    var deathDataEntry = PieChartDataEntry(value: 0)
    var recoveredDataEntry = PieChartDataEntry(value: 0)

    
    var selectedCountry = "Taiwan"
    let parser = JsonParser()
    var country = Countries()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        parser.fetchdata(country:  country, link:"https://covidapi.info/api/v1/global")
        setLabel()
        createPicker()
        setChart()
        setChartAppeal()

    }
    func setLabel(){
        confirmedLabel.text = String(format: "Confirmed: %i cases", country.confirmed)
        deathLabel.text = String(format: "Deaths: %i cases", country.death)
        recoveredLabel.text = String(format:"Recovered: %i cases", country.recovered)
    }
    func setChartAppeal(){
        pieChartView.centerText = "COVID-19 Data"
        pieChartView.backgroundColor = UIColor.white
    }
          
    func setChart() {
        confirmedDataEntry.value = Double(country.confirmed)
        confirmedDataEntry.label = "Confirmed"
        deathDataEntry.value = Double(country.death)
        deathDataEntry.label = "Deaths"
        recoveredDataEntry.value = Double(country.recovered)
        recoveredDataEntry.label = "Recovered"
        let dataEntries = [confirmedDataEntry,deathDataEntry,recoveredDataEntry]
        let pieChartDataSet = PieChartDataSet(entries: dataEntries)
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        let colors: [UIColor] = [UIColor(patternImage: #imageLiteral(resourceName: "blue")),UIColor(patternImage: #imageLiteral(resourceName: "red")),UIColor(patternImage: #imageLiteral(resourceName: "green"))]
        pieChartDataSet.colors = colors
        }

    func createPicker () {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        countryTextField.inputView = picker
        createTap()
    }


}
extension FirstViewController : UIPickerViewDelegate, UIPickerViewDataSource {
func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}

func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
}
func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[row]
}

func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedCountry = pickerData[row]
    countryTextField.text = String(selectedCountry)
}
func createTap() {
    let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
    }
}

