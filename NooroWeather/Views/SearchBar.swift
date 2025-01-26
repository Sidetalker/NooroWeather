//
//  SearchView.swift
//  NooroWeather
//
//  Created by Kevin Sullivan on 1/26/25.
//

import SwiftUI

struct SearchBar: View {
    @Environment(HomeViewModel.self) var viewModel
    
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.textBackground)
                .cornerRadius(16)
            
            TextField("", text: $text,
                      prompt: Text("Search Location")
                .foregroundStyle(Color.placeholder))
            .focused($isFocused)
            .padding(.horizontal, 20)
            .modifier(TextModifier(fontStyle: .regular(15), color: .text))
            
            HStack {
                Spacer()
                Image(.search)
                Spacer().frame(width: 20.51)
            }
        }
        .frame(height: 46)
        .padding(.horizontal, 24)
        .onChange(of: isFocused) { viewModel.isSearchFocused = isFocused }
        .onChange(of: viewModel.isSearchFocused) { isFocused = viewModel.isSearchFocused }
    }
}
