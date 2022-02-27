//
//  BreedImageData.swift
//  AppSUI07HW
//
//  Created by Konstantin Zaharev on 26.02.2022.
//

import Foundation
import RealmSwift

class BreedImageData: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var data: Data
    
    convenience init(id: String, data: Data) {
        self.init()
        self.id = id
        self.data = data
    }
}
