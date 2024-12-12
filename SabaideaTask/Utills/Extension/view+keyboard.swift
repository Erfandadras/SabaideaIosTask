//
//  view+keyboard.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/12/24.
//


import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}