//
//  NetworkService.swift
//  iTunesMusicPreviewer
//
//  Created by 方思涵 on 2021/7/17.
//

import Foundation

class NetworkService {
    
    private let session = URLSession.init(configuration: .default)
    
    func getTracks(keywords: String, completion: @escaping (([Track]) -> Void)) {
        
        guard let urlString = "https://itunes.apple.com/search?media=music&term=\(keywords)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString) else {
            return
        }
        session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            if let result = try? JSONDecoder().decode(TrackResult.self, from: data) {
                completion(result.results)
            }
        }.resume()
    }
}
