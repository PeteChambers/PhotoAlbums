//
//  AlbumViewModel.swift
//  PhotoAlbums
//
//  Created by Peter Chambers on 16/12/2020.
//

import Foundation
import UIKit

struct AlbumListViewModel {
    let albums: [Album]
}

extension AlbumListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return self.albums.count
    }
    
    func albumtAtIndex(_ index: Int) -> AlbumViewModel {
        let album = self.albums[index]
        return AlbumViewModel(album)
    }
}

struct AlbumViewModel {
    private let album: Album
}

extension AlbumViewModel {
    init(_ album: Album) {
        self.album = album
    }
}

extension AlbumViewModel {
    var title: String {
        return album.title
    }
    var id: Int {
        return album.id
    }

}

