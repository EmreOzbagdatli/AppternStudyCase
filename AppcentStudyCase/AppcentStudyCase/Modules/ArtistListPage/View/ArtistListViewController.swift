//
//  ThirdViewController.swift
//  AppcentStudyCase
//
//  Created by Emre Özbağdatlı on 14.05.2023.
//

import UIKit

class ArtistListViewController: UIViewController {    
    
    @IBOutlet weak var artistListCollectionView: UICollectionView!
    @IBOutlet weak var artistListTitle: UILabel!
    
    var genreID: Int!
        var genreName: String!
        var artistList = [GenreArtist]()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()


        artistListCollectionView.dataSource = self
        artistListCollectionView.delegate = self
        getArtist()

    }
    private func getArtist(){
           
           APICaller.shared.getGenreArtist(with: genreID ?? 1 ) { data in
               switch(data)
               {
               case .success(let artist):
                   DispatchQueue.main.async{
                       self.artistList = artist.data ?? [GenreArtist]()
                       self.artistListCollectionView.reloadData()
                   }
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }

       }

}

extension ArtistListViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artistList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = artistListCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ArtistListCollectionViewCell
        
        cell.artistListLbl.text = self.artistList[indexPath.row].name
               cell.artistListImageView.kf.setImage(with: URL(string: "\(self.artistList[indexPath.row].picture_xl ?? "")"),placeholder: nil,options: [.transition(.fade(0.7))])

        return cell
    }
    


    
    
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let artist = artistList[indexPath.row]
           performSegue(withIdentifier: "toArtistDetailVC", sender: artist)
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toArtistDetailVC", let artistDetailVC = segue.destination as? ArtistDetailViewController, let artist = sender as? GenreArtist {
            artistDetailVC.artistID = artist.id
            artistDetailVC.artistName = artist.name
            artistDetailVC.artistPictureURL = URL(string: artist.picture_xl ?? "")
        }
    }

}

extension ArtistListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 200)
    }
}
