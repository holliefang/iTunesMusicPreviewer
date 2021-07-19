//
//  SearchViewModel.swift
//  iTunesMusicPreviewer
//
//  Created by 方思涵 on 2021/7/17.
//

import Foundation

class SearchViewModel {
    
    private var tracks: [Track] = [] {
        didSet {
            tracksDidUpdate?()
        }
    }
    
    private let networkService = NetworkService.shared
    var tracksDidUpdate: (() -> ())?
    var emptyTrackDidUpdate: (() -> ())?
    
    var numberOfRows: Int {
        return tracks.count
    }
    
    func track(at indexPath: IndexPath) -> Track {
        return tracks[indexPath.row]
    }
    
    func getTracks(keyword: String) {
        networkService.getTracks(keyword: keyword) { success, tracks in
            guard success else {
                //MARK: handle error here
                return
            }
            self.tracks = tracks
            if tracks.isEmpty {
                self.emptyTrackDidUpdate?()
            }
        }
    }
}
