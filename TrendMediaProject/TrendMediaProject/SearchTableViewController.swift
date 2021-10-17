//
//  SearchTableViewController.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/17.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    var mediaInformation = MediaInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonPressed))


    }
    
    @objc func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mediaInformation.tvShow.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        let row = mediaInformation.tvShow[indexPath.row]
        
//        cell.posterImage.image = UIImage(named: row.title)
        cell.mediaTitleLabel.text = row.title
        cell.releaseDateLabel.text = row.releaseDate
        cell.overviewLabel.text = row.overview
        cell.overviewLabel.numberOfLines = 0
        cell.regionLabel.text = row.region
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }


}
