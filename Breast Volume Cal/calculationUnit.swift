//
//  calculationUnit.swift
//  Breast Volume Cal
//
//  Created by LotteryKitchen on 16/3/2561 BE.
//  Copyright © 2561 LotteryKitchen. All rights reserved.
//

import Foundation
import UIKit

class CalculationUnit{
    func dis(a : CGPoint , b :CGPoint)->(Double){
        let x0 = Double(a.x);
        let y0 = Double(a.y);
        let x1 = Double(b.x);
        let y1 = Double(b.y);
        let square = pow(x0-x1,2) + pow(y0-y1,2);
        return square.squareRoot();
    }
    
    func midPoint(start : CGPoint , end:CGPoint)->(CGPoint){
        let addX = (end.x - start.x)/2;
        let addY = (end.y - start.y)/2;
        var midPoint = start;
        midPoint.x = midPoint.x + addX;
        midPoint.y = midPoint.y + addY;
        return midPoint;
    }
    /*
    func projection(a:CGPoint , b:CGPoint)->(CGPoint){
        var proj = a;
        proj.y = b.y;
        return proj;
    }
    */
    func measurement(topSide :CGPoint , startCurve:CGPoint , endCurve:CGPoint , midCurve:CGPoint,topFront:CGPoint,bottomFront:CGPoint,left:CGPoint,right:CGPoint){
        coneHeight = dis(a:topSide,b:startCurve);
        eclipseA = dis(a: startCurve, b: endCurve);
        eclipseB = dis(a: left, b: right);
        eclipseC = dis(a: midCurve, b: midPoint(start: startCurve, end: endCurve));
    }
}
