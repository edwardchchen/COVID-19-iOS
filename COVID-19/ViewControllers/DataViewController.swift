//
//  DataViewController.swift
//  COVID-19
//
//  Created by Edward Chen on 2020-03-12.
//  Copyright © 2020 Edward Chen. All rights reserved.
//

import UIKit
import Charts

class DataViewController: UIViewController{
    
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
        self.view.backgroundColor=UIColor(patternImage: #imageLiteral(resourceName: "white"))
        setLabel()
        setLabelButtonAppeal()
        
        createPicker()
        setChart()
        setChartAppeal()
        parser.getCountriesList(countryList: &pickerData, countryMap: &countryMap)

    }
    func setLabel(){
        confirmedLabel.text = String(format: "Confirmed:\n%i", country.confirmed)
        deathLabel.text = String(format: "Deaths:\n%i", country.death)
        recoveredLabel.text = String(format:"Recovered:\n%i", country.recovered)
    }
    func setLabelButtonAppeal(){
        refreshButtonOutlet.layer.cornerRadius = 25.0
        refreshButtonOutlet.layer.borderColor = UIColor.darkGray.cgColor
        refreshButtonOutlet.layer.borderWidth = 1
        refreshButtonOutlet.tintColor = UIColor.darkGray
        
        labelappeal(label: deathLabel)
        deathLabel.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "red-light"))
        labelappeal(label: confirmedLabel)
        confirmedLabel.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "blue-light"))
        labelappeal(label: recoveredLabel)
        recoveredLabel.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "green-light"))


    }
    func labelappeal(label : UILabel){
        label.layer.cornerRadius = 25.0
    }
    
    func setChartAppeal(){
        pieChartView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "white"))
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
        pieChartView.centerText = selectedCountry

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
        setLabel()
    }


}
extension DataViewController : UIPickerViewDelegate, UIPickerViewDataSource {
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

