//
//  CustomImageView.swift
//  NavigatonStackAndPagination
//
//  Created by Mакс T on 05.01.2024.
//

import Foundation
import SwiftUI

struct CustomImageView: View {
    var urlString: String
    @StateObject private var imageLoader = ImageLoaderService()
    
    var body: some View {
        VStack {
            if imageLoader.isLoading {
                ZStack(alignment: .center) {
                    ProgressView()
                }
            } else {
                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
        .onAppear {
            guard imageLoader.image == nil else { return }
            imageLoader.loadImage(for: urlString)
        }
    }
}

final private class ImageLoaderService: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    func loadImage(for urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        isLoading = true
        let task = URLSession.shared.dataTask(with: url) {  [weak self] data, response, error in
            guard let data else {
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.image = UIImage(data: data) ?? UIImage()
            }
        }
        task.resume()
    }
}
