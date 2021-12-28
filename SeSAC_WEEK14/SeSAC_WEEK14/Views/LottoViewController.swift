//
//  LottoViewController.swift
//  SeSAC_WEEK14
//
//  Created by sungyeon kim on 2021/12/28.
//

import UIKit
import SnapKit

class LottoViewController: UIViewController {
    
    let lottoViewModel = LottoViewModel()
    
    //1~7, 일자, 당첨 금액
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    let label5 = UILabel()
    let label6 = UILabel()
    let label7 = UILabel()
    let dateLabel = UILabel()
    let moneyLabel = UILabel()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.backgroundColor = .white
        view.distribution = .fillEqually
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottoViewModel.lotto1.bind { number in
            self.label1.text = "\(number)"
        }
        
        lottoViewModel.lotto2.bind { number in
            self.label2.text = "\(number)"
        }
        
        lottoViewModel.lotto3.bind { number in
            self.label3.text = "\(number)"
        }
        
        lottoViewModel.lotto4.bind { number in
            self.label4.text = "\(number)"
        }
        
        lottoViewModel.lotto5.bind { number in
            self.label5.text = "\(number)"
        }
        
        lottoViewModel.lotto6.bind { number in
            self.label6.text = "\(number)"
        }
        
        lottoViewModel.lotto7.bind { number in
            self.label7.text = "\(number)"
        }
        
        lottoViewModel.lottoMoney.bind { money in
            self.moneyLabel.text = money
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.height.equalTo(50)
            $0.center.equalTo(view)
        }
        [label1, label2, label3, label4, label5, label6, label7].forEach {
            $0.backgroundColor = .lightGray
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(dateLabel)
        dateLabel.backgroundColor = .white
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.height.equalTo(50)
        }
        
        view.addSubview(moneyLabel)
        moneyLabel.backgroundColor = .white
        moneyLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.height.equalTo(50)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.lottoViewModel.fetchLottoAPI(333)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            self.lottoViewModel.fetchLottoAPI(555)
        }
        

    }
}
