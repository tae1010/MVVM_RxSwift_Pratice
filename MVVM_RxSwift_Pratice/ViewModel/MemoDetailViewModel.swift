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
    
    private let memoService: MemoService
    
    let title = BehaviorRelay<String>(value: "")
    let content = BehaviorRelay<String>(value: "")

    init(memoService: MemoService, note: Memo) {
        self.memoService = memoService
        self.title.accept(note.title)
        self.content.accept(note.content)
    }
    
    func updateNote(title: String, content: String) {
        memoService .updateNote(note: note, title: title, content: content)
            .subscribe(onNext: { [weak self] updatedNote in
                self?.title.accept(updatedNote.title)
                self?.content.accept(updatedNote.content)
            })
            .disposed(by: disposeBag)
    }
    
}
