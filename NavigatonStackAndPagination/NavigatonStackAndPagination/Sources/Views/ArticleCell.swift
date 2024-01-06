//
//  ArticleCell.swift
//  NavigatonStackAndPagination
//
//  Created by Mакс T on 05.01.2024.
//

import SwiftUI
import CustomNavigation

struct ArticleCell: View {
    @EnvironmentObject private var navigationViewModel: NavigationViewModel
    
    var article: Article
    var onTapped: (() -> Void)?
    
    var body: some View {
        HStack {
            HStack {
                if let url = article.urlToImage {
                    CustomImageView(urlString: url)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
                }
                
                Text(article.title)
            }
            .onTapGesture {
                navigationViewModel.push(
                    newScreen:
                        ArticleView(article: article)
                )
            }
            
            Spacer()
            
            Button {
                onTapped?()
            } label: {
                Image(systemName: "bookmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
        .transition(
            .asymmetric(
                insertion: .opacity,
                removal: .offset(
                    CGSize(
                        width: UIScreen.main.bounds.size.width,
                        height: UIScreen.main.bounds.size.height
                    )
                )
            )
        )
    }
}

