//
//  ImageViewBuilder.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 11/13/24.
//

import SwiftUI
import SDWebImageSwiftUI


public struct ImageViewBuilder: View {
    let url: URL?
    var placeholder: Image = .init(systemName: "photo")
    
    public var body: some View {
        WebImage(url: url) { image in
            image.resizable(resizingMode: .stretch)
        } placeholder: {
            placeholder
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
        }// Web Image -> banner
//        .resizable()
        .indicator(.activity) // Activity Indicator
        .transition(.fade(duration: 0.5)) // Fade Transition
//        .scaledToFill()
    }
}
