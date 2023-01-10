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

class MainViewController: UIViewController {
    
    @IBOutlet weak var memoCollectionView: UICollectionView!
    
    var mainViewModel = MainViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateUI()
//        selectCell()
    }
    
//    @IBAction func tapNewMemoButton(_ sender: UIButton) {
//        selectCell()
//    }
    
    func updateUI() {
        
        let nibName = UINib(nibName: "MemoCell", bundle: nil)
        memoCollectionView.register(nibName, forCellWithReuseIdentifier: "MemoCell")
        
        // 컬렉션뷰에 memoList를 바인딩
        mainViewModel.memoList
            .bind(to: memoCollectionView.rx
                .items(cellIdentifier: "MemoCell", cellType: MemoCollectionViewCell.self)) { index, memo, cell in
                    
                    cell.backgroundColor = RandomColor().randomColor()
                    cell.titleLabel?.text = memo.title
                    
                }
                .disposed(by: disposeBag)
    }
    
    func selectCell() {
        
        // zip으로 두가지(modelselected, itemSelected)를 같이 observable로 보낼 수 있음
        Observable.zip(memoCollectionView.rx.modelSelected(Memo.self),
                       memoCollectionView.rx.itemSelected)
        .bind { (memo, indexPath) in
            
//            self?.moveView(model: memo)
            print(memo.content, memo.title, indexPath.row)
            
        }
        .disposed(by: disposeBag)
    }
    
    
    func moveView(model: Memo) {
        // 이동할 다음 창을 생성하고 model을 전달
        let memoDetailVC = MemoDetailViewController(model: model)
        memoDetailVC.model = model
        present(memoDetailVC, animated: true, completion: nil)
    }

}
