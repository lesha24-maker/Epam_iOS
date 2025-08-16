//
//  ProfileDetailView.swift
//  SwiftUILayout7
//
//  Created by Alexey Lim on 16/8/25.
//

import SwiftUI

struct ProfileDetailView: View {
    let user: User
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 10) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .foregroundColor(.gray)
                
                Text(user.name)
                    .font(.largeTitle.bold())
                
                HStack {
                    Text("Возраст: \(user.age)")
                    Text("•")
                    Text(user.location)
                }
                .font(.headline)
                .foregroundColor(.secondary)
            }
            .padding(30)
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
            .cornerRadius(20)
            .shadow(radius: 5)
            
            if user.isPremium {
                Image(systemName: "star.fill")
                    .font(.title)
                    .foregroundColor(.yellow)
                    .padding(12)
                    .background(Circle().fill(Color.blue))
                    .offset(x: -15, y: 15)
            }
        }
    }
}
