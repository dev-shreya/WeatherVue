//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Shreya Bhattacharya on 16/05/23.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            VStack(spacing: 20) {
                Text("WeatherVue")
                    .bold()
                    .font(.title)
                    .foregroundColor(.yellow)
                
                
                Text("Please share your current location to get the weather in your area")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
            }.padding(.top,70)
        }
        .multilineTextAlignment(.center)
        .padding()
        
        
        LocationButton(.shareCurrentLocation) {
            locationManager.requestLocation()
        }
        .cornerRadius(30)
        .symbolVariant(.fill)
        .foregroundColor(.white)
        Spacer()
        Spacer()
        Spacer()
        
            .tabItem {
                Image(systemName: "location")
                Text("Location")
                
            }
            .tag(0)
        
        //                         SearchButtonView()
        //                             .tabItem {
        //                                 Image(systemName: "magnifyingglass")
        //                                 Text("Search")
        //                             }
        //                             .tag(1)
            .padding(.top,30)
        
        
        
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    
    struct WelcomeView_Previews: PreviewProvider {
        static var previews: some View {
            WelcomeView()
        }
    }
}
