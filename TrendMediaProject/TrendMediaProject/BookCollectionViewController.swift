//
//  BookCollectionViewController.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/20.
//

import UIKit
import Kingfisher

class BookCollectionViewController: UIViewController {
    
    var mediaInformation = MediaInformation()

    @IBOutlet var bookCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        let nibName = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        bookCollectionView.register(nibName, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: 150, height: (width / 3) * 1.2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        bookCollectionView.collectionViewLayout = layout
        
    }
    

}

// MARK: - CollectionView

extension BookCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaInformation.tvShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = mediaInformation.tvShow[indexPath.item]
        let url = URL(string: item.backdropImage)
        cell.bookTitleLabel.text = item.title
        cell.bookImageView.kf.setImage(with:url)
        cell.bookRateLabel.text = String(item.rate)
        cell.backgroundColor = .random()
        return cell
    }
    
    
}

// MARK: - random color
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
