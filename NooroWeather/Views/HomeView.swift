//
//  HomeView.swift
//  NooroWeather
//
//  Created by Kevin Sullivan on 1/25/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(text: $viewModel.searchText)
            
            if let currentWeather = viewModel.currentWeather, viewModel.searchText.isEmpty {
                CurrentWeatherView(details: currentWeather)
            } else if !viewModel.searchText.isEmpty {
                Spacer().frame(height: 32)
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.searchResults) { result in
                            SearchResultView(result: result)
                        }
                    }
                }
            } else if viewModel.selectedCityId != nil {
                Spacer()
                ProgressView()
                    .scaleEffect(2)
                    .foregroundStyle(Color.text)
                Spacer()
            } else {
                Spacer()
                VStack(spacing: 10) {
                    Text("No City Selected")
                        .styled(as: .semibold(30), color: .text)
                    Text("Please Search For A City")
                        .styled(as: .semibold(15), color: .text)
                }
                Spacer()
            }
        }
        .environment(viewModel)
        .task { viewModel.loadDefaultCity() }
    }
}

#Preview {
    HomeView()
}
