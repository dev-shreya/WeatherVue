//
//  NewView.swift
//  WeatherApp
//
//  Created by Shreya Bhattacharya on 18/05/23.
//

import SwiftUI

struct NewView: View {
   @State var lo: String
//   @State private var weatherData: ResponseBody?
    @EnvironmentObject var locationManager: LocationManager
    var weather10: WeatherResponse1
//    let apiResponse: ResponseBody1
//    private let weatherlocmanager = weatherLocManager()
//    var weather10day  : ResponseBody1
    var body: some View {
        VStack{
//            if let weatherData = weatherData {
//                           // Display weather data using the received weatherData object
//                Text("Location: \(weatherData.name)")
//
//                           // Additional code to display other weather details...
//                       } else {
                           Text("It will be sunny for the rest of the day")
                               .foregroundColor(.white)
                               .font(Font.system(size: 14))
                               .fontWeight(.medium)
                           Divider()
                           ScrollView(.horizontal){
                               HStack{
                                   ForEach(0..<24){_ in
                                       VStack{
                                           Text(weather10.location.name)
                                               .foregroundColor(.white)
                                           Image(systemName: "cloud.sun.fill").renderingMode(.original).resizable()
                                               .aspectRatio(contentMode: .fit)
                                               .frame(width: 30,height: 30)
                                           Text("69")
                                               .foregroundColor(.white)
                                       }

//                                   }

                               }
                           }
                           .padding(10)
                       }
//                    Text("10 day forecast".uppercased())
//                    ForEach(0..<9){_ in
//                        VStack{
//                            Text("Today----☀️------58")
        
//           Initializer 'init(_:)' requires that 'ResponseBody1.LocationResponse' conform to 'StringProtocol' Text(weather10day.loc)
//                        }
                    }
//        .onAppear {
//                    // Call the API when the view appears
//                    fetchWeatherData(location: lo)
//                }
//                }
                .padding(30)
                .background(Color.orange)
    }

}


