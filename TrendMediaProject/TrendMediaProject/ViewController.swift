//
//  ViewController.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/15.
//

// present로 b화면 구현하기

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mediaInformation = MediaInformation()

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchTableViewController") as! SearchTableViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        //        nav.modalTransitionStyle = .flipHorizontal
        self.present(nav, animated: true, completion: nil)


    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaInformation.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as? MediaTableViewCell else {
            return UITableViewCell()
        }
        
        let row = mediaInformation.tvShow[indexPath.row]
//        let url = URL(string: row.backdropImage)
        cell.titleTextLabel.text = row.title
        cell.overviewLabel.text = row.overview
        cell.overviewLabel.numberOfLines = 0
        cell.genreTextLabel.text = row.genre
        cell.rateLabel.text = String(row.rate)
        cell.releaseDateLabel.text = row.releaseDate
//        do {
//            let data = try Data(contentsOf: url!)
//            cell.posterImageView.image = UIImage(data: data)
//            cell.posterImageView.contentMode = .scaleToFill
//            cell.posterImageView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
//        } catch {
//            print(error)
//        }
   
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)

        guard let vc = sb.instantiateViewController(withIdentifier: "CastmatesTableViewController") as? CastmatesTableViewController else {
            print("ERROR") // 대신에 Alert으로 사용자에게 에러를 보여줌
            return
        }
        
        let row = mediaInformation.tvShow[indexPath.row]
        vc.mediaTitle = row.title
        vc.releaseDate = row.releaseDate
        vc.genre = row.genre
        vc.region = row.region
        vc.overview = row.overview
        vc.rate = row.rate
        vc.starring = row.starring
        vc.backdropImage = row.backdropImage
        self.navigationController?.pushViewController(vc, animated: true)

    }

}

