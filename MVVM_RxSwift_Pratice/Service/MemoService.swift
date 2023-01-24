//
//  MainViewModel.swift
//  MVVM_RxSwift_Pratice
//
//  Created by 김정태 on 2023/01/10.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

/*
    여기는 api나 db에서 메모를 관리하는 class
 */

class MemoService: MemoServiceProtocol {

    private var memoList = [
        Memo(title: "제목1", content: "내용1"),
        Memo(title: "제목2", content: "내용2"),
        Memo(title: "제목3", content: "내용3"),
    ]
    
    // 초기값 memoList를 갖고 있는 subject인 behaviorSubject 생성
    lazy var model = BehaviorSubject<[Memo]>(value: memoList)
    
    var disposeBag: DisposeBag = DisposeBag()
    
    // 메모 생성
    @discardableResult
    func createMemo(title: String, content: String) -> Observable<[Memo]> {
        
        let memo = Memo(title: title, content: content)
        memoList.insert(memo, at: 0)
        
        model.onNext(memoList)
        return Observable.just(memoList)
    }
    
    // 메모 수정
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
    
    // 메모 삭제
    @discardableResult
    func deleteMemo(title: String, content: String) -> Observable<[Memo]> {
        let deleteMemo = Memo(title: title, content: content)
        
        if let index = memoList.firstIndex(where: { $0 == deleteMemo }) {
            print("삭제됐나?")
            memoList.remove(at: index)
        }
        
        model.onNext(memoList)
        
        return Observable.just(memoList)
    }

}