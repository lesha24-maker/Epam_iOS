//
//  FormModel.swift
//  StateManagement5
//
//  Created by Alexey Lim on 21/8/25.
//

import Foundation
import Observation 

@Observable
class FormModel {
    var username: String = ""

    var isSubmitButtonDisabled: Bool {
        username.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
