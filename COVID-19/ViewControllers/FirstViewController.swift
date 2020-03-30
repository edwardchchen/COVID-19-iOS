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
    
    @IBOutlet weak var refreshButtonOutlet: UIButton!
    @IBAction func refreshButtonPressed(_ sender: Any) {
        refreshData()
    }
    var pickerData = ["World"]
    var confirmedDataEntry = PieChartDataEntry(value: 0)
    var deathDataEntry = PieChartDataEntry(value: 0)
    var recoveredDataEntry = PieChartDataEntry(value: 0)
    var countryMap : [String:String] = [:]

    let colors: [UIColor] = [UIColor(patternImage: #imageLiteral(resourceName: "blue")),UIColor(patternImage: #imageLiteral(resourceName: "red")),UIColor(patternImage: #imageLiteral(resourceName: "green"))]
    var selectedCountry = "World"
    let parser = JsonParser()
    var country = Countries()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        parser.fetchGlobalData(country:  country, link:"https://covidapi.info/api/v1/global")
        setLabel()
        setButtonAppeal()
        createPicker()
        setChart()
        setChartAppeal()
        parser.getCountriesList(countryList: &pickerData, countryMap: &countryMap)

    }
    func setLabel(){
        confirmedLabel.text = String(format: "Confirmed: %i cases", country.confirmed)
        deathLabel.text = String(format: "Deaths: %i cases", country.death)
        recoveredLabel.text = String(format:"Recovered: %i cases", country.recovered)
    }
    func setButtonAppeal(){
        refreshButtonOutlet.layer.cornerRadius = 25.0
        refreshButtonOutlet.layer.borderColor = UIColor.darkGray.cgColor
        refreshButtonOutlet.layer.borderWidth = 2
        refreshButtonOutlet.tintColor = UIColor.darkGray

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
        pieChartDataSet.colors = colors

        }

    func createPicker () {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        countryTextField.inputView = picker
        createTap()
    }
    //format https://covidapi.info/api/v1/country/IND/2020-03-15
    func refreshData(){
        var url : String
        let current = countryTextField.text ?? nil
        if(current=="World"){
            url = "https://covidapi.info/api/v1/global"
            parser.fetchGlobalData(country: country, link: url)
        }else{
            let alpha_three = String(countryMap[current!]!)
            url = "https://covidapi.info/api/v1/country/"+alpha_three+"/"+country.date
            parser.fetchCountryData(country: country, link: url)

        }
        
        setChart()
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

