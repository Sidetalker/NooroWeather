//
//  CurrentWeatherView.swift
//  NooroWeather
//
//  Created by Kevin Sullivan on 1/26/25.
//

import SwiftUI

struct CurrentWeatherView: View {
    @Environment(HomeViewModel.self) var viewModel
    
    var details: CurrentWeatherResponse
    
    var iconUrl: URL? {
        let urlString = details.current.condition.icon.dropFirst(2)
        guard let url = URL(string: "https://" + String(urlString)) else {
            return nil
        }
        return url
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 80)
            
            AsyncImage(url: iconUrl) { result in
                result.image?
                    .resizable()
                    .scaledToFit()
            }.frame(height: 113)
            
            HStack(spacing: 11) {
                Text(details.location.name)
                    .styled(as: .semibold(30), color: .text)
                Image(.location)
            }
            
            Text(details.current.temperature.toFahrenheitString())
                .modifier(TextModifier(fontStyle: .medium(70), color: .text))
                .padding(.bottom, 36)
            
            ZStack {
                Rectangle()
                    .foregroundStyle(Color.textBackground)
                    .cornerRadius(16)
                HStack {
                    VStack {
                        Text("Humidity")
                            .styled(as: .medium(12), color: .placeholder)
                        Text("\(Int(details.current.humidity))%")
                            .styled(as: .medium(15), color: .placeholderDark)
                    }.frame(width: 60)
                    Spacer()
                    VStack {
                        Text("UV")
                            .styled(as: .medium(12), color: .placeholder)
                        Text("\(Int(details.current.uvIndex))")
                            .styled(as: .medium(15), color: .placeholderDark)
                    }
                    Spacer()
                    VStack {
                        Text("Feels Like")
                            .styled(as: .medium(8), color: .placeholder)
                        Text(details.current.feelsLike.toFahrenheitString())
                            .styled(as: .medium(15), color: .placeholderDark)
                    }.frame(width: 41)
                }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 28))
            }
            .frame(height: 75)
            .padding(.horizontal, 50)
            
            Spacer()
        }
    }
}
