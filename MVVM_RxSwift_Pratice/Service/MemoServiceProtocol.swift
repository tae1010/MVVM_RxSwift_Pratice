//
//  MemoProtocol.swift
//  MVVM_RxSwift_Pratice
//
//  Created by 김정태 on 2023/01/20.
//

import Foundation
import RxSwift

// Memo에 관련된 service 함수
protocol MemoServiceProtocol {
    
    @discardableResult
    func createMemo(title: String, content: String) -> Observable<[Memo]>
    
    @discardableResult
    func editMemo(title: String, content: String) -> Observable<Memo>
    
    @discardableResult
    func showMemo() -> Observable<[Memo]>
    
    @discardableResult
    func deleteMemo(title: String, content: String) -> Observable<[Memo]>
}

