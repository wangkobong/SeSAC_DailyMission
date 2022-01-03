//
//  HomeView.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/01.
//

import UIKit
import SnapKit

protocol ViewRepresentable {
    func setupView()
    func setupConstraints()
}

class HomeView: UIView, ViewRepresentable {

    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo_clear"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "당신 근처의 새싹농장"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.text = "iOS 지식부터 바람의 나라까지\n 지금 SeSAC에서 함께해보세요!"
        return label
    }()
    
    
    let startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let askHavingAccountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .lightGray
        label.text = "이미 계정이 있나요?"
        return label
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    



    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupView() {
        
        [imageView, titleLabel, descriptionLabel, startButton, askHavingAccountLabel, loginButton].forEach {
            addSubview($0)
        }
    }
    
    internal func setupConstraints() {
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(150)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(10)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(askHavingAccountLabel.snp.top).offset(-20)
            $0.width.equalTo(self.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
        }
        
        askHavingAccountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        loginButton.snp.makeConstraints {
            $0.leading.equalTo(askHavingAccountLabel.snp.trailing).offset(2)
            $0.bottom.equalTo(askHavingAccountLabel)
            $0.height.equalTo(askHavingAccountLabel)
        }
        

    }

}
