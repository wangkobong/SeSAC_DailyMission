//
//  ViewController.swift
//  recomendBeer
//
//  Created by sungyeon kim on 2021/12/20.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let api = APIService()
    var beerData: BeerElement?
    
    let models = [
        "피자랑 같이 드셈",
        "치킨 사테랑 같이 드셈",
        "그냥 머거 좀",
        "피자랑 같이 드셈",
        "치킨 사테랑 같이 드셈",
        "그냥 머거 좀",
        "피자랑 같이 드셈",
        "치킨 사테랑 같이 드셈",
        "그냥 머거 좀",
        "피자랑 같이 드셈",
        "치킨 사테랑 같이 드셈",
        "그냥 머거 좀",

    ]

    

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    // arrow.up.bin
    //arrow.triangle.2.circlepath
    let refreshButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(refreshButtonPressed), for: .touchUpInside)
        button.setImage(UIImage(named: "arrow.up.bin"), for: .normal)
        button.tintColor = .systemCyan
        button.layer.borderColor = UIColor.systemCyan.cgColor
        button.layer.borderWidth = 2
//        button.configuration = .filled()
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        button.setTitle("Share BEER", for: .normal)
        button.backgroundColor = .systemCyan
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.requestRandomBeer { beer in
            self.beerData = beer
            print(Thread.isMainThread)
            DispatchQueue.main.async {
                print(self.beerData)
                self.tableView.reloadData()
            }
            print(self.beerData)
        }

        [tableView, refreshButton, shareButton].forEach {
            view.addSubview($0)
        }
        
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let header = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300))
        
        header.imageView.image = UIImage(named: "image")
        tableView.tableHeaderView = header
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.bottom.equalTo(refreshButton.snp.top).offset(-20)
        }
    
        refreshButton.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(50)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(0)
        }
        
        shareButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.equalTo(refreshButton.snp.trailing).offset(20)
            $0.trailing.equalTo(view).offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(0)
        }
        

    }
    

    
    @objc func refreshButtonPressed() {
        api.requestRandomBeer { beer in
            self.beerData = beer
            print(Thread.isMainThread)
            DispatchQueue.main.async {
                print(self.beerData)
                self.tableView.reloadData()
            }
            print(self.beerData)
        }
        print("refreshButtonPressed pressed")
    }
    
    @objc func shareButtonPressed() {
        print("shareButtonPressed pressed")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        beerData?.foodPairing.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
        cell.textLabel?.text = beerData?.foodPairing[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? StretchyTableHeaderView else { return }
        
        header.scrollViewDidScroll(scrollView: tableView)
    }
}
