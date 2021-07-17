//
//  Track.swift
//  iTunesMusicPreviewer
//
//  Created by 方思涵 on 2021/7/17.
//

import Foundation

struct TrackResult: Decodable {
    let resultCount: Int
    let results: [Track]
}

struct Track: Decodable {
    let artistName: String
    let trackName: String
    let previewUrl: String
}
