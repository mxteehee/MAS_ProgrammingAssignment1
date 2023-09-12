//
//  WeatherManager.swift
//  MAS_P1_MeenaAjith
//
//

import Foundation
import CoreLocation

public final class WeatherManager: NSObject {
  
  let locationManager = CLLocationManager()
  let API_KEY = "147fe474b4c65ecfd3aa747bc9172425"
  var completionHandler : ((Weather) -> Void)?
  
  public override init() {
    super.init()
    locationManager.delegate = self
  }
  
  func loadWeatherData(_ completionHandler: @escaping((Weather) -> Void) ){
    self.completionHandler = completionHandler
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }
  
  func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D){
    guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
    
    guard let URL = URL(string: urlString) else {
        return
    }
    
    URLSession.shared.dataTask(with: URL) { data, response, error in
      guard error == nil, let data = data else {
          return
      }
      
      if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
        let wheater = Weather(response: response)
        self.completionHandler?(wheater)
      }
      
    }.resume()
  }
}

extension WeatherManager: CLLocationManagerDelegate {
  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      //print("entered")
    guard let location = locations.first else {
        return
    }
    //print(location.coordinate)
    makeDataRequest(forCoordinates: location.coordinate)
      
  }
  
  public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error: \(error.localizedDescription)")
  }
  
}

struct APIResponse: Decodable {
  let name: String
  let main: APIMain
  let weather: [APIWeather]
}

struct APIWeather: Decodable {
  
  let description: String
  let iconName: String
  enum CodingKeys: String, CodingKey {
    case description
    case iconName = "main"
  }
  
}

struct APIMain: Decodable {
  let temp: Double
}
