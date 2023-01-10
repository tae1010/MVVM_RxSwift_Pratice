//
//  MainViewModel.swift
//  MVVM_RxSwift_Pratice
//
//  Created by 김정태 on 2023/01/10.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    
    lazy var memoList = BehaviorSubject<[Memo]>(value: []) // 빈 배열을 갖고 잇는 observable 생성
    
    init() {
        
        var menuItem = [
            Memo(title: "가", content: "내용1"),
            Memo(title: "나", content: "내용2"),
            Memo(title: "다", content: "내용3"),
            Memo(title: "라", content: "내용4")
        ]
        memoList.onNext(menuItem)
        print(memoList, "이건?")
    }

}
