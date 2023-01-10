//
//  randomColor.swift
//  MVVM_RxSwift_Pratice
//
//  Created by 김정태 on 2023/01/10.
//

import Foundation
import UIKit

class RandomColor {
    
    func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}
