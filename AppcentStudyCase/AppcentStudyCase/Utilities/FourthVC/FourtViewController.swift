//
//  FourtViewController.swift
//  AppcentStudyCase
//
//  Created by Emre Özbağdatlı on 14.05.2023.
//

import UIKit

class FourtViewController: UIViewController {

    @IBOutlet weak var tableViewFourth: UITableView!
    @IBOutlet weak var baslikLblfourt: UILabel!
    
    @IBOutlet weak var imageViewFourth: UIImageView!
    
    
    let tarih = ["11.02.2012"]
    let AlbumIsmi = ["Firuzem"]
    let AlbumResmi = ["pic3","pic5","pic2","pic1","pic4","pic6","pic7","pic8","pic9","pic10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableViewFourth.dataSource = self
        tableViewFourth.delegate = self
        
        imageViewFourth.image = UIImage(named: "pic1")
        
    }
    


}

extension FourtViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewFourth.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! FourthTableViewCell
       

        cell.albumImageView.layer.borderWidth = 1.5
        cell.albumImageView.clipsToBounds = true
        cell.albumImageView.layer.cornerRadius = CGRectGetWidth(cell.albumImageView.frame)/2.0;

        cell.albumCikisLbl.text = tarih[0]
        cell.albumImageView.image = UIImage(named: AlbumResmi[indexPath.row])
        cell.albumIsmiLbl.text = AlbumIsmi[0]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toLast", sender: nil)
    }
    
}

