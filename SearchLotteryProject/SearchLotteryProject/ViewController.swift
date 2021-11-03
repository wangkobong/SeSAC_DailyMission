//
//  ViewController.swift
//  SearchLotteryProject
//
//  Created by sungyeon kim on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON

/*
 내가 필요한거
 1. 추첨날짜
 2. 회차
 3. 당첨번호 7개
 */

class ViewController: UIViewController, UITextFieldDelegate {
    
    var numberOfPickerViews = Array(1...999)

    @IBOutlet weak var drawNumberTextFiled: UITextField!
    @IBOutlet weak var drawDateLabel: UILabel!
    @IBOutlet weak var drawNumberLabel: UILabel!
    
    @IBOutlet weak var firstWinNumber: UILabel!
    @IBOutlet weak var secondWinNumber: UILabel!
    @IBOutlet weak var thirdWinNumber: UILabel!
    @IBOutlet weak var fourthWinNumber: UILabel!
    @IBOutlet weak var fifthWinNumber: UILabel!
    @IBOutlet weak var sixthWinNumber: UILabel!
    @IBOutlet weak var bonusWinNumber: UILabel!
    
    @IBOutlet weak var winNumbersView: UIView!
    
    @IBOutlet weak var winNumberPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawNumberTextFiled.delegate = self
        drawNumberTextFiled.addDoneButtonToKeyboard(myAction:  #selector(self.drawNumberTextFiled.resignFirstResponder))
        
        let calendar = Calendar.current
        var component = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear, .weekday,], from: Date())
        component.weekday = 1
        let saturdayWeek = calendar.date(from: component)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let saturdayWeekToString = dateFormatter.string(for: saturdayWeek)
        print(saturdayWeekToString!)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func getDrawNumber() {
        
    }
    
    
    func getDrawResult(_ drawNo: Int) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drawNo)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let drawNumber = json["drwNo"]
                if json["returnValue"] != "fail" {
                    self.winNumbersView.alpha = 1
                    self.drawDateLabel.text = json["drwNoDate"].stringValue + " 추첨"
                    self.drawNumberLabel.text = "\(drawNumber)회차 당첨결과"
                    self.firstWinNumber.text = String(json["drwtNo1"].intValue)
                    self.secondWinNumber.text = String(json["drwtNo2"].intValue)
                    self.thirdWinNumber.text = String(json["drwtNo3"].intValue)
                    self.fourthWinNumber.text = String(json["drwtNo4"].intValue)
                    self.fifthWinNumber.text = String(json["drwtNo5"].intValue)
                    self.sixthWinNumber.text = String(json["drwtNo6"].intValue)
                    self.bonusWinNumber.text = String(json["bnusNo"].intValue)
                } else {
                    self.drawNumberLabel.text = "존재하지 않는 회차입니다."
                    self.drawDateLabel.text = ""
                    self.winNumbersView.alpha = 0
                }
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
        
    }


}

// MARK: - UITextFieldDelegate

extension ViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        drawNumberTextFiled.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "회차를 입력해주세요"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let drawNumber = drawNumberTextFiled.text {
            getDrawResult(Int(drawNumber) ?? 999999)
        }
        drawNumberTextFiled.text = ""
    }
}

// MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        numberOfPickerViews.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        drawNumberTextFiled.text = String(component)
        drawNumberTextFiled.inputView = winNumberPickerView
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            150
        }
}



// MARK: - 숫자패드에 리턴키 넣기
extension UITextField{

 func addDoneButtonToKeyboard(myAction:Selector?){
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    doneToolbar.barStyle = UIBarStyle.default

     let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
     let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: myAction)

    var items = [UIBarButtonItem]()
    items.append(flexSpace)
    items.append(done)

    doneToolbar.items = items
    doneToolbar.sizeToFit()

    self.inputAccessoryView = doneToolbar
 }
}
