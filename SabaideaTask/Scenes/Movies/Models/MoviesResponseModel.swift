//
//  MoviesResponseModel.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/9/24.
//
import Foundation

struct PaginateMoviesResponseModel: Codable {
    // MARK: - properties
    let page: Int?
    var results: [MoviesResponseModel]
    private let totalPages: Int?
    private let totalResults: Int?
    
    // variable
    var hasMoreData: Bool { page != totalPages }
    
    // MARK: - keys
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decodeIfPresent(Int.self, forKey: .page)
        self.results = try container.decode([MoviesResponseModel].self, forKey: .results)
        self.totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
        self.totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
    }
}


struct MoviesResponseModel: Codable {
    // MARK: - properties
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    let imagePath: String?
    let date: String
    
    // MARK: - keys
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case overview = "overview"
        case voteAverage = "vote_average"
        case imagePath = "poster_path"
        case date = "release_date"
    }
    
    // MARK: - normal init
    init(id: Int, title: String, overview: String, voteAverage: Double, imagePath: String?, date: String?) {
        self.id = id
        self.title = title
        self.overview = overview
        self.voteAverage = voteAverage
        self.imagePath = imagePath
        self.date = date ?? "unknown"
    }
    
    
    // MARK: - decoder init
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? "unknown"
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0.0
        imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath)
        date = try container.decodeIfPresent(String.self, forKey: .date) ?? "unknown"

    }
    
    func filter(with keyword: String) -> Bool {
        let keywordLower = keyword.lowercased()
        return title.lowercased().contains(keywordLower) || overview.lowercased().contains(keywordLower)
    }

}

