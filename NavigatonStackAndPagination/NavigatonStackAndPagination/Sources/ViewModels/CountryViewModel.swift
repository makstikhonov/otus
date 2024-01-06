//
//  CountryViewModel.swift
//  NavigatonStackAndPagination
//
//  Created by Mакс T on 06.01.2024.
//

import Foundation
import SwiftUI

final class CountryViewModel: ObservableObject {
    @Published var articles: [Article] = []
    private var canLoad: Bool = true
    private let networkService: NetworkServiceProtocol
    private var page: Int = 1
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetch(query: String) async {
        guard canLoad else { return }
        
        canLoad = false
        let articles = await networkService.getNews(query: query, page: page)
        if let articles,
           !articles.isEmpty {
            await MainActor.run {
                self.page += 1
                withAnimation {
                    self.articles.append(contentsOf: articles)
                }
                self.canLoad = true
            }
        }
    }
    
    func remove(_ articleToRemove: Article) {
        articles.removeAll { article in
            article == articleToRemove
        }
    }
}
