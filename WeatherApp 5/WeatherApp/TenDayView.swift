//
//  TenDayView.swift
//  WeatherApp
//
//  Created by Shreya Bhattacharya on 19/05/23.
//

import SwiftUI



struct TenDayView: View {
    private var filteredIntervals: [Interval] {
          let today = Calendar.current.startOfDay(for: Date())
          return weather.data.timelines.flatMap { $0.intervals }
              .filter { !isToday(dateString: $0.startTime, today: today) }
      }
    let weather: Weather10Response
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        NavigationView {
        ScrollView {
         
                VStack(spacing: 12) {
                   
                    ForEach(filteredIntervals) { interval in


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
                                        )
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
                }   .navigationBarTitle("Upcoming Days")
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title)
            })
        
//                Spacer()
            }
        
         
        }
//            .padding(.vertical, 12)



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
private func isToday(dateString: String, today: Date) -> Bool {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
       
       if let date = dateFormatter.date(from: dateString) {
           return Calendar.current.isDate(date, inSameDayAs: today)
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
struct TenDayView_Previews: PreviewProvider {
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
        TenDayView(weather: sampleWeather)
    }
}
