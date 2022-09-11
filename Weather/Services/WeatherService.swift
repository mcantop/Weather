//
//  WeatherService.swift
//  Weather
//
//  Created by Maciej on 11/09/2022.
//

import Foundation
import CoreLocation

class WeatherService {
    func getCurrentWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees) async throws -> ResponseBody {
        let apiKey = "d34574faffa9ee24e173a6f68a3b7689"
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longtitude)&appid=\(apiKey)&units=metric") else { fatalError("Missing URL.") }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data.") }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

struct ResponseBody: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Cloud
    let dt: Date
    let sys: Sy
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
  struct Coord: Codable {
    let lon: Double
    let lat: Double
  }

  struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
  }

  struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    let seaLevel: Int?
    let grndLevel: Int?

    private enum CodingKeys: String, CodingKey {
      case temp
      case feelsLike = "feels_like"
      case tempMin = "temp_min"
      case tempMax = "temp_max"
      case pressure
      case humidity
      case seaLevel = "sea_level"
      case grndLevel = "grnd_level"
    }
  }

  struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
  }

  struct Cloud: Codable {
    let all: Int
  }

  struct Sy: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Date
    let sunset: Date
  }
}
