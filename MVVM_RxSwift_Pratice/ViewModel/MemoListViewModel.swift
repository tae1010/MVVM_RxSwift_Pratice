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
    
    private let memoService: MemoService
    let notes = BehaviorRelay<[Memo]>(value: [])
    let disposeBag = DisposeBag()

    init(memoService: MemoService) {
        self.memoService = memoService
    }

    func fetchNotes() {
        memoService.fetchNotes()
            .subscribe(onNext: { [weak self] notes in
                self?.notes.accept(notes)
            })
            .disposed(by: disposeBag)
    }

    
    func addNote(title: String, content: String) {
        memoService.addNote(title: title, content: content)
            .subscribe(onNext: { [weak self] newNote in
                var currentNotes = self?.notes.value ?? []
                currentNotes.append(newNote)
                self?.notes.accept(currentNotes)
            })
            .disposed(by: disposeBag)
    }

    func updateNote(memo: Memo, title: String, content: String) {
        memoService.updateNote(memo: memo, title: title, content: content)
            .subscribe(onNext: { [weak self] updatedNote in
                var currentNotes = self?.notes.value ?? []
                if let index = currentNotes.firstIndex(where: { $0.id == updatedNote.id }) {
                    currentNotes[index] = updatedNote
                    self?.notes.accept(currentNotes)
                }
            })
            .disposed(by: disposeBag)
    }

    func deleteNote(memo: Memo) {
        memoService.deleteNote(note: note)
            .subscribe(onNext: { [weak self] _ in
                var currentNotes = self?.notes.value ?? []
                if let index = currentNotes.firstIndex(where: { $0.id == note.id }) {
                    currentNotes.remove(at: index)
                    self?.notes.accept(currentNotes)
                }
            })
            .disposed(by: disposeBag)
    }
}

