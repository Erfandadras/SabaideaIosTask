//
//  SabaideaTaskTests.swift
//  SabaideaTaskTests
//
//  Created by Erfan mac mini on 12/13/24.
//

import Testing
@testable import SabaideaTask

struct SabaideaMainScreenTaskTests {
    var dataSource: MoviesDatasourceRepo!
    var networkClient: NetworkClientImpl<MoviesNetworkClient>!
    var sut: MovieViewModel
    
    init() {
        networkClient = NetworkClientImpl(client: MockMoviesNetworkClient())
        dataSource = MoviesDatasource(network: networkClient)
        sut = .init(dataSource: dataSource)
    }
        
    @Test func fetchData() async throws {
        #expect(sut.state == nil)
        sut.fetchData()
        try await Task.sleep(for: .milliseconds(50))
        #expect(sut.state == .loading)
        try await Task.sleep(for: .seconds(1)) // simulate network request
        #expect(sut.state == .success)
        #expect(sut.uiModels.count == 20)
    }

    @Test func fetchDataWithKeyword() async throws {
        let keyword = "venom"
        sut.keyword = keyword
        try await Task.sleep(for: .seconds(1)) // simulate network request
        #expect(dataSource.keyword == keyword)
        #expect(sut.state == .success)
        #expect(sut.uiModels.count == 1)
        #expect(sut.uiModels.contains(where: {$0.title.lowercased().contains(keyword.lowercased())}))
    }
    
    @Test func fetchDataWithWrongKeyword() async throws {
        let keyword = "venom111"
        sut.keyword = keyword
        try await Task.sleep(for: .seconds(1)) // simulate network request
        #expect(dataSource.keyword == keyword)
        #expect(sut.state == .noData)
        #expect(sut.uiModels.isEmpty)
    }
    
    @Test func refreshDataWithKeyword() async throws {
        let keyword = "venom"
        sut.keyword = keyword
        try await Task.sleep(for: .seconds(1)) // simulate network request
        sut.fetchData(refresh: true)
        #expect(dataSource.page == 1)
    }
    
    @Test func fetchDataWithEmptyKeyword() async throws {
        let keyword = ""
        sut.keyword = keyword
        try await Task.sleep(for: .seconds(1)) // simulate network request
        sut.fetchData()
        #expect(dataSource.page == 1)
        #expect(dataSource.keyword == nil)
    }
}
