//
//  WeatherView.swift
//  Weather
//
//  Created by Maciej on 11/09/2022.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .font(.title).bold()
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            VStack(spacing: 20) {
                                Image(systemName: "sun.max")
                                    .font(.system(size: 40))
                                
                                Text(weather.weather[0].main)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            Spacer()
                            
                            Text(weather.main.feelsLike.roundDouble() + "°")
                                .font(.system(size: 100))
                                .fontWeight(.bold)
                                .padding()
                        }
                        
                        Spacer()
                            .frame(height: 80)
                        
                        AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350)
                        } placeholder: {
                            LoadingView()
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .bold()
                        .padding(.bottom)
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + "°"))
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                    }
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + "m/s"))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humiditi", value: ("\(weather.main.humidity)" + "%"))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.608, saturation: 0.926, brightness: 0.71))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.608, saturation: 0.926, brightness: 0.71))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
