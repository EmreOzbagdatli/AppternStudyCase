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
    
    
    let tarih = ["11.02.2012"]
    let AlbumIsmi = ["Tarkan","Sezen Aksu","Ebru Gündeş","Gülşen","Hadise","Simge","Eminem","Kaan Tangöze","50Cent","Drake","Michael Jackson","İsmail YKalksdnmklsandklsandklnaksldna"]
    
    let AlbumResmi = ["pic3","pic5","pic2","pic1","pic4","pic6","pic7","pic8","pic9","pic10","pic11","pic12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        artistDetailTableView.dataSource = self
        artistDetailTableView.delegate = self
        
        artistDetailImageView.image = UIImage(named: "pic5")
        
    }
    


}

extension ArtistDetailViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlbumIsmi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = artistDetailTableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! ArtistDetailViewCell
       

        cell.albumImageView.layer.borderWidth = 1.5
        cell.albumImageView.clipsToBounds = true

        cell.albumCikisLbl.text = tarih[0]
        cell.albumImageView.image = UIImage(named: AlbumResmi[indexPath.row])
        cell.albumIsmiLbl.text = AlbumIsmi[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toAlbumDetailPage", sender: nil)
    }
    
}

