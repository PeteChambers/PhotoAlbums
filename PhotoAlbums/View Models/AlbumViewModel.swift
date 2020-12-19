//
//  AlbumViewModel.swift
//  PhotoAlbums
//
//  Created by Peter Chambers on 16/12/2020.
//

import Foundation
import UIKit

//MARK: AlbumListViewDelegate

protocol AlbumListViewDelegate {
    func showAlbums()
    func failure(message : String)
}

class AlbumListViewModel {
    var albums: [Album]
    let webService : WebService
    var delegate : AlbumListViewDelegate?
    
    init() {
        albums = []
        webService = WebService()
    }
}

//MARK: Get ALbums & Search Albums

extension AlbumListViewModel {
    // get albums
    func getAlbums() {
        webService.getAlbums { result in
            switch result {
            case .success(let albums):
                self.albums = albums
                self.delegate?.showAlbums()
            case .failure(let error):
            self.delegate?.failure(message: error.localizedDescription)
  
            }
        }
    }
    
    // search album
    func searchAlbum(text : String) {
        webService.searchAlbums(searchText: text) { result in
            switch result {
            case .success(let albums):
                self.albums = albums
                self.delegate?.showAlbums()
            case .failure(let error):
                self.delegate?.failure(message: error.localizedDescription)
            }
        }
    }
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
        return album.title.capitalized
    }
    var id: Int {
        return album.id
    }

}

