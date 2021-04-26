//
//  ViewController.swift
//  CombineWeather
//
//  Created by Essence K on 23.04.2021.
//

import UIKit
import Combine

class WeatherViewController: UIViewController {
  // MARK: - Private Properties
  
  private let viewModel = WeatherViewModel()
  private let weatherView = WeatherView()
  private var cancellables = Set<AnyCancellable>()
  
  override func loadView() {
    super.loadView()
    view = weatherView
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    makeBindings()
  }
}

// MARK: - Private Methods

extension WeatherViewController {
  private func makeBindings() {
    weatherView.textPublisher
      .assign(to: \.city, on: viewModel)
      .store(in: &cancellables)
    
    viewModel.$weather
      .sink { [weak weatherView] weather in
        weatherView?.showWeather(weather)
      }
      .store(in: &cancellables)
  }
}
