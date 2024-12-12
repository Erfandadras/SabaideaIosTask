//
//  View+Placeholder+anchor.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/12/24.
//


import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
    
    func leading() -> some View {
        HStack {
            self
            Spacer()
        }
    }
    
    func trailing() -> some View {
        HStack {
            Spacer()
            self
        }
    }
}
