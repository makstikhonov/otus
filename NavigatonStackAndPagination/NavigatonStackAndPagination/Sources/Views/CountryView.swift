//
//  CountryView.swift
//  NavigatonStackAndPagination
//
//  Created by Mакс T on 05.01.2024.
//

import SwiftUI
import CustomNavigation

struct CountryView: View {
    @ObservedObject private var viewModel: CountryViewModel
    @EnvironmentObject private var navigationViewModel: NavigationViewModel
    
    private var country: String
    
    init(
        country: String,
        viewModel: CountryViewModel = CountryViewModel()
    ) {
        self.viewModel = viewModel
        self.country = country
        Task {
            await viewModel.fetch(query: country)
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.articles) { article in
                    ArticleCell(article: article) {
                        withAnimation(.easeIn(duration: 0.3)) {
                            viewModel.remove(article)
                        }
                    }
                    .onAppear {
                        if viewModel.articles.isLastItem(article) {
                            Task {
                                await viewModel.fetch(query: country)
                            }
                        }
                    }
                }
            }
        }
        .padding(.all, 10)
    }
}
