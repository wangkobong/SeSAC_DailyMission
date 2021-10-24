//
//  FilterAlert+Extension.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/24.
//

import UIKit

extension UIViewController {
    func filterAlert(title: String, message: String, okTitle: String, okAction: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let cancel = UIAlertAction(title: "취소", style: .cancel)
//        let ok = UIAlertAction(title: okTitle, style: .default) { _ in
//            okAction()
//        }
        let lottecinema = UIAlertAction(title: okTitle, style: .default) { _ in
            okAction()
        }
        
        let megabox = UIAlertAction(title: okTitle, style: .default) { _ in
            okAction()
        }
        
        let cgv = UIAlertAction(title: okTitle, style: .default) { _ in
            okAction()
        }
        

        alert.addAction(lottecinema)
        alert.addAction(megabox)
        alert.addAction(cgv)
        
        self.present(alert, animated: true) {
            print("alert")
        }
    }
}
