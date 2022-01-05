//
//  InsertBoardViewController.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/05.
//

import UIKit

class InsertBoardViewController: UIViewController {
    
    private let insertBoardView = InsertBoardView()
    private let insertBoardViewModel = InsertBoardViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(didTabDone))
        
        insertBoardViewModel.text.bind { text in
            self.insertBoardView.textView.text = text
        }
        
        insertBoardView.textView.delegate = self

    }
    
    override func loadView() {
        self.view = insertBoardView
    }
    
    func postTextViewdDidChange(_ textView: UITextView) {
        insertBoardViewModel.text.value = textView.text ?? ""
    }
    
    @objc private func didTabDone() {
        print(#function)
        insertBoardViewModel.insertComment { post, success in
            if success {
                DispatchQueue.main.async {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    let vc = UINavigationController(rootViewController: BoardsViewController())
                    windowScene.windows.first?.rootViewController = vc
                    windowScene.windows.first?.makeKeyAndVisible()
                }
            } else {
                self.view.makeToast("내용을 입력해주세요", duration: 2.0, position: .center, title: "게시글작성 실패", image: nil)
            }
        }

    }

}

extension InsertBoardViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        postTextViewdDidChange(textView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        didTabDone()
    }
}
