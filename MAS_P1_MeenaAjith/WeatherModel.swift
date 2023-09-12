//
//  WeatherModel.swift
//  MAS_P1_MeenaAjith
//
//

import Foundation

class WeatherModel: ObservableObject {
    
    @Published var cityName: String = "City Name"
    @Published var temperature: String = "--"
    @Published var weatherDescription: String = "--"
    @Published var iconName: String = "default"
    
    public let weatherManager: WeatherManager
    
    init(weatherManager: WeatherManager){
        self.weatherManager = weatherManager
    }
    
    func refresh(){
        weatherManager.loadWeatherData{ weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temperature = "\(weather.temperature)"
                self.weatherDescription = weather.description.capitalized
                self.iconName = weather.iconName.lowercased()
            }
            
        }
    }
}
