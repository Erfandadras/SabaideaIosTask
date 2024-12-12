//
//  MovieViewModel.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/9/24.
//


import Combine

final class MovieViewModel: BaseViewModel {
    let dataSource: MoviesDatasource
    
    init(dataSource: MoviesDatasource) {
        self.dataSource = dataSource
    }
    
    
    override func fetchData() {
//        Task {
//            let data = await dataSource.fetchData()
//        }
    }
}
