//
//  DownloadRadnomString.swift
//  MVVM_RxSwift_Pratice
//
//  Created by 김정태 on 2023/01/24.
//

import Foundation
import Alamofire
import RxSwift


class DownloadRandomString {
    
    let urlString = "https://jsonplaceholder.typicode.com/posts/1"
    
    func downloadPost(completion: @escaping((Error?, [RandomPosts]?) -> Void)) {
        
        // url을 URL을 이용해서 알맞게 변환 실패시 completion error함수 호출
        guard let url = URL(string: urlString) else { return completion(NSError(domain: "why", code: 404), nil) }
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil)
            .responseDecodable(of: [RandomPosts].self) { response in
            if let error = response.error {
                print(error)
                return completion(error, nil)
            }
            
            if let randomPosts = response.value {
                print("success \(randomPosts)")
                return completion(nil, randomPosts)
            }
  
        }
    }
    
    @discardableResult
    func fetchNews() -> Observable<[RandomPosts]> {
        return Observable.create { (observer) -> Disposable in
            
            self.downloadPost(completion: {(error, randomPosts) in
                
                if let error = error {
                    observer.onError(error)
                }
                
                if let randomPosts = randomPosts {
                    observer.onNext(randomPosts)
                }
                
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
}
