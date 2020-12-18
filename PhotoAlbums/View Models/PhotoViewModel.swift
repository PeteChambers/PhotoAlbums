//
//  PhotoViewModel.swift
//  PhotoAlbums
//
//  Created by Peter Chambers on 16/12/2020.
//

import Foundation
import UIKit

protocol PhotoListViewDelegate {
    func showPhotos()
    func failure(message : String)
}

class PhotoListViewModel {
    var photos: [Photo]
    let webService : WebService
    var delegate : PhotoListViewDelegate?
    
    init() {
        photos = []
        webService = WebService()
    }
}

//MARK: GET PHOTOS
extension PhotoListViewModel {
    /// get albums..
    func getPhotos(albumId: Int) {
        
        webService.getPhotos(albumId: albumId) { result in
            switch result {
            case .success(let photos):
                self.photos = photos
                self.delegate?.showPhotos()
            case .failure(let error):
                self.delegate?.failure(message: error.localizedDescription)
            }
        }
    }
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

