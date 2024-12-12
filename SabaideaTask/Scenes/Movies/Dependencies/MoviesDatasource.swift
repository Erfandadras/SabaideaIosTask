//
//  MoviesDatasource.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/9/24.
//
import Foundation

protocol MoviesDatasourceRepo: BaseDataSource {
    func fetchData() async throws -> [MoviesUIModel]
}

final class MoviesDatasource: MoviesDatasourceRepo {
    // MARK: - properties
    private var page: Int = 1
    private var nextPage: Int = 1
    private var uiModels: [MoviesUIModel] = []
    let netwoek: NetworkClientImpl<MoviesNetworkClient>
    
    // MARK: - init
    init(netwoek: NetworkClientImpl<MoviesNetworkClient>) {
        self.netwoek = netwoek
    }
}

extension MoviesDatasource {
    func fetchData() async throws -> [MoviesUIModel] {
        let setup = createNetwoekSetup(for: nextPage)
        
        let data = try await netwoek.fetch(setup: .init(route: ""))
        self.page = data.page ?? self.page
        
        if data.hasMoreData {
            self.nextPage = page + 1
        }
        self.uiModels = data.results.map({.init(with: $0)})
        return uiModels
    }
    
    func refreshData() async throws -> [MoviesUIModel] {
        let setup = createNetwoekSetup(for: page)
        
        let data = try await netwoek.fetch(setup: .init(route: ""))
        self.page = data.page ?? self.page
        
        if data.hasMoreData {
            self.nextPage = page + 1
        }
        self.uiModels = data.results.map({.init(with: $0)})
        return uiModels
    }
}

// MARK: - private logic
private extension MoviesDatasource {
    func createNetwoekSetup(for page: Int = 1, language: String = "en-US") -> NetworkSetup {
        let params = [
          "include_adult": "false",
          "include_video": "false",
          "language": language,
          "page": "\(page)",
          "sort_by": "popularity.desc",
        ]
        let headers = createHeader()
        return .init(route: API.Routes.movieList, params: params, method: .get, headers: headers)
    }
    
    private func createHeader() -> [String: String] {
        return ["authorization": "Bearer \(API.token)"]
    }
}
