//
//  TrackCell.swift
//  iTunesMusicPreviewer
//
//  Created by 方思涵 on 2021/7/17.
//

import UIKit

class TrackCell: UITableViewCell {
    
    static let reuseID = "TrackCell"
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    func set(_ track: Track) {
        artistLabel.text = track.artistName
        titleLabel.text = track.trackName
    }
}


