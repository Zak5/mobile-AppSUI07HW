//
//  BreedRow.swift
//  AppSUI07HW
//
//  Created by Konstantin Zaharev on 17.02.2022.
//

import SwiftUI

struct BreedRow: View {
    let breed: Breed
    let imageSize: CGFloat = 100
    
    @State var isLoading: Bool = true
    @State var imageData: UIImage?

    @EnvironmentObject var breedFetcher: BreedFetcher
    
    var body: some View {
        HStack {
            if isLoading {
                ProgressView()
                    .frame(width: imageSize, height: imageSize)
            } else if let imageData = imageData {
                Image(uiImage: imageData)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
                    .clipped()
            } else {
                Color.gray.frame(width: imageSize, height: imageSize)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(breed.name)
                    .font(.headline)
                Text(breed.temperament)
            }
        }.task {
            if let data = await breedFetcher.breedImageData(breed) {
                imageData = UIImage(data: data)
            }
            isLoading = false
        }
    }
}
