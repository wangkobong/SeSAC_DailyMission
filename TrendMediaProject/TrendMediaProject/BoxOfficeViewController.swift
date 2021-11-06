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
import RealmSwift

class BoxOfficeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    /*
     1. 사용자가 처음 앱을 실행했을 때 API 호출을 하고 Response 중 사용자에게 보여주고 싶은 항목을 DB에 저장
     2. DB에 어제 날짜가 있다면 fetch를 하지않고 DB에서 값을 가져오기
     
     */
    let localRealm = try! Realm()
    var boxOfficeData: [BoxOfficeModel] = []
    var yesterdayDateToString = ""
    var registerDateToString = ""
    var tasks: Results<BoxOffice>!
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var boxOfficeTableView: UITableView!

    @IBOutlet weak var releaseDateTextField: TweeAttributedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxOfficeTableView.delegate = self
        boxOfficeTableView.dataSource = self
        createDatePickerView()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let yesterday = Date.yesterday
        yesterdayDateToString = dateFormatter.string(from: yesterday)
        let regDate = Date()
        registerDateToString = dateFormatter.string(from: regDate)
        tasks = localRealm.objects(BoxOffice.self).filter("searchDate == '\(yesterdayDateToString)'")
         //sorted(byKeyPath: "relaseDate", ascending: false)

//        releaseDateTextField.activeLineColor = .systemBlue
//        releaseDateTextField.activeLineWidth = 1
//        releaseDateTextField.animationDuration = 0.3
  
        
//        tasks[0].searchDate != yesterdayDateToString ? fetchBoxOfficeData(searchDate: yesterdayDateToString ) : print("이미 검색됨")
        print(Results<BoxOffice>.self)
        tasks.isEmpty ? fetchBoxOfficeData(searchDate: yesterdayDateToString) : print("데이터존재")
        print("Realm is located at:", localRealm.configuration.fileURL!)
        print("viewDidLoad \(viewDidLoad)")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let searchDate = releaseDateTextField.text ?? "0000000"
        let filter = localRealm.objects(BoxOffice.self).filter("searchDate == '\(searchDate)'")
        filter.isEmpty ? fetchBoxOfficeData(searchDate: searchDate) : print("이미 검색됨")
        tasks = localRealm.objects(BoxOffice.self).filter("searchDate == '\(searchDate)'")
        boxOfficeTableView.reloadData()
    }
    
    func fetchBoxOfficeData(searchDate: String) {
        print(#function)
        let boxOfficeKey = Bundle.main.boxOfficeKey
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(boxOfficeKey)&targetDt=\(searchDate)"
        AF.request(url, method: .get).validate().responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let title = item["movieNm"].stringValue
                    let releaseDate = item["openDt"].stringValue
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyyMMdd"
                    let regDate = Date()
                    let task = BoxOffice(movieTitle: title, relaseDate: releaseDate, registerDate: regDate, searchDate: searchDate)
                    try! self.localRealm.write {
                        self.localRealm.add(task)
                    }
                    
                }
                self.boxOfficeTableView.reloadData()

            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func createDatePickerView(){
        //toolbar 만들기, done 버튼이 들어갈 곳
        let toolbar = UIToolbar()
        toolbar.sizeToFit() //view 스크린에 딱 맞게 사이즈 조정
        
        //버튼 만들기
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target : nil, action: #selector(donePressed))
        //action 자리에는 이후에 실행될 함수가 들어간다?
        
        //버튼 툴바에 할당
        toolbar.setItems([doneButton], animated: true)
        
        //toolbar를 키보드 대신 할당?
        releaseDateTextField.inputAccessoryView = toolbar
        
        //assign datepicker to the textfield, 텍스트 필드에 datepicker 할당
        releaseDateTextField.inputView = datePicker
        
        //datePicker 형식 바꾸기
        datePicker.datePickerMode = .date
    }
    
    @objc func donePressed(){
        //formatter
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        releaseDateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    


    @objc func checkButtonClicked(kobong: UIButton) {
        
        
        print(tasks[kobong.tag].movieTitle)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as? BoxOfficeTableViewCell else {
            return UITableViewCell()
        }
//        print("cellForRowAt \(tasks)")
        let row = tasks[indexPath.row]
        
        cell.movieTitleLabel.text = row.movieTitle
        cell.orderLabel.text = String(indexPath.row + 1)
        if row.relaseDate != "" {
            cell.releaseDateLabel.text = row.relaseDate
        } else {
            cell.releaseDateLabel.text = "해당 정보가 존재하지 않습니다."
        }
        
        return cell
    }
    
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


extension UITextField {
    func setDatePicker(target: Any, selector: Selector) {
        let SCwidth = self.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: SCwidth, height: 216))
        datePicker.datePickerMode = .date
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: SCwidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
        
    }
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}
