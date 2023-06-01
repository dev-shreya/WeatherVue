//
//  ContentView.swift
//  WeatherApp
//
//  Created by Shreya Bhattacharya on 07/05/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
//    @EnvironmentObject var locationManager: LocationManager
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.purple,.white], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack {
                    if let location = locationManager.location {
                        //                        Text("Your coordinates are:\(location.latitude),\(location.longitude)")
                        if let weather = weather{
                            summaryView(weather: weather)
                        }
                        else{
                            LoadingView()
                                .task {
                                    do{
                                        weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                    }
                                    catch{
                                        print("Error getting weather:\(error)")
                                    }
                                }
                        }
                     
                    }
                    else {
                        if locationManager.isLoading {
                            ProgressView()
                        } else {
                            WelcomeView()
                                .environmentObject(locationManager)
                            //                            summaryView()
                            //                                .padding(.top,50)
                            //                                .padding(.bottom,40)
                            
                            
                                .cornerRadius(30)
                                .symbolVariant(.fill)
                                .foregroundColor(.white)
                            //                            hourlyForecast()
                            //                            dailyForecastView
                        }
                    }
                    
                }
                
                
            }
//            .background(.blue)
        }
    }
   
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
