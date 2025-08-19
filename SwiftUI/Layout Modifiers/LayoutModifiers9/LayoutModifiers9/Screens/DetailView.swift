//
//  DetailView.swift
//  LayoutModifiers9
//
//  Created by Alexey Lim on 19/8/25.
//

import SwiftUI

struct DetailView: View {
    let fruit: Fruit
    
    @State private var isShowingSheet = false

    var body: some View {
        VStack(spacing: 20) {
            Text(fruit.emoji)
                .font(.system(size: 100))
            
            Text(fruit.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(fruit.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Show Nutritional Info") {
                isShowingSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
            .tint(fruit.color)
        }
        .navigationTitle(fruit.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingSheet) {
            InfoSheetView(fruit: fruit)
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(fruit: FruitData.allFruits[0])
    }
}
