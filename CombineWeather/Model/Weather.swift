//
//  Weather.swift
//  CombineWeather
//
//  Created by Essence K on 23.04.2021.
//

import Foundation

struct WeatherResponse: Codable {
  let main: Weather
  
  static var zeroObject: WeatherResponse {
    WeatherResponse(main: Weather.zeroObject)
  }
}

struct Weather: Codable {
  let temp: Double
  let minTemp: Double
  let maxTemp: Double
  
  enum CodingKeys: String, CodingKey {
    case temp
    case minTemp = "temp_min"
    case maxTemp = "temp_max"
  }
  
  static var zeroObject: Weather {
    Weather(temp: 0, minTemp: 0, maxTemp: 0)
  }
}
