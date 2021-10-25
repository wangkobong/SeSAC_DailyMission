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

class ViewController: UIViewController {

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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDrawResult(861)
    }
    
    func getDrawResult(_ drawNo: Int) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drawNo)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }


}

