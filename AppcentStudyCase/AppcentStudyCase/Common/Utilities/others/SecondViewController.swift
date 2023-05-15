//
//  SecondViewController.swift
//  AppcentStudyCase
//
//  Created by Emre Özbağdatlı on 14.05.2023.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var likedTableView: UITableView!
    @IBOutlet weak var likedLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red

        likedTableView.dataSource = self
        likedTableView.delegate = self
        
        
    }
    



}

extension SecondViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = likedTableView.dequeueReusableCell(withIdentifier: "likedCell",for: indexPath)
        cell.textLabel?.text = "test2"
        return cell
    }
    
    
    
}
