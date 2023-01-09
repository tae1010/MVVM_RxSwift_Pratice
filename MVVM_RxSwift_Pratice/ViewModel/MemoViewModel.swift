//
//  MemoViewModel.swift
//  MVVM_RxSwift_Pratice
//
//  Created by 김정태 on 2022/12/30.
//

import Foundation
import RxSwift


protocol MemoViewModelProtocol {
    @discardableResult
    func createMemo(title: String, content: String) -> Observable<[Memo]>
    
    @discardableResult
    func editMemo(title: String, content: String) -> Observable<Memo>
    
    @discardableResult
    func showMemo() -> Observable<[Memo]>
    
    @discardableResult
    func deleteMemo(title: String, content: String) -> Observable<[Memo]>
}

class MemoViewModel: MemoViewModelProtocol {
    
    private var memoList = [
        Memo(title: "제목1", content: "내용1"),
        Memo(title: "제목2", content: "내용2")
    ]
    
    // 초기값 memoList를 갖고 있는 subject인 behaviorSubject 생성
    private lazy var model = BehaviorSubject<[Memo]>(value: memoList)
    
    var disposeBag: DisposeBag = DisposeBag()
    
    
    func createMemo(title: String, content: String) -> Observable<[Memo]> {
        
        let memo = Memo(title: title, content: content)
        memoList.insert(memo, at: 0)
        
        model.onNext(memoList)
        return Observable.just(memoList)
    }
    
    @discardableResult
    func editMemo(title: String, content: String) -> Observable<Memo> {
        
        let updateMemo = Memo(title: title, content: content)
        
        if let index = memoList.firstIndex(where: { $0 == updateMemo }) {
            memoList.remove(at: index)
            memoList.insert(updateMemo, at: index)
        }
        
        model.onNext(memoList)
        
        return Observable.just(updateMemo)
    }
    
    @discardableResult
    func showMemo() -> Observable<[Memo]> {
        return model
    }
    
    @discardableResult
    func deleteMemo(title: String, content: String) -> Observable<[Memo]> {
        let deleteMemo = Memo(title: title, content: content)
        
        if let index = memoList.firstIndex(where: { $0 == deleteMemo }) {
            memoList.remove(at: index)
        }
        
        model.onNext(memoList)
        
        return Observable.just(memoList)
    }
}
