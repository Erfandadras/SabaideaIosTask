//
//  MoviesResponseModel.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/9/24.
//

struct PaginateMoviesResponseModel: Codable {
    // MARK: - properties
    let page: Int?
    let results: [MoviesResponseModel]
    private let totalPages: Int?
    private let totalResults: Int?
    
    // variable
    var hasMoreData: Bool { page != totalPages }
    
    // MARK: - keys
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


struct MoviesResponseModel: Codable {
    // MARK: - properties
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    
    // MARK: - keys
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case voteAverage
    }
    
    // MARK: - normal init
    init(id: Int, title: String, overview: String, voteAverage: Double) {
        self.id = id
        self.title = title
        self.overview = overview
        self.voteAverage = voteAverage
    }
    
    
    // MARK: - decoder init
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        id = (try? container?.decode(Int.self, forKey: .id)) ?? -1
        title = (try? container?.decode(String.self, forKey: .title)) ?? "unknown"
        overview = (try? container?.decode(String.self, forKey: .overview)) ?? "unknown"
        voteAverage = (try? container?.decode(Double.self, forKey: .voteAverage)) ?? 0.0
    }
}

