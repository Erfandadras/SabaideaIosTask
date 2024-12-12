//
//  MovieDetailUIModel.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/12/24.
//

import Foundation

struct MovieDetailUIModel {
    let id: Int
    let title: String
    let detail: String
    let imageUrl: URL?
    let date: String
    
    init(id: Int, title: String, overview: String, imageUrl: URL?, date: String) {
        self.id = id
        self.title = title
        self.detail = overview
        self.imageUrl = imageUrl
        self.date = date
    }
    
    
    init(with data: MovieDetailResponseModel) {
        self.id = data.id
        self.title = data.title
        self.detail = data.overview
        self.date = data.date
        if let imagePath = data.imagePath {
            self.imageUrl = URL(string: API.mediaBaseURL + imagePath)
        } else {
            self.imageUrl = nil
        }
    }
}
