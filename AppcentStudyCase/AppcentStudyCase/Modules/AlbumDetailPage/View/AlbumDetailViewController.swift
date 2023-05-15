//
//  AlbumDetailViewController.swift
//  AppcentStudyCase
//
//  Created by Emre Özbağdatlı on 15.05.2023.
//

import UIKit
import Kingfisher
import AVFoundation

class AlbumDetailViewController: UIViewController {
    
    @IBOutlet weak var albumDetailTableView: UITableView!
    
    var audioPlayer: AVAudioPlayer!
        var trackList = [AlbumTrack]()
        var albumID: Int!
        var albumName: String!
        var artistName: String!
        var albumPhotoURL: String!
    var player: AVPlayer!
       var isPlaying = false
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            albumDetailTableView.dataSource = self
            albumDetailTableView.delegate = self
            self.getTracks()
        }
        
    @IBAction func didTouchBtn(_ sender: Any) {
        guard let button = sender as? UIButton,
                 let cell = button.superview?.superview as? AlbumDetailTableViewCell,
                 let indexPath = albumDetailTableView.indexPath(for: cell) else {
               return
           }

           let track = trackList[indexPath.row]
           if FavoritesManager.shared.isFavorite(track) {
               FavoritesManager.shared.removeFavorite(track)
               button.setImage(UIImage(systemName: "heart"), for: .normal)
           } else {
               FavoritesManager.shared.addFavorite(track)
               button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
           }
        
        
        
          
    }
    private func getTracks() {
            APICaller.shared.getAlbumTracks(with: albumID ?? 1) { result in
                switch result {
                case .success(let tracks):
                    print("API call successful")
                    self.trackList = tracks
                    DispatchQueue.main.async {
                        self.trackList = tracks
                        self.albumDetailTableView.reloadData()
                    }
                case .failure(let error):
                    print("API call failed:", error.localizedDescription)
                }
            }
        }
    
    func downloadFileFromURL(url: URL){
        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url) { (url, response, error) in
            self.play(url: url!)
        }
        downloadTask.resume()
    }
    
    func play(url:URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url as URL)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
            audioPlayer.play()
            
            Timer.scheduledTimer(withTimeInterval: 30, repeats: false) { timer in
                      self.audioPlayer.stop()
                      self.isPlaying = false
                  }
        } catch let error as NSError {
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
    }

    extension AlbumDetailViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return trackList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumDetailViewCell", for: indexPath) as? AlbumDetailTableViewCell else {
                return UITableViewCell()
            }
            
            let track = self.trackList[indexPath.row]
            cell.albumDetailImageView.image = nil

            cell.albumDetailImageView.kf.setImage(with: URL(string: "\( self.albumPhotoURL ?? "")"),placeholder: nil,options: [.transition(.fade(0.7))])
                    let seconds = track.duration!
                    let minutes = seconds / 60
                    cell.songTimerLbl.text = "\(minutes) dakika \(seconds % 60) saniye"
                
            cell.SongNameLbl.text = track.title
            
            cell.likedButton.tag = indexPath.row
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let track = trackList[indexPath.row]

            if let url = URL(string: track.preview ?? "") {
                if isPlaying {
                    audioPlayer.stop()
                    isPlaying = false
                    
                }
                
                downloadFileFromURL(url: url)
                isPlaying = true
            }
        }
    }
