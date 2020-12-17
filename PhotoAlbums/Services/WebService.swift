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
    
    private func callURL<T:Decodable>(url: URL, method: HTTPMethod, encoding: ParameterEncoding, httpHeaders: HTTPHeaders, parameters: [String:Any]? = nil, completion completionHandler: @escaping (T) -> Void, error errorHandler: @escaping (Error) -> Void) {
    
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: httpHeaders)
            .responseData(queue: defaultQueue) { response in
                
                guard response.error == nil else {
                    debugPrint("ERROR calling \(url.absoluteString), Error: \(String(describing: response.error))")
                    errorHandler(response.error!)
                    return
                }
                
                guard let responseData = response.data else {
                    debugPrint("ERROR calling \(url.absoluteString), No Data Found")
                    errorHandler(response.error!)
                    return
                }
                
                do{
                    let decoder = JSONDecoder()
                    let item = try decoder.decode(T.self, from: responseData )
                    debugPrint("SUCCESS calling \(url.absoluteString)")
                    completionHandler( item )
                    return
                } catch {
                    debugPrint("Could not decode data into \(T.self) \(url.absoluteString) \(error)")
                    errorHandler(error)
                }
        }
    }
    
    func getAlbums(completion: @escaping ((Albums) -> Void), error: @escaping (Error) -> Void) {
        
        let finalUrlString = "https://jsonplaceholder.typicode.com/albums"
        guard let url:URL = URL(string: finalUrlString ) else { return }
        let httpHeaders = standardHeaders
        
        callURL(url: url, method: .get, encoding: JSONEncoding.default, httpHeaders: httpHeaders, parameters: nil, completion: completion, error: error)
    }
    
    func searchAlbums(searchText: String, completion: @escaping ((Albums) -> Void), error: @escaping (Error) -> Void) {
        
        let urlString = "https://jsonplaceholder.typicode.com/albums?title=\(searchText)"
        let finalUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url:URL = URL(string: finalUrlString) else { return }
        let httpHeaders = standardHeaders
        
        callURL(url: url, method: .get, encoding: JSONEncoding.default, httpHeaders: httpHeaders, parameters: nil, completion: completion, error: error)
    }
    
    func getPhotos(albumId: Int, completion: @escaping ((Photos) -> Void), error: @escaping (Error) -> Void) {
        
        let finalUrlString = "https://jsonplaceholder.typicode.com/albums/\(albumId)/photos"
        guard let url:URL = URL(string: finalUrlString ) else { return }
        let httpHeaders = standardHeaders
        
        callURL(url: url, method: .get, encoding: JSONEncoding.default, httpHeaders: httpHeaders, parameters: nil, completion: completion, error: error)
        
    }
}

