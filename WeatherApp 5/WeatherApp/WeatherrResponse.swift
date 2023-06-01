////
////  WeatherrResponse.swift
////  WeatherApp
////
////  Created by Shreya Bhattacharya on 19/05/23.

import Foundation


struct Weather10Response: Codable {
    let data: WeatherData
}

struct WeatherData: Codable {
    let timelines: [Timeline]
}

struct Timeline: Codable,Identifiable {
    let id = UUID()
    let timestep: String
    let endTime: String
    let startTime: String
    let intervals: [Interval]
}

struct Interval: Codable,Identifiable {
    let id = UUID()
    let startTime: String
    let values: IntervalValues
}

struct IntervalValues: Codable {
    let temperature: Double
}
