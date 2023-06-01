//
//  HourlyView.swift
//  WeatherApp
//
//  Created by Shreya Bhattacharya on 19/05/23.
//

import SwiftUI


    
struct HourlyView: View {
    let weather: Weather10Response
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
        ScrollView {
         
                VStack(spacing: 12) {
                    //                Button(action: {
                    //                             presentationMode.wrappedValue.dismiss()
                    //                         }) {
                    //                             Text("")
                    //                         }
                    //                     }
                    //                     .navigationBarTitle("Hourly View")
                    ForEach(weather.data.timelines) { timeline in
                        VStack(spacing: 8) {
//                            ForEach(timeline.intervals) { interval in
                            ForEach(timeline.intervals.filter { isToday(dateString: $0.startTime) }) { interval in

                                HStack {
                                    Image(systemName: weatherImageName(for: interval.values.temperature))
                                        .font(.system(size: 20))
                                        .foregroundColor(weatherImageColor(for: interval.values.temperature))
                                        .padding(.leading, 16)
                                    
                                    Text(formattedDateTime(from: interval.startTime))
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.leading, 8)
                                    
                                    Spacer()
                                    
                                    Text("\(formattedTemperature(interval.values.temperature))°C")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .padding(.trailing, 16)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color(hue: 0.8, saturation: 0.82, brightness: 0.9),
                                                    Color(hue: 0.8, saturation: 0.82, brightness: 0.7)
                                                ]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        ) .blur(radius: 2)
                                        .shadow(
                                            color: Color.black.opacity(0.2),
                                            radius: 8,
                                            x: 0,
                                            y: 4
                                        )
                                )
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                }
//                Spacer()
            }
        
            .navigationBarTitle("Hourly Weather")
                        .navigationBarItems(leading: Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title)
                        })
        }
            .padding(.vertical, 12)
        }
    }
    
    private func formattedDateTime(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM d, h:mm a"
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
private func isToday(dateString: String) -> Bool {
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
     
     if let date = dateFormatter.date(from: dateString) {
         return Calendar.current.isDateInToday(date)
     }
     
     return false
 }
    private func formattedTemperature(_ temperature: Double) -> String {
        return String(format: "%.2f", temperature)
    }
    
    private func weatherImageName(for temperature: Double) -> String {
        if temperature > 20 {
            return "sun.max.fill"
        } else {
            return "cloud.fill"
        }
    }
    
    private func weatherImageColor(for temperature: Double) -> Color {
        if temperature > 20 {
            return .yellow
        } else {
            return .white
        }
    }



    struct HourlyView_Previews: PreviewProvider {
        static var previews: some View {
            let sampleWeather = Weather10Response(
                data: WeatherData(
                    timelines: [
                        Timeline(
                            timestep: "1h",
                            endTime: "2023-05-24T18:00:00Z",
                            startTime: "2023-05-19T18:00:00Z",
                            intervals: [
                                Interval(
                                    startTime: "2023-05-19T18:00:00Z",
                                    values: IntervalValues(temperature: 17.88)
                                ),
                                Interval(
                                    startTime: "2023-05-19T19:00:00Z",
                                    values: IntervalValues(temperature: 20.47)
                                )
                            ]
                        )
                    ]
                )
            )
            
            HourlyView(weather: sampleWeather)
        }
    }

