//
//  BreedDetailView.swift
//  AppSUI07HW
//
//  Created by Konstantin Zaharev on 17.02.2022.
//

import SwiftUI
import RealmSwift

struct BreedDetailView: View {
    let breed: Breed
    let imageSize: CGFloat = 300
    
    @State var isLoading: Bool = true
    @State var imageData: UIImage?
    
    @EnvironmentObject var breedFetcher: BreedFetcher
    
    var body: some View {
        ScrollView {
            VStack {
                if isLoading {
                    ProgressView()
                        .frame(width: imageSize, height: imageSize)
                } else if let imageData = imageData {
                    
                    Image(uiImage: imageData)
                        .resizable()
                        .scaledToFit()
                        .frame( height: imageSize)
                        .clipped()
                }else {
                    Color.gray.frame(height: imageSize)
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text(breed.name)
                        .font(.headline)
                    Text(breed.temperament)
                        .font(.footnote)
                    Text(breed.breedExplaination)
                    if breed.isHairless {
                        Text("hairless")
                    }
                    
                    HStack {
                        Text("Energy level")
                        Spacer()
                        ForEach(1..<6) { id in
                            Image(systemName: "star.fill")
                                .foregroundColor(breed.energyLevel > id ? Color.accentColor : Color.gray )
                        }
                    }
                    
                    Spacer()
                }.padding()
                    .navigationBarTitleDisplayMode(.inline)
            }
        }.task {
            if let data = await breedFetcher.breedImageData(breed) {
                imageData = UIImage(data: data)
            }
            isLoading = false
        }
    }
}
