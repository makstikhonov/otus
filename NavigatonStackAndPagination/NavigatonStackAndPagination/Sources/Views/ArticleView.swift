//
//  ArticleView.swift
//  NavigatonStackAndPagination
//
//  Created by Mакс T on 05.01.2024.
//

import SwiftUI
import CustomNavigation

struct ArticleView: View {
    @EnvironmentObject private var navigationViewModel: NavigationViewModel
    var article: Article
    
    var body: some View {
        VStack {
            CustomNavigationBar {
                navigationViewModel.pop()
            }
            
            ScrollView {
                Text(article.title)
                    .font(.title)
                    .padding(.all, 10.0)
                
                if let url = article.urlToImage {
                    CustomImageView(urlString: url)
                        .frame(width: UIScreen.main.bounds.width - 20)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                }
                
                if let content = article.content {
                    Text(content)
                        .padding(.all, 10.0)
                    Button("Read more...") {
                        navigationViewModel.push(newScreen: TextView(text: content))
                    }
                }
            }
            
            Spacer()
        }
    }
}

