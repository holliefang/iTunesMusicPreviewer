//
//  NetworkService.swift
//  iTunesMusicPreviewer
//
//  Created by 方思涵 on 2021/7/17.
//

import Foundation

class NetworkService {
    
    private init() {}
    static let shared = NetworkService()
    private let session = URLSession.init(configuration: .default)
    
    func getTracks(keyword: String, completion: @escaping ((Bool, [Track]) -> Void)) {
        
        guard let urlString = "https://itunes.apple.com/search?media=music&term=\(keyword)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString) else {
            //MARK: return custom error
            completion(false, [])
            return
        }
        session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(false, [])
                return
            }
            if let result = try? JSONDecoder().decode(TrackResult.self, from: data) {
                completion(true, result.results)
            }
        }.resume()
    }
}
