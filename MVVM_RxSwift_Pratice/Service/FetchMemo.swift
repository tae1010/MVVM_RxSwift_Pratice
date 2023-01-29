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

class FetchMemo {
    
    private let downloadRandomString: RandomStringProtocol
    
//    private var memoList = [
//        Memo(title: "제목1", content: "내용1"),
//        Memo(title: "제목2", content: "내용2"),
//        Memo(title: "제목3", content: "내용3"),
//    ]
//   
//    // 초기값 memoList를 갖고 있는 subject인 behaviorSubject 생성
//    lazy var model = BehaviorSubject<[Memo]>(value: memoList)
    
    var disposeBag: DisposeBag = DisposeBag()
    
    init(downloadRandomString: RandomStringProtocol) {
        self.downloadRandomString = downloadRandomString
    }

    // 메모(랜덤 string)를 다운받는 메서드
    func fetchMemo() -> Observable<[Memo]> {
        print("fetchMemo가 실행됨?")
        return downloadRandomString.fetchRandomString()
    }
}
