//
//  UITextField+Extension.swift
//  CombineWeather
//
//  Created by Essence K on 24.04.2021.
//

import UIKit
import Combine

extension UITextField {
  var textPublisher: AnyPublisher<String, Never> {
    NotificationCenter.default
      .publisher(for: UITextField.textDidChangeNotification, object: self)
      .compactMap { $0.object as? UITextField }
      .map { $0.text ?? "" }
      .eraseToAnyPublisher()
  }
}
