//
//  BreedImage.swift
//  AppSUI07HW
//
//  Created by Konstantin Zaharev on 17.02.2022.
//

import Foundation
import RealmSwift

/*
 "image": {
   "height": 1445,
   "id": "0XYvRd7oD",
   "url": "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg",
   "width": 1204
 },
 */

class BreedImage: Object, ObjectKeyIdentifiable, Codable {
    @Persisted var height: Int?
    @Persisted var id: String?
    @Persisted var url: String?
    @Persisted var width: Int?
}
