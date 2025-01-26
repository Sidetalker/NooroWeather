//
//  HomeViewModel.swift
//  NooroWeather
//
//  Created by Kevin Sullivan on 1/25/25.
//

import Foundation

private let apiKey = "06c631275fea4b23a60204822252501"

@MainActor
@Observable class HomeViewModel {
    private let networkService: NetworkServiceProtocol
    private let preferenceService: PreferenceServiceProtocol
    
    private var searchTask: Task<(), Never>?
    
    var currentWeather: CurrentWeatherResponse?
    var selectedCityId: Int?
    
    var isSearchFocused = false
    var searchResults: [WeatherSearchResult] = []
    var searchCache: [Int: CurrentWeatherResponse] = [:]
    var searchText = "" {
        didSet {
            guard !searchText.isEmpty else {
                searchResults = []
                return
            }
            searchTask?.cancel()
            searchTask = Task {
                await search(for: searchText)
            }
        }
    }
    
    init(networkService: NetworkServiceProtocol = NetworkService(), preferenceService: PreferenceServiceProtocol = PreferenceService()) {
        self.networkService = networkService
        self.preferenceService = preferenceService
    }
    
    func loadDefaultCity() {
        if let cityId = preferenceService.read(.selectedCity, as: Int.self) {
            selectCity(id: cityId)
        }
    }
    
    func search(for query: String) async {
        guard let searchUrl = URL(string: "https://api.weatherapi.com/v1/search.json?q=\(query)&key=\(apiKey)") else {
            print("Unable to generate URL for searchTerm: \(query)")
            return
        }
        
        do {
            searchResults = try await networkService.fetch([WeatherSearchResult].self, from: searchUrl)
        } catch {
            print("Error fetching search results: \(error.localizedDescription)")
        }
    }
    
    func fetchDetails(for result: WeatherSearchResult) async -> CurrentWeatherResponse? {
        return await fetchDetails(for: result.id)
    }
    
    func fetchDetails(for cityId: Int) async -> CurrentWeatherResponse? {
        if let cachedResponse = searchCache[cityId] { return cachedResponse }
        
        guard let detailsUrl = URL(string: "https://api.weatherapi.com/v1/current.json?q=id%3A\(cityId)&key=\(apiKey)") else {
            print("Unable to generate URL for id: \(cityId)")
            return nil
        }
        
        do {
            let response = try await networkService.fetch(CurrentWeatherResponse.self, from: detailsUrl)
            searchCache[cityId] = response
            return response
        } catch {
            print("Error fetching weather details: \(error.localizedDescription)")
            return nil
        }
    }
    
    func selectCity(id: Int) {
        selectedCityId = id
        isSearchFocused = false
        preferenceService.set(value: id, for: .selectedCity)
        
        if let cachedWeather = searchCache[id] {
            currentWeather = cachedWeather
            searchText = ""
        } else {
            Task {
                currentWeather = await fetchDetails(for: id)
                searchText = ""
            }
        }
    }
}
