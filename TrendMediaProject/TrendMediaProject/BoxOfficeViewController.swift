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
    var yesterdayDateToString = ""

    @IBOutlet weak var releaseDateTextField: TweeAttributedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxOfficeTableView.delegate = self
        boxOfficeTableView.dataSource = self

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let yesterday = Date.yesterday
        yesterdayDateToString = dateFormatter.string(from: yesterday)


        print(yesterdayDateToString)
//        releaseDateTextField.activeLineColor = .systemBlue
//        releaseDateTextField.activeLineWidth = 1
//        releaseDateTextField.animationDuration = 0.3

        fetchBoxOfficeData(yesterdayDateToString)
    }
    

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        print("검색")
    }
    
    func fetchBoxOfficeData(_ yesterdayDate: String) {
        let boxOfficeKey = Bundle.main.boxOfficeKey
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(boxOfficeKey)&targetDt=\(yesterdayDate)"
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
        if row.releaseData != "" {
            cell.releaseDateLabel.text = row.releaseData
        } else {
            cell.releaseDateLabel.text = "해당 정보가 존재하지 않습니다."
        }

        
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
//
    
    
    
}

// MARK: - get date
extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
