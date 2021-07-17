//
//  SearchViewModel.swift
//  iTunesMusicPreviewer
//
//  Created by 方思涵 on 2021/7/17.
//

import Foundation

class SearchViewModel {
    
    var tracks: [Track] = [] {
        didSet {
            tracksDidUpdate?()
        }
    }
    
    var tracksDidUpdate: (() -> ())?
    var emptyTrackDidUpdate: (() -> ())?
    
    func getTracks(keyword: String) {
        NetworkService().getTracks(keywords: keyword) { tracks in
            self.tracks = tracks
            if tracks.isEmpty {
                self.emptyTrackDidUpdate?()
            }
        }
    }
}
