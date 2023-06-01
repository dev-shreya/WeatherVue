//
//  summaryView.swift
//  WeatherApp
//
//  Created by Shreya Bhattacharya on 08/05/23.
//

import SwiftUI
import CoreLocationUI

enum WeatherError: Error {
    case invalidURL
    case requestFailed
    case invalidData
    // Add more error cases as needed
}
struct summaryView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    //    @State var isShowingNewView = false
    @State private var isShowingHourlyView = false
    @State private var isShowingOtherView = false
    @State private var data: String = ""
    @State private var hourlyWeather: Weather10Response?
    //    @State var weather10: WeatherResponse1?
    var weather  :ResponseBody
    var body: some View {
        
        VStack(){
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Text(weather.name)
                .foregroundColor(.white)
                .font(Font.system(size: 32))
            
            //            HStack{
            
            Text(weather.main.feels_like.roundDouble() + "°")
                .foregroundColor(.white)
                .font(Font.system(size: 100))
                .fontWeight(.thin)
            //                    .frame(width: 20,height: 20)
            Text(weather.weather[0].description)
                .foregroundColor(.white)
                .font(Font.system(size: 18))
                .fontWeight(.medium)
            if(weather.weather[0].main == "Clouds"){
                Image(systemName: "smoke.fill").renderingMode(.original).resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90,height: 90)
            }
            else if(weather.weather[0].main == "Clear"){
                Image(systemName: "sun.max.fill").renderingMode(.original).resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80,height: 80)
            }
            else if(weather.weather[0].main == "Rain"){
                Image(systemName: "cloud.rain.fill").renderingMode(.original).resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80,height: 80)
            }
            else if(weather.weather[0].main == "Drizzle"){
                Image(systemName: "cloud.drizzle.fill").renderingMode(.original).resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80,height: 80)
            }
            else if(weather.weather[0].main == "Snow"){
                Image(systemName: "cloud.snow.fill").renderingMode(.original).resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80,height: 80)
            }
            else if(weather.weather[0].main == "Thunderstorm"){
                Image(systemName: "cloud.bolt.rain.fill").renderingMode(.original).resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80,height: 80)
            }
            
            
            //            }
            
            //            Text("High: \(weather.main.temp_max.roundDouble()) °  Low:\(weather.main.temp_min.roundDouble()) °")
            //                .multilineTextAlignment(.center)
            //                .foregroundColor(.white)
            //                .font(Font.system(size: 18))
            
            
            //        LocationButton(.shareCurrentLocation) {
            //            locationManager.requestLocation()
            //        }
            //        .cornerRadius(30)
            //        .symbolVariant(.fill)
            //        .foregroundColor(.white)
            
        }
        //        .padding(.top)
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                Text("Weather now")
                    .bold()
                    .padding(.bottom)
                
                HStack {
                    WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + ("°")))
                    Spacer()
                    WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                }
                
                HStack {
                    WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                    Spacer()
                    WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                }
                HStack{
                    WeatherRow(logo: "aqi.medium", name: "Pressure", value: (weather.main.pressure.roundDouble() + "hpa"))
                    
                    Spacer()
                                        WeatherRow(logo: "wind", name: "Wind Gust", value: (weather.wind.gust?.roundDouble() ?? "") + "m/s")
                    /* WeatherRow(logo: "humidity", name: "Humidity", value: (weather.main..roundDouble() + "%"))*/
                    
                    
                }
                //                HStack{
                //                    WeatherRow(logo: "wind", name: "Wind Gust", value: (weather.wind.gust.roundDouble() + "m/s"))
                //
                //                                      Spacer()
                //
                //                                     /* WeatherRow(logo: "humidity", name: "Humidity", value: (weather.main..roundDouble() + "%"))*/
                //
                //
                //                                  }
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            //            .padding(.bottom, 40)
            .padding(.bottom, 20)
            .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            .background(
                    Color.white
                        .opacity(0.8) // Adjust the opacity value as desired
                        .blur(radius: 10) // Apply a blur effect to create the frosted glass effect
                )
            .cornerRadius(20, corners: [.topLeft, .topRight,.bottomLeft,.bottomRight])
        }
        .padding(.top, 20)
        
        VStack {
            HStack(spacing: 30){
                Button(action: {
                    isShowingHourlyView = true
                    fetchHourlyWeatherData { result in
                        switch result {
                        case .success(let weatherResponse):
                            hourlyWeather = weatherResponse
                        case .failure(let error):
                            // Handle the error
                            print("Error fetching hourly weather data: \(error)")
                        }
                    }
                })
                {
                    Text("Hourly")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            ZStack {
                                Capsule()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.purple, Color.purple]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .overlay(
                                        Capsule()
                                            .stroke(Color.white, lineWidth: 2)
                                            .blur(radius: 4)
                                            .offset(x: 2, y: 2)
                                            .mask(
                                                Capsule()
                                                    .fill(
                                                        LinearGradient(
                                                            gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear]),
                                                            startPoint: .topLeading,
                                                            endPoint: .bottomTrailing
                                                        )
                                                    )
                                            )
                                    )
                                    .overlay(
                                        Capsule()
                                            .stroke(Color.black.opacity(0.2), lineWidth: 2)
                                            .blur(radius: 2)
                                            .offset(x: -2, y: -2)
                                            .mask(
                                                Capsule()
                                                    .fill(
                                                        LinearGradient(
                                                            gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.3)]),
                                                            startPoint: .topLeading,
                                                            endPoint: .bottomTrailing
                                                        )
                                                    )
                                            )
                                    )
                            }

                                .clipShape(Capsule())
                                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                            
                        )
                }
                Button(action:  {
                    isShowingOtherView = true
                    fetchHourlyWeatherData { result in
                        switch result {
                        case .success(let weatherResponse):
                            hourlyWeather = weatherResponse
                        case .failure(let error):
                            // Handle the error
                            print("Error fetching hourly weather data: \(error)")
                        }
                    }
                }) {
                    Text("Upcoming Days")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            ZStack {
                                Capsule()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.purple, Color.purple]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .overlay(
                                        Capsule()
                                            .stroke(Color.white, lineWidth: 2)
                                            .blur(radius: 4)
                                            .offset(x: 2, y: 2)
                                            .mask(
                                                Capsule()
                                                    .fill(
                                                        LinearGradient(
                                                            gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear]),
                                                            startPoint: .topLeading,
                                                            endPoint: .bottomTrailing
                                                        )
                                                    )
                                            )
                                    )
                                    .overlay(
                                        Capsule()
                                            .stroke(Color.black.opacity(0.2), lineWidth: 2)
                                            .blur(radius: 2)
                                            .offset(x: -2, y: -2)
                                            .mask(
                                                Capsule()
                                                    .fill(
                                                        LinearGradient(
                                                            gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.3)]),
                                                            startPoint: .topLeading,
                                                            endPoint: .bottomTrailing
                                                        )
                                                    )
                                            )
                                    )
                            }

                                .clipShape(Capsule())
                                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                            
                        )
                }
            }
        } .padding(.top, 30)
        
        //        .fullScreenCover(isPresented: $isShowingHourlyView) {
        //            if let hourlyWeather = hourlyWeather {
        //                HourlyView(weather: hourlyWeather)
        //            } else {
        //                ProgressView()
        //            }
        //        }
        .fullScreenCover(isPresented: $isShowingHourlyView) {
            NavigationView {
                if let hourlyWeather = hourlyWeather {
                    HourlyView(weather: hourlyWeather)
                } else {
                    ProgressView()
                }
            }
        }
        .fullScreenCover(isPresented: $isShowingOtherView) {
            NavigationView {
                if let hourlyWeather = hourlyWeather {
                    TenDayView(weather: hourlyWeather)
                } else {
                    ProgressView()
                }
            }
            
        }
       
        //              }
        //          })
        //        .fullScreenCover(isPresented: $isShowingNewView, content: {
        //            NewView(lo: weather.name, weather10: WeatherResponse1)
        //        })
        //
        
    }
    //    private func fetchHourlyWeatherData() {
    //         let apiKey = "eaf1e116fd964ac9bdf31232231905"
    //         let locationQuery = "London"
    //         let days = 10
    //        let urlString = "https://api.openweathermap.org/data/3.0/onecall?lat=37.785834&lon=-122.406417&appid=697607454c071b1a149e321048653fb0&units=metric"
    //
    //         guard let url = URL(string: urlString) else { return }
    //
    //         URLSession.shared.dataTask(with: url) { (data, response, error) in
    //             if let error = error {
    //                 print("Error: \(error.localizedDescription)")
    //             } else if let data = data {
    //                 if let weatherResponse = try? JSONDecoder().decode(Weather10Response.self, from:
    func fetchHourlyWeatherData(completion: @escaping (Result<Weather10Response, Error>) -> Void) {
        let urlString = "https://api.tomorrow.io/v4/timelines?location=\(weather.coord.lat),\(weather.coord.lon)&fields=temperature&timesteps=1h&units=metric&apikey=iO5GVMe36T17kD0MBolQLR5B8uhp3C71"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(WeatherError.invalidURL))
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(WeatherError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let weatherResponse = try decoder.decode(Weather10Response.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    

    
    struct summaryView_Previews: PreviewProvider {
        static var previews: some View {
            ScrollView{
                HStack{
                    Spacer()
                    summaryView(weather: previewWeather)
                    Spacer()
                }.padding(.top,60)
                
            }
            .background(.blue)
        }
    }
    
}
