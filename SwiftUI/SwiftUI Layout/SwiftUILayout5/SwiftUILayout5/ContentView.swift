//
//  ContentView.swift
//  SwiftUILayout5
//
//  Created by Alexey Lim on 16/8/25.
//

import SwiftUI

struct CardView<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 5)

            content
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                CardView(title: "Welcome") {
                    Text("This is a simple card with just a text view as its content.")
                        .font(.body)
                }

                CardView(title: "User Profile") {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("Aleksei lim")
                            Text("Junior iOS Developer")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }

                CardView(title: "Notifications") {
                    Text("You have 3 new messages.")
                    Button("View Messages") {
                        print("Messages button tapped!")
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 5)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
