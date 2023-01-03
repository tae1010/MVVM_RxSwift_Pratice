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
    
    @IBOutlet weak var fixButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    var testTitle: String? = ""
    var testContent: String? = ""
    var index: Int = 0
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let title = self.testTitle {
            titleTextField.text = title
        }
        
        if let content  = self.testContent {
            contentTextView.text = content
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
    
    
    
    @IBAction func tabFixButton(_ sender: UIButton) {
        
        
    }
    
    @IBAction func tabCreateButton(_ sender: UIButton) {
        bind()
        
    }
    
    func bind() {
        self.dismiss(animated: true)
    }
    
    
}