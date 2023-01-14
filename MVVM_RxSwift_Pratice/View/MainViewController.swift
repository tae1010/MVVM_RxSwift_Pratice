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
        
        let nibName = UINib(nibName: "MemoCell", bundle: nil)
        memoCollectionView.register(nibName, forCellWithReuseIdentifier: "MemoCell")
            
        
        // collectionview delegate 등록
        memoCollectionView.rx.setDelegate(self)
                    .disposed(by: disposeBag)
        
        
        // collectionView inset
        memoCollectionView.rx.contentInset.onNext(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            
        
        // 컬렉션뷰에 memoList를 바인딩
        mainViewModel.model
            .bind(to: memoCollectionView.rx
                .items(cellIdentifier: "MemoCell", cellType: MemoCollectionViewCell.self)) { index, memo, cell in
                    
                    cell.backgroundColor = RandomColor().randomColor()
                    cell.titleLabel?.text = memo.title
                    cell.layer.cornerRadius = 10
                }
                .disposed(by: disposeBag)
        
        
        // cell 클릭
        // zip으로 두가지(modelselected, itemSelected)를 같이 observable로 보낼 수 있음
        Observable.zip(memoCollectionView.rx.modelSelected(Memo.self),
                       memoCollectionView.rx.itemSelected)
        .bind { (memo, indexPath) in
            self.moveView(model: memo)
        }
        .disposed(by: disposeBag)
        
    }
    
    @IBAction func tapNewMemoButton(_ sender: UIButton) {
        self.moveView(model: Memo())
    }

    
    // 뷰 이동(Memo 구조체를 보냄)
    func moveView(model: Memo) {

        guard let memoDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MemoDetailViewController") as? MemoDetailViewController else { return }
        memoDetailVC.model = model
        present(memoDetailVC, animated: true, completion: nil)
    }

}


extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.memoCollectionView.frame.width / 2 - 20
        let height = width / 2 - 20
        print(width, height)
        
        return CGSize(width: width, height: height)
    }
}
