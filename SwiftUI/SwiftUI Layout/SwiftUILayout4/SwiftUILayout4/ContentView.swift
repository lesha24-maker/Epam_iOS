//
//  ContentView.swift
//  SwiftUILayout4
//
//  Created by Alexey Lim on 16/8/25.
//

import SwiftUI

struct ColorSchemeToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {

            Spacer()

            RoundedRectangle(cornerRadius: 30)
                .fill(configuration.isOn ? Color.blue : Color.gray.opacity(0.4))
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(Color.white)
                        .padding(3)
                        .offset(x: configuration.isOn ? 10 : -10)
                )
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

struct ContentView: View {
    @State private var isDarkMode = false

    var body: some View {
        ZStack {
            Color(isDarkMode ? .black : .white)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Toggle("Enable Dark Mode", isOn: $isDarkMode)
                    .padding()
                    .background(Color(isDarkMode ? .gray.opacity(0.3) : .gray.opacity(0.1)))
                    .cornerRadius(10)
                    .padding()

                Spacer()
                
                Text("Hello, SwiftUI!")
                    .font(.largeTitle)
                
                Text("The theme will change when you use the toggle.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
        }
        
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
