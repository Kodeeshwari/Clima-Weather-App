//
//  ViewController.swift
//  clima
//
//  Created by Kodeeshwari Solanki on 2023-06-29.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    
    
    @IBOutlet weak var lblWeatherCondition: UILabel!
    
    @IBOutlet weak var conditionImage: UIImageView!
    
    @IBOutlet weak var lblTemperature: UILabel!
    
    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var txtSearchField: UITextField!
    
    var weatherManager = WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearchField.delegate = self
        weatherManager.delegate = self
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        if let city = txtSearchField.text{
            weatherManager.fetchWeatherByCity(city: city)
        }
        txtSearchField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if txtSearchField.text != nil{
            txtSearchField.endEditing(true)
            return true
        }
        else{
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason){
        if txtSearchField.text != nil {
            // print(txtSearchField.text!)
            txtSearchField.text = ""
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if txtSearchField.text == "" {
            return true
        }
        else{
            return false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        txtSearchField.placeholder = "Type city name"
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.lblWeatherCondition.text = weather.weatherDesc
            
            let symbolName = weather.description
            self.conditionImage.image = UIImage(systemName: symbolName)
            
            self.lblCity.text = weather.cityName
            
            let weatherTemp = weather.temperature
            self.lblTemperature.text = String(format: "%.1f", weatherTemp)
        }
    }
    
}

