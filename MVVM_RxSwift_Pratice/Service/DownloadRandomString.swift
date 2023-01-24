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
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
        .validate(statusCode: 200..<300)
        .responseJSON { (json) in
            //응답처리
            print(json)
        }
    }
    
}
