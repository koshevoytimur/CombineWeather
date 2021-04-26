//
//  WeatherClient.swift
//  CombineWeather
//
//  Created by Essence K on 23.04.2021.
//

import Foundation
import Combine

enum WeatherError: Error {
  case network
}

class WeatherClient {
  public func fetchWeather(for city: String) -> AnyPublisher<Weather, Never> {
    guard let url = makeWeatherUrl(for: city) else {
      return
        Just(Weather.zeroObject)
        .eraseToAnyPublisher()
    }
    return
      URLSession.shared.dataTaskPublisher(for: url)
      .map { $0.data }
      .decode(type: WeatherResponse.self, decoder: JSONDecoder())
      .catch { error in Just(WeatherResponse.zeroObject) }
      .map { $0.main }
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }
  
}

extension WeatherClient {
  private func makeWeatherUrl(for city: String) -> URL? {
    guard let queryUrl = URL(string: Constants.baseUrlString) else {
      return nil
    }
    let queryItems = [
      URLQueryItem(name: "appid", value: Constants.apiKey),
      URLQueryItem(name: "units", value: Constants.units),
      URLQueryItem(name: "q", value: city)
    ]
    var components = URLComponents(url: queryUrl, resolvingAgainstBaseURL: true)
    components?.queryItems = queryItems
    return components?.url
  }
}

extension WeatherClient {
  enum Constants {
    static let baseUrlString = "http://api.openweathermap.org/data/2.5/weather"
    static let apiKey = "842f3d1ca39ef9897274e5540d4640a6"
    static let units = "metric"
  }
}


