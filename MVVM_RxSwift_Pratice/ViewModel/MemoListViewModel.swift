//
//  NoteListViewModel.swift
//  MVVM_RxSwift_Pratice
//
//  Created by 김정태 on 2023/01/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MemoListViewModel {
    
    private let downloadRandomString: DownloadRandomString
    
    var memoList: [Memo] = [] // 메모를 저장할 객체
    
    var notes = BehaviorSubject<[Memo]>(value: []) // 메모의 상태를 알기위한 객체
    let disposeBag = DisposeBag()

    init(downloadRandomString: DownloadRandomString) {
        self.downloadRandomString = DownloadRandomString()
        
    }
    
    // 메모 생성
    @discardableResult
    func createMemo(title: String, content: String) -> Observable<[Memo]> {
        
        let memo = Memo(title: title, content: content)
        memoList.insert(memo, at: 0)
        
        notes.onNext(memoList)
        return Observable.just(memoList)
    }
    

    // 메모 보여주기
    func showMemo() {
        print(#fileID, #function, #line, "showMemo 실행")
        downloadRandomString.fetchRandomString().subscribe(onNext: { [weak self] memos in
            self?.notes.onNext(memos)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            
        }).disposed(by: disposeBag)
    }
}

