//
//  PhotoViewModel.swift
//  PhotoAlbums
//
//  Created by Peter Chambers on 16/12/2020.
//

import Foundation
import UIKit

struct PhotoListViewModel {
    let photos: [Photo]
}

extension PhotoListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return self.photos.count
    }
    
    func photoAtIndex(_ index: Int) -> PhotoViewModel {
        let photo = self.photos[index]
        return PhotoViewModel(photo)
    }
}

struct PhotoViewModel {
    private let photo: Photo
}

extension PhotoViewModel {
    init(_ photo: Photo) {
        self.photo = photo
    }
}

extension PhotoViewModel {
    var albumId: Int {
        return photo.albumId
    }
    
    var thumbnailImage: String {
        return photo.thumbnailUrl
    }
    
    var fullSizeImage: String {
        return photo.url
    }

}

