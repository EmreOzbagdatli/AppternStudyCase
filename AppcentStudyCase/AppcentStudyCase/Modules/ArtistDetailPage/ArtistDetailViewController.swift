//
//  FourtViewController.swift
//  AppcentStudyCase
//
//  Created by Emre Özbağdatlı on 14.05.2023.
//

import UIKit

class ArtistDetailViewController: UIViewController {
    
    @IBOutlet weak var artistDetailTableView: UITableView!
    
    @IBOutlet weak var artistDetailPageTitle: UILabel!
    
    @IBOutlet weak var artistDetailImageView: UIImageView!
    
    var artistID: Int!
    var artistName: String!
    var artistAlbums = [ArtistAlbum]()
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        artistDetailTableView.dataSource = self
        artistDetailTableView.delegate = self
        
        artistDetailImageView.image = UIImage(named: "pic5")
        getArtistAlbums()
        
    }
    
    private func getArtistAlbums(){
        
        APICaller.shared.getArtistAlbums(with: artistID ?? 1) { data in
            switch(data)
            {
            case .success(let album):
                DispatchQueue.main.async{
                    self.artistAlbums = album.data ?? [ArtistAlbum]()
                    self.artistDetailTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
        
    }
    
    extension ArtistDetailViewController: UITableViewDelegate , UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return artistAlbums.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = artistDetailTableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! ArtistDetailViewCell
            
            
            cell.albumImageView.layer.borderWidth = 1.5
            cell.albumImageView.clipsToBounds = true
            
            let album = artistAlbums[indexPath.row]
                   cell.albumImageView.kf.setImage(with: URL(string: "\(album.cover_xl ?? "")"),placeholder: nil,options: [.transition(.fade(0.7))])
                   cell.albumIsmiLbl.text = album.title ?? ""
                   var releaseDate = ""
                   if album.release_date != nil{
                       releaseDate = Utils.shared.convertDate(dateString: album.release_date!)
                   }
                       
                   cell.albumCikisLbl.text = "'\(releaseDate)"
                   return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "toAlbumDetailPage", sender: nil)
        }
        
    }
    

