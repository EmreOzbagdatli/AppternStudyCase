//
//  FirstViewController.swift
//  AppcentStudyCase
//
//  Created by Emre Özbağdatlı on 14.05.2023.
//

import UIKit

class CategoryPageViewController: UIViewController {

    let titles = ["Tarkan","Sezen Aksu","Ebru Gündeş","Gülşen","Hadise","Simge","Eminem","Kaan Tangöze","50Cent","Drake","Michael Jackson","İsmail YK"]
    
    let pics = ["pic1","pic2","pic3","pic4","pic5","pic6","pic7","pic8","pic9","pic10","pic11","pic12"]
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        

        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    

  

}


extension CategoryPageViewController: UICollectionViewDelegate , UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionViewCell
        cell.imageView.image = UIImage(named: pics[indexPath.row])
        cell.backgroundColor = .systemBlue
        cell.imageLbl.text = titles[indexPath.row]
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSecondPage", sender: nil)
    }

    
    
}

extension CategoryPageViewController: UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 200)
    }
    
    
    
}
    

