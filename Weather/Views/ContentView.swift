//
//  ContentView.swift
//  Weather
//
//  Created by Maciej on 11/09/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationSerivce = LocationService()
    var weatherService = WeatherService()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let location = locationSerivce.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherService.getCurrentWeather(latitude: location.latitude, longtitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
                
            } else {
                if locationSerivce.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationSerivce)
                }
            }
        }
        .background(Color(hue: 0.608, saturation: 0.926, brightness: 0.71))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
