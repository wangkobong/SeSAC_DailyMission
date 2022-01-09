//
//  InsertBoardViewController.swift
//  SeSAC_Community
//
//  Created by sungyeon kim on 2022/01/05.
//

import UIKit

class InsertBoardViewController: UIViewController {
    
    private let insertBoardView = InsertBoardView()
    private let insertBoardViewModel = InsertPostViewModel()
    private let updatePostViewModel = UpdatePostViewModel()
    var isInsert = true
    var currentPost: [PostElement] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setRightBarButtonItem()
        setText()
        
        insertBoardViewModel.text.bind { text in
            self.insertBoardView.textView.text = text
        }
        
        insertBoardView.textView.delegate = self
        print("InsertBoardViewController currentPost: \(currentPost)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        currentPost.removeAll()
    }
    
    override func loadView() {
        self.view = insertBoardView
    }
    
    func setRightBarButtonItem() {
        if isInsert {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(didTabDone))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "게시글 수정", style: .done, target: self, action: #selector(didTabUpdate))
        }
    }
    
    func setText() {
        print(#function)
        if currentPost.isEmpty {
            print("작성화면")
        } else {
            print("수정화면")
            insertBoardViewModel.text.value = currentPost[0].text
        }
    }
    
    func postTextViewdDidChange(_ textView: UITextView) {
        if currentPost.isEmpty {
            insertBoardViewModel.text.value = textView.text ?? ""
        } else {
            updatePostViewModel.text2.value = textView.text ?? ""
        }

    }
    
    
    
    @objc private func didTabDone() {
        print(#function)
        insertBoardViewModel.insertPost { post, success in
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
    
    @objc private func didTabUpdate() {
        print(#function)
        let currentBoardId = currentPost[0].id
        updatePostViewModel.updatePost(boardId: currentBoardId) { post, success in
            if success {
                DispatchQueue.main.async {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    let vc = UINavigationController(rootViewController: BoardsViewController())
                    windowScene.windows.first?.rootViewController = vc
                    windowScene.windows.first?.makeKeyAndVisible()
                }
            } else {
                self.view.makeToast("내용을 입력해주세요", duration: 2.0, position: .center, title: "게시글수정 실패", image: nil)
            }
        }
    }

}

extension InsertBoardViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        postTextViewdDidChange(textView)
        print("textViewDidChange: \(textView.text)")
    }
    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        didTabDone()
//    }
}
