//
//  Alert+Extension.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/21.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, okTitle: String, okAction: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: okTitle, style: .default) { _ in
            okAction()
        }
        

        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true) {
            print("alert")
        }
    }
}
