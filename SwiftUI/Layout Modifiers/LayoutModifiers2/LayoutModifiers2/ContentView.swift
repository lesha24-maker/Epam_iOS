//
//  ContentView.swift
//  LayoutModifiers2
//
//  Created by Alexey Lim on 18/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.red)
                .frame(width: 150, height: 100)
                .shadow(radius: 5)
            
            VStack {
                HStack {
                    Spacer()
                    
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 100, height: 100)
                        .shadow(radius: 5)
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
