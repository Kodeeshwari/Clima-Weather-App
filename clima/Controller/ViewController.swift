//
//  ViewController.swift
//  clima
//
//  Created by Kodeeshwari Solanki on 2023-06-29.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var lblWeatherCondition: UILabel!
    
    @IBOutlet weak var conditionImage: UIImageView!
    
    @IBOutlet weak var lblTemperature: UILabel!
    
    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var txtSearchField: UITextField!
    
    let locationManager = CLLocationManager()
    
    var weatherManager = WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtSearchField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    @IBAction func btnLiveLocationPresses(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        locationManager.stopUpdatingLocation()
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
            let weatherTemp = String(format: "%.1f", weather.temperature)
            self.lblTemperature.text = weatherTemp
            self.lblCity.text = weather.cityName
        }
    }
    
//    func didFailError(error: String) {
//        DispatchQueue.main.async {
//            
//        }
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
                return
            }
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        weatherManager.fetchWeatherByCordinates(lat: lat, lon: lon)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        printContent(error.localizedDescription)
    }
    
}

