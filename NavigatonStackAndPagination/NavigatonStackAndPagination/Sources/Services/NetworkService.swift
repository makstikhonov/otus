//
//  NetworkService.swift
//  NavigatonStackAndPagination
//
//  Created by Mакс T on 05.01.2024.
//

import Foundation
import NetworkNewsApi

typealias ArticleList = Components.Schemas.ArticleList
typealias Article = Components.Schemas.Article

protocol NetworkServiceProtocol {
    func getNews(query: String, page: Int?) async -> [Article]?
}

final class NetworkService: NetworkServiceProtocol {
    
    private let networkClient: APIProtocol
    private let apiKey = "8815d577462a4195a64f6f50af3ada08"//"bdd692434cee453d9508f9fd23314f8c"
    
    init(networkClient: APIProtocol = NetworkNewsApi.makeNewsApiClient()) {
        self.networkClient = networkClient
    }
    
    func getNews(query: String, page: Int?) async -> [Article]? {
        do {
            let response = try await networkClient.everythingGet(
                .init(
                    query: .init(
                        q: query,
                        from: "2024-01-02",
                        sortBy: "publishedAt",
                        language: "en",
                        apiKey: apiKey,
                        page: page,
                        pageSize: 10
                    )
                )
            )
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(articles):
                    return articles.articles
                }
            case .default:
                return nil
            }
        } catch {
            return nil
        }
    }
}
