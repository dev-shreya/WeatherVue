//
//  WeatherLocManager.swift
//  WeatherApp
//
//  Created by Shreya Bhattacharya on 18/05/23.
//

import Foundation
 
class weatherLocManager{
func getCurrentLocWeather(name:String) async throws -> WeatherResponse1 {
    guard let url = URL(string: "http://api.weatherapi.com/v1/forecast.json?key=eaf1e116fd964ac9bdf31232231905&q=\(name)&days=10&aqi=no&alerts=no")
            
    else{
        fatalError("Missing URL")
        //            faltalError("Missing URL")
        
    }
    let urlRequest = URLRequest(url: url)
    let (data,response) = try await URLSession.shared.data(for: urlRequest)
    guard(response as?HTTPURLResponse)?.statusCode==200
    else{
        fatalError("Error fetching weather data")
    }
    let decodedData = try JSONDecoder().decode(WeatherResponse1.self, from: data)
    
    
    return decodedData
}
                        }

struct WeatherResponse1: Decodable {
    struct Location: Decodable {
        let name: String
        let region: String
        let country: String
        let lat: Double
        let lon: Double
        let tz_id: String
        let localtime_epoch: Int
        let localtime: String
    }
    
    struct Current: Decodable {
        let last_updated_epoch: Int
        let last_updated: String
        let temp_c: Double
        let temp_f: Double
        let is_day: Int
        
        struct Condition: Decodable {
            let text: String
            let icon: String
            let code: Int
        }
        
        let condition: Condition
        let wind_mph: Double
        let wind_kph: Double
        let wind_degree: Double
        let wind_dir: String
        let pressure_mb: Double
        let pressure_in: Double
        let precip_mm: Double
        let precip_in: Double
        let humidity: Int
        let cloud: Int
        let feelslike_c: Double
        let feelslike_f: Double
        let vis_km: Int
        let vis_miles: Int
        let uv: Int
        let gust_mph: Double
        let gust_kph: Double
    }
    
    struct Forecast: Decodable {
        struct ForecastDay: Decodable {
            struct Day: Decodable {
                let maxtemp_c: Double
                let maxtemp_f: Double
                let mintemp_c: Double
                let mintemp_f: Double
                let avgtemp_c: Double
                let avgtemp_f: Double
                let maxwind_mph: Double
                let maxwind_kph: Double
                let totalprecip_mm: Double
                let totalprecip_in: Double
                let totalsnow_cm: Double
                let avgvis_km: Int
                let avgvis_miles: Int
                let avghumidity: Int
                let daily_will_it_rain: Int
                let daily_chance_of_rain: Int
                let daily_will_it_snow: Int
                let daily_chance_of_snow: Int
                
                struct Condition: Decodable {
                    let text: String
                    let icon: String
                    let code: Int
                }
                
                let condition: Condition
                let uv: Int
            }
            
            struct Astro: Decodable {
                let sunrise: String
                let sunset: String
                let moonrise: String
                let moonset: String
                let moon_phase: String
                let moon_illumination: String
                let is_moon_up: Int
                let is_sun_up: Int
            }
            
            let date: String
            let date_epoch: Int
            let day: Day
            let astro: Astro
            
        }
        
        let forecastday: [ForecastDay]
    }
    
    let location: Location
    let current: Current
    let forecast: Forecast
}
