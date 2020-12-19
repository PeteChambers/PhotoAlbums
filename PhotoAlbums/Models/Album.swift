//
//  Album.swift
//  PhotoAlbums
//
//  Created by Peter Chambers on 16/12/2020.
//

import Foundation
import Alamofire

struct Album: Codable, Equatable {
    let userId, id: Int
    let title: String
}

typealias Albums = [Album]

