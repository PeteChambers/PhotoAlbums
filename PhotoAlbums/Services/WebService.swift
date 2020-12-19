//
//  WebService.swift
//  PhotoAlbums
//
//  Created by Peter Chambers on 16/12/2020.
//

import Foundation
import Alamofire

class WebService {
    
    private let defaultQueue = DispatchQueue.global(qos: .userInitiated)
    
    private func callURL<T:Decodable>(url: URL, method: HTTPMethod, encoding: ParameterEncoding, httpHeaders: HTTPHeaders, parameters: [String:Any]? = nil, completion: @escaping (Result<T,Error>) -> Void) {
    
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: httpHeaders)
            .responseData(queue: defaultQueue) { response in
                
                guard response.error == nil else {
                    debugPrint("ERROR calling \(url.absoluteString), Error: \(String(describing: response.error))")
                    completion(.failure(response.error!))
                    return
                }
                
                guard let responseData = response.data else {
                    debugPrint("ERROR calling \(url.absoluteString), No Data Found")
                    completion(.failure(response.error!))
                    return
                }
                
                do{
                    let decoder = JSONDecoder()
                    let item = try decoder.decode(T.self, from: responseData )
                    debugPrint("SUCCESS calling \(url.absoluteString)")
                    completion(.success(item))
                    return
                } catch {
                    debugPrint("Could not decode data into \(T.self) \(url.absoluteString) \(error)")
                    completion(.failure(error))
                }
        }
    }
    
    // MARK: Get Albums
    
    func getAlbums(completion: @escaping ((Result<Albums,Error>) -> Void)) {
        
        
        guard let url = URL.albumsURL() else { return }
        let httpHeaders = standardHeaders
        
        callURL(url: url, method: .get, encoding: JSONEncoding.default, httpHeaders: httpHeaders, parameters: nil, completion: completion)
    }
    
    // MARK: Search Albums
    
    func searchAlbums(searchText: String, completion: @escaping ((Result<Albums,Error>) -> Void)) {
        
        guard let url = URL.searchAlbumsURL(searchText: searchText) else { return }
        let httpHeaders = standardHeaders
        
        callURL(url: url, method: .get, encoding: JSONEncoding.default, httpHeaders: httpHeaders, parameters: nil, completion: completion)
    }
    
    // MARK: Get Albums
    
    func getPhotos(albumId: Int, completion: @escaping ((Result<Photos,Error>) -> Void)) {
        
        guard let url = URL.photosURL(albumId: albumId) else { return }
        let httpHeaders = standardHeaders
        
        callURL(url: url, method: .get, encoding: JSONEncoding.default, httpHeaders: httpHeaders, parameters: nil, completion: completion)
        
    }
}

