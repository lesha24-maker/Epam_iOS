//
//  ContentView.swift
//  SwiftUILayout3
//
//  Created by Alexey Lim on 16/8/25.
//

import SwiftUI

struct ProfileRow: View {
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.gray)

            VStack(alignment: .leading) {
                Text("Aleksei Lim")
                    .font(.headline)
                Text("EPAM Software Engineer")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}

struct ProfileRow_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRow()
    }
}

#Preview {
    ProfileRow()
}
