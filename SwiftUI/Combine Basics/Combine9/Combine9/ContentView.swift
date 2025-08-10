//
//  ContentView.swift
//  Combine9
//
//  Created by Alexey Lim on 10/8/25.
//

import SwiftUI

struct Post: Codable, Identifiable {
    let id: Int
    let title: String
}

struct ContentView: View {
    @State private var posts: [Post] = []
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Fetching Posts...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                } else if let errorMessage = errorMessage {
                    VStack(spacing: 10) {
                        Text("Failed to Load Posts")
                            .font(.headline)
                            .foregroundColor(.red)
                        Text(errorMessage)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Button("Retry") {
                            Task {
                                await fetchPosts()
                            }
                        }
                        .padding(.top, 5)
                    }
                } else {
                    List(posts) { post in
                        Text(post.title)
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("Posts")
            .task {
                await fetchPosts()
            }
        }
    }

    func fetchPosts() async {
        errorMessage = nil
        isLoading = true
        
        defer { isLoading = false }

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            errorMessage = "Invalid URL"
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedPosts = try JSONDecoder().decode([Post].self, from: data)
            
            self.posts = decodedPosts
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
