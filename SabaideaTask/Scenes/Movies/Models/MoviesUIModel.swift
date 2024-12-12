//
//  MoviesUIModel.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/11/24.
//

import SwiftUI

struct MoviesUIModel: Identifiable {
    // MARK: - properties
    let id: Int
    let title: String
    let detail: String
    let voteAverage: Double
    
    
    // MARK: - init
    init(id: Int, title: String, detail: String, voteAverage: Double) {
        self.id = id
        self.title = title
        self.detail = detail
        self.voteAverage = voteAverage
    }
    
    // MARK: - init with row data
    init(with data: MoviesResponseModel) {
        self.id = data.id
        self.title = data.title
        self.detail = data.overview
        self.voteAverage = data.voteAverage
    }
}
