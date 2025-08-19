//
//  ContentView.swift
//  LayoutModifiers9
//
//  Created by Alexey Lim on 19/8/25.
//
import SwiftUI

struct ContentView: View {
    let fruits = FruitData.allFruits

    var body: some View {
        NavigationStack {
            List(fruits) { fruit in
                NavigationLink {
                    DetailView(fruit: fruit)
                } label: {
                    HStack {
                        Text(fruit.emoji)
                            .font(.largeTitle)
                        Text(fruit.name)
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("Fruits")
        }
    }
}
