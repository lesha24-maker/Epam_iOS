//
//  Counter.swift
//  EnvironmentObjects1
//
//  Created by Alexey Lim on 22/8/25.
//

import SwiftUI

class Counter: ObservableObject {
    @Published var counterValue: Int = 0
}
