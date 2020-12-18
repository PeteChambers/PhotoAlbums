//
//  Url+Extensions.swift
//  PhotoAlbums
//
//  Created by Peter Chambers on 18/12/2020.
//

import Foundation

extension URL {
    static func albumsURL() -> URL? {
        return URL(string:  "https://jsonplaceholder.typicode.com/albums")
    }
    
    static func searchAlbumsURL(searchText: String) -> URL? {
        let urlString = "https://jsonplaceholder.typicode.com/albums?title=\(searchText)".lowercased()
        let finalUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return URL(string: finalUrlString)
    }
    
    static func photosURL(albumId: Int) -> URL? {
        return URL(string: "https://jsonplaceholder.typicode.com/albums/\(albumId)/photos")
    }
    
}
