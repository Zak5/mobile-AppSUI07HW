//
//  ContentView.swift
//  AppSUI07HW
//
//  Created by Konstantin Zaharev on 17.02.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var breedFetcher = BreedFetcher()
    
    var body: some View {
      
        Group {
            if breedFetcher.isLoading {
                LoadingView()
            }else if breedFetcher.errorMessage != nil  {
                ErrorView(breedFetcher: breedFetcher)
            }else {
                BreedListView(breeds: breedFetcher.breeds)
                    .environmentObject(breedFetcher)
            }
        }.task {
            await breedFetcher.fetchAllBreeds()
        }
          
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
