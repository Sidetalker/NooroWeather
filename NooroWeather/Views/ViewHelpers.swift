//
//  FontStyle.swift
//  NooroWeather
//
//  Created by Kevin Sullivan on 1/26/25.
//

import SwiftUI

enum FontStyle {
    case regular(CGFloat)
    case medium(CGFloat)
    case semibold(CGFloat)
    
    var font: Font {
        switch self {
        case .regular(let size): .custom("Poppins-Regular", size: size)
        case .medium(let size): .custom("Poppins-Medium", size: size)
        case .semibold(let size): .custom("Poppins-SemiBold", size: size)
        }
    }
}

extension Text {
    func styled(as fontStyle: FontStyle, color: Color) -> Text {
        return self
            .font(fontStyle.font)
            .foregroundColor(color)
    }
}

struct TextModifier: ViewModifier {
    var fontStyle: FontStyle
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(fontStyle.font)
            .foregroundColor(color)
    }
}
