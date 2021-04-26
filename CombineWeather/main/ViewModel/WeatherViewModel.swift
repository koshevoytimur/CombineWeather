//
//  ViewModel.swift
//  CombineWeather
//
//  Created by Essence K on 24.04.2021.
//

import Foundation
import Combine

class WeatherViewModel {
  // MARK: - Private Properties
  
  private let weatherClient = WeatherClient()
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - Public Properties
  
  @Published var city = ""
  @Published var weather = Weather.zeroObject
  
  // MARK: - Init
  
  init() {
    makeBindings()
  }
}

// MARK: - Private Methods

extension WeatherViewModel {
  private func makeBindings() {
    $city
      .flatMap {[weatherClient] (city: String) -> AnyPublisher<Weather, Never> in
        weatherClient.fetchWeather(for: city)
      }
      .assign(to: \.weather, on: self)
      .store(in: &cancellables)
  }
}
