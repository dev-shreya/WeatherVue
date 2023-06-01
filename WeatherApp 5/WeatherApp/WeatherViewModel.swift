//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Shreya Bhattacharya on 18/05/23.
//

import Foundation
import Foundation

private let defaultIcon = "❓"
private let iconMap = [
  "Drizzle" : "🌧",
  "Thunderstorm" : "⛈",
  "Rain": "🌧",
  "Snow": "❄️",
  "Clear": "☀️",
  "Clouds" : "☁️",
]

class WeatherViewModel: ObservableObject {
  @Published var cityName: String = "City Name"
  @Published var temperature: String = "--"
  @Published var weatherDescription: String = "--"
  @Published var weatherIcon: String = defaultIcon
  @Published var shouldShowLocationError: Bool = false

  public let weatherService: WeatherManager

  init(weatherService: WeatherManager) {
    self.weatherService = weatherService
  }

//  func refresh() {
//    weatherService.loadWeatherData { weather, error in
//      DispatchQueue.main.async {
//        if let _ = error {
//          self.shouldShowLocationError = true
//          return
//        }
//
//        self.shouldShowLocationError = false
//        guard let weather = weather else { return }
//        self.cityName = weather.city
//        self.temperature = "\(weather.temperature)ºC"
//        self.weatherDescription = weather.description.capitalized
//        self.weatherIcon = iconMap[weather.iconName] ?? defaultIcon
//      }
//    }
//  }
}
