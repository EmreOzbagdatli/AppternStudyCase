//
//  ThirdViewController.swift
//  AppcentStudyCase
//
//  Created by Emre Özbağdatlı on 14.05.2023.
//

import UIKit

class ThirdViewController: UIViewController {

    let titles = ["1","2","3","4","5","6","7","8","10"]
    let pics = ["pic1","pic2","pic3","pic4","pic5","pic6","pic7","pic8","pic8","pic9","pic10","pic11","pic12"]
    
    
    @IBOutlet weak var collectionViewx: UICollectionView!
    @IBOutlet weak var titleLblx: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        collectionViewx.dataSource = self
        collectionViewx.delegate = self
        

    }

}

extension ThirdViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellx", for: indexPath) as! SecondPageCollectionViewCell
        cell.imageViewx.image = UIImage(named: pics[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toFourth", sender: nil)
    }
    
}

extension ThirdViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 200)
    }
}
