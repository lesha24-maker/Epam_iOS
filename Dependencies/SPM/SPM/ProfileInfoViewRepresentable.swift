//
//  ProfileInfoViewRepresentable.swift
//  SPM
//
//  Created by Alexey Lim on 9/25/25.
//

import SwiftUI
import UIKit

struct ProfileInfoViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ProfileInfoView {
        return ProfileInfoView()
    }

    func updateUIView(_ uiView: ProfileInfoView, context: Context) {
    }
}
