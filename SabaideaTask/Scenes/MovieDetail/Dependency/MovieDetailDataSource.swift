//
//  MovieDetailDataSource.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/12/24.
//

protocol MovieDetailDataSourceRepo: BaseDataSource {
    func fetchData() async throws -> MovieDetailUIModel
}



final class MovieDetailDataSource: MovieDetailDataSourceRepo {
    // MARK: - properties
    private let id: Int
    private var uiModel: MovieDetailUIModel?
    private let userManager = UserManager.shared
    private var language: String
    let network: NetworkClientImpl<MovieDetailNetworkClient>
    
    // MARK: - init
    init(id: Int, network: NetworkClientImpl<MovieDetailNetworkClient>) {
        self.id = id
        self.network = network
        self.language = userManager.language
    }
}

// MARK: - fetch data
extension MovieDetailDataSource {
    func fetchData() async throws -> MovieDetailUIModel {
        let setup = createNetworkSetup()
        let data = try await network.fetch(setup: setup)
        self.uiModel = .init(with: data)
        return uiModel!
    }
}

// MARK: - create request setup
private extension MovieDetailDataSource {
    func createNetworkSetup() -> NetworkSetup {
        let params = [
            "language": language,
          ]
        
        let headers = createHeader()
        return .init(route: API.Routes.movieDetail + "\(id)",
                     params: params,
                     method: .get,
                     headers: headers)
    }
    
    private func createHeader() -> [String: String] {
        return ["authorization": "Bearer \(userManager.token ?? "")"]
    }
}
