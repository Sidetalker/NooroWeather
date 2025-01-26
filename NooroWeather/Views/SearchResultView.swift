//
//  SearchResultView.swift
//  NooroWeather
//
//  Created by Kevin Sullivan on 1/26/25.
//

import SwiftUI

struct SearchResultView: View {
    @Environment(HomeViewModel.self) var viewModel
    
    var result: WeatherSearchResult
    @State var details: CurrentWeatherResponse?
    
    var iconUrl: URL? {
        guard
            let urlString = details?.current.condition.icon.dropFirst(2),
            let url = URL(string: "https://" + String(urlString))
        else {
            return nil
        }
        return url
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.textBackground)
                .cornerRadius(16)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(details?.location.name ?? result.name)
                        .styled(as: .semibold(20), color: .text)
                    Text(details?.current.temperature.toFahrenheitString() ?? "")
                        .styled(as: .medium(60), color: .text)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 16, leading: 31, bottom: 16, trailing: 10))
                
                Spacer().frame(width: 10)
                
                AsyncImage(url: iconUrl) { result in
                    result.image?
                        .resizable()
                        .scaledToFit()
                }
                .frame(height: 67)
                .padding(.trailing, 31)
            }
        }
        .padding(.horizontal, 20)
        .onTapGesture {
            viewModel.selectCity(id: result.id)
        }
        .task {
            details = await viewModel.fetchDetails(for: result)
        }
    }
}
