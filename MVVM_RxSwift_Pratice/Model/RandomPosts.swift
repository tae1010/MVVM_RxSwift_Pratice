//
//  RadomPosts.swift
//  MVVM_RxSwift_Pratice
//
//  Created by 김정태 on 2023/01/24.
//

import Foundation

struct RandomPosts: Codable {
    
    var userd: Int
    var id: Int
    var title: String
    var content: String

    enum CodingKeys: String,CodingKey {
        case userd
        case id
        case title
        case content = "body"
    }
}
