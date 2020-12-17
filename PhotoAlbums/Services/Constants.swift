//
//  Constants.swift
//  PhotoAlbums
//
//  Created by Peter Chambers on 16/12/2020.
//

import Foundation
import Alamofire

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
}

enum ContentType: String {
    case json = "application/json"
    case charSet = "charset=UTF-8"
}

var standardHeaders: HTTPHeaders {
    return [HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue, HTTPHeaderField.contentType.rawValue: ContentType.charSet.rawValue]
}
