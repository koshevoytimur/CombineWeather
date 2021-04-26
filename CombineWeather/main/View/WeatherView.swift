//
//  WeatherView.swift
//  CombineWeather
//
//  Created by Essence K on 24.04.2021.
//

import UIKit

final class WeatherView: UIView {
  // MARK: - Private Properties
  
  private let label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  private let textField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.layer.cornerRadius = 5
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.systemGray.cgColor
    let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    textField.leftView = leftView
    textField.leftViewMode = .always
    return textField
  }()
  
  // MARK: - Public Properties
  lazy var textPublisher = textField.textPublisher
  
  // MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private Methods

extension WeatherView {
  private func setupUI() {
    setupView()
    setupLabel()
    setupTextField()
  }
  
  private func setupView() {
    backgroundColor = .white
  }
  
  private func setupLabel() {
    addSubview(label)
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      label.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }
  
  private func setupTextField() {
    addSubview(textField)
    NSLayoutConstraint.activate([
      textField.topAnchor.constraint(equalTo: label.bottomAnchor,
                                     constant: 16),
      textField.leadingAnchor.constraint(equalTo: leadingAnchor,
                                         constant: 16),
      textField.trailingAnchor.constraint(equalTo: trailingAnchor,
                                          constant: -16),
      textField.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
}

// MARK: - Public Methods

extension WeatherView {
  public func showWeather(_ weather: Weather) {
    let current = weather.temp
    let min = weather.minTemp
    let max = weather.maxTemp
    label.text = "Current: \(current), min: \(min), max: \(max)"
  }
}
