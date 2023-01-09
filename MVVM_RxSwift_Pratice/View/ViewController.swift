//
//  ViewController.swift
//  MVVM_RxSwift_Pratice
//
//  Created by 김정태 on 2022/12/29.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UIScrollViewDelegate {

    var disposeBag = DisposeBag()
    
    @IBOutlet weak var memoCollectionView: UICollectionView!
    
    var viewModel: MemoViewModel

    var memo = Observable.just([
        Memo(title: "가", content: "aaa"),
        Memo(title: "나", content: "bbb"),
        Memo(title: "다", content: "ccc"),
        Memo(title: "라", content: "ddd"),
    ])
    
    init(viewModel: MemoViewModel = MemoViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = MemoViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let nibName = UINib(nibName: "MemoCell", bundle: nil)
        memoCollectionView.register(nibName, forCellWithReuseIdentifier: "MemoCell")
        
        
        memoCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        memo
            .bind(to: memoCollectionView.rx
                .items(cellIdentifier: "MemoCell", cellType: MemoCollectionViewCell.self)) { index, memo, cell in
                    cell.titleLabel?.text = memo.title
                }
                .disposed(by: disposeBag)
        
        // zip으로 두가지(modelselected, itemSelected)를 같이 observable로 보낼 수 있음
        Observable.zip(memoCollectionView.rx.modelSelected(Memo.self),
                       memoCollectionView.rx.itemSelected)
        .bind { [weak self] (memo, indexPath) in
            
            // memo는 선택된 MemoModel, indexPath는 선택된 cell index
            let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            // 뷰 객체 얻어오기 (storyboard ID로 ViewController구분)
            guard let uvc = storyboard?.instantiateViewController(identifier: "MemoDetailViewController") as? MemoDetailViewController else {
                return
            }
            
            // 화면 전환 애니메이션 설정
            uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            uvc.testTitle = memo.title
            uvc.testContent = memo.content
            
            self?.present(uvc, animated: true)
            
        }
        .disposed(by: disposeBag)
        
        let subject = PublishSubject<String>()
        
        subject.onNext("hello")
        
        let o1 = subject.subscribe{ print("?", $0) }
        o1.disposed(by: DisposeBag())
        
        subject.onNext("hi")
    }

}
