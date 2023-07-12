//
//  WeatherManager.swift
//  clima
//
//  Created by Kodeeshwari Solanki on 2023-06-29.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(weather : WeatherModel)
//    func didFailError(error : String)
}

struct WeatherManager{
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=8d885b96953125df62489f798820d2f1"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeatherByCity(city:String){
        let urlString = "\(weatherUrl)&q=\(city)"
        performRequest(urlString:urlString)
    }
    
    func fetchWeatherByCordinates(lat:Double, lon:Double){
        let urlString = "\(weatherUrl)&lat=\(lat)&lon=\(lon)"
        performRequest(urlString:urlString)
    }
    
    func performRequest(urlString:String){
        
        let url = URL(string: urlString)
//        let session = URLSession(configuration: .default)
//        let task = URLSession(configuration: .default).dataTask(with: <#T##URLRequest#>)
        
        let task = URLSession(configuration: .default).dataTask(with: url!, completionHandler: {(data:Data?, response:URLResponse?, error: Error?) in
            if let safeData = data{
                parseJson(weatherData: safeData)
            }
            if error != nil{
                print(error!)
                return
            }
        })
        task.resume()
    }
    
    func parseJson(weatherData: Data) {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let city = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let desc = decodedData.weather[0].description
            
            let weather = WeatherModel(cityName: city, temperature: temp, conditionID: id, weatherDesc: desc)
            
            delegate?.didUpdateWeather(weather: weather)
            
        } catch {
//            let error = "\(error.localizedDescription)"
//            delegate?.didFailError(error: error)
            print("Error while parsing JSON: \(error.localizedDescription)")
        }
    }
}
