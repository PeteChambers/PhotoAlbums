//
//  Photo.swift
//  PhotoAlbums
//
//  Created by Peter Chambers on 16/12/2020.
//

import Foundation
import Alamofire

struct Photo: Codable {
    let albumId, id: Int
    let title: String
    let url, thumbnailUrl: String
}

typealias Photos = [Photo]
