//
//  NoteDetailViewModel.swift
//  MVVM_RxSwift_Pratice
//
//  Created by 김정태 on 2023/01/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MemoDetailViewModel {
    
//    private let fetchMemo: FetchMemo
//    
//    let disposeBag = DisposeBag()
//    let title = BehaviorRelay<String>(value: "")
//    let content = BehaviorRelay<String>(value: "")
//
//    init(fetchMemo: FetchMemo, note: Memo?) {
//        self.fetchMemo = fetchMemo
//        self.title.accept(note?.title)
//        self.content.accept(note?.content)
//    }
//    
////    func updateNote(title: String, content: String) {
////        fetchMemo.updateNote(note: note, title: title, content: content)
////            .subscribe(onNext: { [weak self] updatedNote in
////                self?.title.accept(updatedNote.title)
////                self?.content.accept(updatedNote.content)
////            })
////            .disposed(by: disposeBag)
////    }
////
//    // 메모 수정
//    @discardableResult
//    func editMemo(title: String, content: String) -> Observable<Memo> {
//        
//        let updateMemo = Memo(title: title, content: content)
//        
//        if let index = memoList.firstIndex(where: { $0 == updateMemo }) {
//            memoList.remove(at: index)
//            memoList.insert(updateMemo, at: index)
//        }
//        
//        notes.onNext(memoList)
//        
//        return Observable.just(updateMemo)
//    }
//    
//    // 메모 삭제
//    @discardableResult
//    func deleteMemo(title: String, content: String) -> Observable<[Memo]> {
//        let deleteMemo = Memo(title: title, content: content)
//
//        if let index = memoList.firstIndex(where: { $0 == deleteMemo }) {
//            print("삭제됐나?")
//            memoList.remove(at: index)
//        }
//
//        model.onNext(memoList)
//
//        return Observable.just(memoList)
//    }
    
}
