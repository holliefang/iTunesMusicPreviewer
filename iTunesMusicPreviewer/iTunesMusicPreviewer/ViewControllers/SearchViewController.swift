//
//  ViewController.swift
//  iTunesMusicPreviewer
//
//  Created by 方思涵 on 2021/7/17.
//

import UIKit
import AVFoundation
import AVKit

class SearchViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModels()
        print("=======")
    }
    
    private func bindViewModels() {
        viewModel.tracksDidUpdate = { [weak self] in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.emptyTrackDidUpdate = { [weak self] in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.showNoResultAlert()
                
            }
        }
    }
    
    func playDownload(_ track: Track) {
        guard let url = URL(string: track.previewUrl) else {
            return
        }
        
        let playerViewController = AVPlayerViewController()
        present(playerViewController, animated: true, completion: nil)
        
        let player = AVPlayer(url: url)
        playerViewController.player = player
        player.play()
    }
    
    func showNoResultAlert() {
        let alert = UIAlertController(title: "No Result", message: "No track found", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: false, completion: nil)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.reuseID, for: indexPath) as! TrackCell
        cell.set(viewModel.track(at: indexPath))
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playDownload(viewModel.track(at: indexPath))
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text, !keyword.isEmpty else {
            return
        }
        viewModel.getTracks(keyword: keyword)
    }
}
