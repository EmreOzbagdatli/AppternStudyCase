//
//  AlbumDetailViewController.swift
//  AppcentStudyCase
//
//  Created by Emre Özbağdatlı on 15.05.2023.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    @IBOutlet weak var albumDetailTableView: UITableView!
    
    @IBOutlet weak var albumDetailPageTitle: UILabel!
    
    let tarih = ["11.02.2012"]
    let AlbumIsmi = ["Firuzem"]
    let AlbumResmi = ["pic3","pic5","pic2","pic1","pic4","pic6","pic7","pic8","pic9","pic10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        albumDetailTableView.dataSource = self
        albumDetailTableView.delegate = self
        
        
    }
    



}

extension AlbumDetailViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlbumResmi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumDetailTableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! AlbumDetailTableViewCell
        
        cell.albumDetailImageView.image = UIImage(named: AlbumResmi[indexPath.row])
        cell.SongNameLbl.text = AlbumIsmi[0]
        cell.songTimerLbl.text = tarih[0]
        
        return cell
    }
    
  
    
   
    
    
}
