//
//  CastmatesTableViewController.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/17.
//

import UIKit

class CastmatesTableViewController: UITableViewController {

//    var mediaData = Media?
    var mediaTitle: String?
    var releaseDate: String?
    var genre: String?
    var region: String?
    var overview: String?
    var rate: Double?
    var starring: String?
    var backdropImage: String?
    var actorList: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = mediaTitle ?? "내용 없음"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        actorList = starring?.components(separatedBy: ",")
        return actorList?.count ?? 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastmatesTableViewCell", for: indexPath) as? CastmatesTableViewCell else {
            return UITableViewCell()
        }

        cell.nameLabel.text = actorList?[indexPath.row]
        cell.roleLabel.text = " \(genre ?? "배우")"

        return cell
    }

}
