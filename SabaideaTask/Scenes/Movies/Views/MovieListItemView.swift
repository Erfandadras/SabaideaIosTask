//
//  MovieListItemView.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/12/24.
//


import SwiftUI
import SDWebImageSwiftUI

struct MovieListItemView: View {
    let data: MoviesUIModel
    
    var body: some View {
        HStack(spacing: 12) {
            ImageViewBuilder(url: data.imageUrl)
                .aspectRatio(1.2, contentMode: .fit)
                .frame(maxWidth: 120)
                .background(Color.black)
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 14) {
                Text(data.title)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .leading()
                Spacer()
                Text(data.date)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .leading()
            }// text VStack
            .padding(.vertical, 6)
            .frame(maxWidth: .infinity)
            Spacer()
        }//HStack
        .frame(maxWidth: .infinity, maxHeight: 120 / 1.2)
        .padding()
    }
}
