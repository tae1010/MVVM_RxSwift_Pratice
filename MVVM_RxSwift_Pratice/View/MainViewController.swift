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
    
    var memoListViewModel: MemoListViewModel
    var disposeBag = DisposeBag()
    
    
    init(memoListViewModel: MemoListViewModel) {
        self.memoListViewModel = memoListViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "MemoCell", bundle: nil)
        memoCollectionView.register(nibName, forCellWithReuseIdentifier: "MemoCell")
        
                        
//         collectionview delegate 등록
        memoCollectionView.rx.setDelegate(self)
                    .disposed(by: disposeBag)

        
        // collectionView inset
        memoCollectionView.rx.contentInset.onNext(UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5))
        
        
        
        // 컬렉션뷰에 memoList를 바인딩
        memoListViewModel.model
            .bind(to: memoCollectionView.rx
                .items(cellIdentifier: "MemoCell", cellType: MemoCollectionViewCell.self)) { index, memo, cell in
                    
                    cell.backgroundColor = RandomColor().randomColor()
                    cell.titleLabel?.text = memo.title
                    cell.layer.cornerRadius = 20
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
    
    override func viewWillAppear(_ animated: Bool) {
        print(memoListViewModel.model, "확인")
    }
    
    @IBAction func tapNewMemoButton(_ sender: UIButton) {
        self.moveView(model: Memo())
    }

    
    // 뷰 이동(Memo 구조체를 보냄)
    func moveView(model: Memo) {

        guard let memoDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MemoDetailViewController") as? MemoDetailViewController else { return }
        memoDetailVC.memos = model
        memoDetailVC.modalPresentationStyle = .fullScreen
        present(memoDetailVC, animated: true, completion: nil)
    }

}


extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellWidth = (self.memoCollectionView.frame.width / 2) - 50
        return CGSize(width: cellWidth, height: cellWidth / 2)
    }
}
