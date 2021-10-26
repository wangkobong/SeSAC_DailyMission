//
//  BoxOfficeViewController.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/26.
//

import UIKit
import SwiftyJSON
import Alamofire
import TweeTextField

class BoxOfficeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var boxOfficeTableView: UITableView!
    var boxOfficeData: [BoxOfficeModel] = []

    @IBOutlet weak var releaseDateTextField: TweeAttributedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxOfficeTableView.delegate = self
        boxOfficeTableView.dataSource = self
        
        
//        releaseDateTextField.activeLineColor = .systemBlue
//        releaseDateTextField.activeLineWidth = 1
//        releaseDateTextField.animationDuration = 0.3

        fetchBoxOfficeData()
    }
    

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        print("검색")
    }
    
    func fetchBoxOfficeData() {
        let boxOfficeKey = Bundle.main.boxOfficeKey
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(boxOfficeKey)&targetDt=20211025"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let title = item["movieNm"].stringValue
                    let releaseDate = item["openDt"].stringValue
                    let data = BoxOfficeModel(titleData: title, releaseData: releaseDate)
                    self.boxOfficeData.append(data)
                }
                self.boxOfficeTableView.reloadData()
                print("boxOfficeData : \(self.boxOfficeData)")
                
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as? BoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        
        let row = boxOfficeData[indexPath.row]
        
        cell.movieTitleLabel.text = row.titleData
        cell.orderLabel.text = String(indexPath.row + 1)
        cell.releaseDateLabel.text = row.releaseData
        
        print("cell : \(cell)")
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
//
    
    
    
}

