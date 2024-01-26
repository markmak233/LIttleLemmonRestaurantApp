//
//  Style.swift
//  Restaurant
//
//  Created by marco mai on 2024-01-25.
//

import Foundation
import SwiftUI


struct ButtonToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                configuration.label
            }
        }
        .foregroundColor(.color5)
        .padding(5)
        .background {
            if configuration.isOn {
                Color.color4
            }
        }
        .cornerRadius(8)
    }
}

// https://www.appcoda.com/swiftui-checkbox/
struct CheckBoxStyle: ToggleStyle{
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 2)
                .frame(width: 25, height: 25)
                .cornerRadius(5.0)
                .overlay {
                    Image(systemName: configuration.isOn ? "checkmark" : "")
                }
                .foregroundColor(Color.white)
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }.background{
                    if configuration.isOn{
                        Color.color2
                    }
                }
            configuration.label
            Spacer()
        }.padding(.horizontal)
    }
}

struct YellowButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .foregroundColor(Color.color2)
            .padding(12)
            .background(Color.color3)
            .cornerRadius(5)
            .padding(.horizontal)
            .padding(.horizontal)
    }
}

struct GreenButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor( Color.color2)
            .padding(10)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.color2, lineWidth: 1)
            )
    }
}

struct CancelButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white )
            .padding(10)
            .background(Color.color2)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.color2, lineWidth: 1)
            )
    }
}

extension Text{
    func InputTextHintStyle() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Color.color2)
            .font(.custom("Karla-Bold", size: 13))
    }
}

extension Font{
    static func TittleFont() -> Font {
        return Font.custom("Markazi Text", size: 35).weight(.medium)
    }
    
    static func subTitleFont() -> Font {
        return Font.custom("Markazi Text", size: 20)
    }
    
    static func PargTextFont() -> Font {
        return Font.custom("Karla", size: 16).weight(.medium)
    }
}
