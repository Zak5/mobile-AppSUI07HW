//
//  BreedFetcher.swift
//  AppSUI07HW
//
//  Created by Konstantin Zaharev on 17.02.2022.
//

import SwiftUI
import RealmSwift

@MainActor
class BreedFetcher: ObservableObject {
    
    @Published var breeds = [Breed]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    let service: APIServiceProtocol
    let realm: Realm?
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
        self.realm = try? Realm()
    }
    
    func fetchAllBreeds() async {
        isLoading = true
        errorMessage = nil
        
        if let realm = realm {
            let results = realm.objects(Breed.self)
            breeds = Array(results)
        }
        
        let url = URL(string: "https://api.thecatapi.com/v1/breeds")
        do {
            breeds = try await service.fetchBreeds(url: url)
            try await uploadBreeds(breeds)
        } catch URLError.notConnectedToInternet {
            print("Not connected to internet")
        } catch {
            errorMessage = error.localizedDescription
       }
        
        isLoading = false
    }
    
    func fetchBreedImageData(_ breed: Breed) async -> Data? {
        guard let data = try? await service.fetchBreedImageData(breed) else { return nil }
        if let realm = realm {
            let breedImageData = BreedImageData(id: breed.id, data: data)
            try? realm.write {
                realm.add(breedImageData)
            }
        }
        return data
    }
    
    func breedImageData(_ breed: Breed) async -> Data? {
        guard let realm = realm else { return nil }
        if let breedImageData = realm.object(ofType: BreedImageData.self, forPrimaryKey: breed.id) {
            return breedImageData.data
        }
        return await fetchBreedImageData(breed)
    }
    
    private func uploadBreeds(_ breeds: [Breed]) async throws {
        guard let realm = realm else { return }
        try realm.write {
            realm.add(breeds)
        }
    }
     
}
