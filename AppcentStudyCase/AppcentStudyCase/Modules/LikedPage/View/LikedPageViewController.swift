//
//  SecondViewController.swift
//  AppcentStudyCase
//
//  Created by Emre Özbağdatlı on 14.05.2023.
//

import UIKit

class LikedPageViewController: UIViewController {

    @IBOutlet weak var likedTableView: UITableView!
    
    var favoritesList = [AlbumTrack]()
    var albumPhotoURL: String!

        
        override func viewDidLoad() {
            super.viewDidLoad()

            // Set up table view
            likedTableView.dataSource = self
            likedTableView.delegate = self
            
            // Get saved favorite tracks from FavoritesManager
            favoritesList = FavoritesManager.shared.getFavorites()
            self.likedTableView.reloadData()

        }
    }

    extension LikedPageViewController: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favoritesList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "likedCell", for: indexPath) as? LikedTableViewCell else {
                return UITableViewCell()
            }
            
            let track = favoritesList[indexPath.row]
            cell.likedSongNameLbl.text = track.title
            
            cell.likedImageView.image = nil

            cell.likedImageView.kf.setImage(with: URL(string: "\( self.albumPhotoURL ?? "")"),placeholder: nil,options: [.transition(.fade(0.7))])
                   
            let seconds = track.duration!
                    let minutes = seconds / 60
                    cell.likedSongTimerLbl.text = "\(minutes) dakika \(seconds % 60) saniye"
                
        
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedTrack = favoritesList[indexPath.row]
            if let url = URL(string: selectedTrack.preview ?? "") {
            }
        }
    }
