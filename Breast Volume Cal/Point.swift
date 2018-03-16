//
//  Point.swift
//  Drawing app
//
//  Created by Apple on 2/15/2561 BE.
//  Copyright © 2561 Wow. All rights reserved.
//

import Foundation
import UIKit

struct Point{
    var location = CGPoint(x:0, y:0)
    var isTouched = false
    
    func checkTouch(position:CGPoint) -> CGFloat{
        let equation = pow((position.x-location.x),2) + pow((position.y-location.y),2)
        return equation.squareRoot()
    }
}
