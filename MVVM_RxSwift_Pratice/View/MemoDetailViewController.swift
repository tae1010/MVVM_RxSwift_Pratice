//
//  MemoDetailViewController.swift
//  MVVM_RxSwift_Pratice
//
//  Created by 김정태 on 2022/12/30.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MemoDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    var testTitle: String? = " "
    var testContent: String? = " "
    var index: Int = 0
    
    var memos: Memo = Memo()
    var memoDetailViewModel: MemoDetailViewModel
    var disposeBag = DisposeBag()
    
    init(memos: Memo, memoDetailViewModel: MemoDetailViewModel) {
        self.memoDetailViewModel = memoDetailViewModel
        self.memos = memos
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // textfield, textView 설정
    func configureView() {
        
        
        if let _ = self.testTitle {
            self.titleTextField.text = memos.title
            
        }
        
        if let _ = self.testContent {
            contentTextView.text = memos.content
        }
        
        let usernameValid = titleTextField.rx.text.orEmpty
            .map { $0.count > 0 }
            .debug()
            .share(replay: 1) // without this map would be executed once for each binding, rx is stateless by default

        let passwordValid = contentTextView.rx.text.orEmpty
            .map { $0.count > 0 }
            .debug()
            .share(replay: 1)

        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .debug()
            .share(replay: 1)
        
        everythingValid
            .bind(to: createButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        
    }
    
    
    
    @IBAction func tabDeleteButton(_ sender: UIButton) {
        
        let title = self.titleTextField.text ?? ""
        let content = self.contentTextView.text ?? ""

        memoDetailViewModel.deleteMemo(title: title, content: content).subscribe(onNext: { memos in
            print(memos,"?!?")
        }).disposed(by: disposeBag)
        
        self.dismiss(animated: true)
        
    }
    
    @IBAction func tabCreateButton(_ sender: UIButton) {
        bind()
    }
    
    func bind() {
        self.dismiss(animated: true)
    }
    
    
}
