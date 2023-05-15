//
//  FirstViewController.swift
//  AppcentStudyCase
//
//  Created by Emre Özbağdatlı on 14.05.2023.
//

import UIKit
import Kingfisher

class CategoryPageViewController: UIViewController {
    
    var genres = [Genre]()
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self

        
        getGenres()

    }
    
    private func getGenres(){
           APICaller.shared.getGenres { data in
               switch(data)
               {
               case .success(let genres):
                   DispatchQueue.main.async {
                       self.genres = genres.data ?? [Genre]()
                       self.collectionView.reloadData()
                   }
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
       }
}


extension CategoryPageViewController: UICollectionViewDelegate , UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryPageCell", for: indexPath) as! CategoryCollectionViewCell

        let categoryPage = genres[indexPath.row]
        cell.categoryName.text = categoryPage.name
        
        cell.imageView.image = UIImage(named: self.genres[indexPath.row].picture_medium ?? "")
              
              cell.imageView.kf.setImage(with: URL(string: "\(self.genres[indexPath.row].picture_xl ?? "")"),placeholder: nil,options: [.transition(.fade(0.7))])
              
        return cell
        
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let choosenGenre = genres[indexPath.row]
        performSegue(withIdentifier: "toSecondPage", sender: choosenGenre)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondPage" {
            if let artistVC = segue.destination as? ArtistListViewController,
               let choosenGenre = sender as? Genre {
                artistVC.genreID = choosenGenre.id!
                artistVC.genreName = choosenGenre.name!
            }
        }
    }

}

extension CategoryPageViewController: UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 200)
    }
}
    

