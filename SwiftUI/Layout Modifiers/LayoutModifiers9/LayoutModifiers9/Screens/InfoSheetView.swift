//
//  InfoSheetView.swift
//  LayoutModifiers9
//
//  Created by Alexey Lim on 19/8/25.
//

import SwiftUI

struct InfoSheetView: View {
    let fruit: Fruit
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(fruit.emoji)
                    .font(.system(size: 80))
                
                Text(fruit.nutritionalInfo)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Nutritional Facts")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    InfoSheetView(fruit: FruitData.allFruits[1])
}
