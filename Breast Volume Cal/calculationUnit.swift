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
        return scale(input: square.squareRoot());
    }
    
    func convertToCM(input: Double)->Double{
        return input * scaler;
    }
    
    func midPoint(start : CGPoint , end:CGPoint)->(CGPoint){
        let addX = (end.x - start.x)/2;
        let addY = (end.y - start.y)/2;
        var midPoint = start;
        midPoint.x = midPoint.x + addX;
        midPoint.y = midPoint.y + addY;
        return midPoint;
    }
    
    func scale(input: Double)->Double{
        return input*scaler
    }
    
    func calculateConeHeight(topSide: CGPoint, startCurve: CGPoint){
        coneHeight = dis(a:topSide,b:startCurve);
    }
    
    func calculateEclipseA(startCurve: CGPoint, endCurve: CGPoint){
        eclipseA = dis(a: startCurve, b: endCurve);
    }
    
    func calculateEclipseB(left: CGPoint, right: CGPoint){
        eclipseB = dis(a: left, b: right);
    }
    
    func calculateEclipseC(midCurve: CGPoint, startCurve: CGPoint, endCurve: CGPoint){
        eclipseC = dis(a: midCurve, b: midPoint(start: startCurve, end: endCurve));
    }
    
    func geometricCalculation()->(Double){
        let eclipse = 4/6 * Double.pi * eclipseA * eclipseB * eclipseC;
        let cone = 1/6 * Double.pi * eclipseA * eclipseB * coneHeight;
        let result = eclipse + cone;
        return result;
    }

    
    //Calculate arc distant from fold to nipple
    func calculateFN(startCurve : CGPoint, curveLeft : CGPoint, midCurve : CGPoint, curveRight : CGPoint, nipple :CGPoint){
        fn = 0.0
        fn += dis(a : startCurve,b : curveLeft)
        fn += dis(a : curveLeft,b : midCurve)
        fn += dis(a : midCurve,b : curveRight)
        fn += dis(a : curveRight,b : nipple)
    }
    
    //Calculate arc distant from fold to fold
    func calculateFF(startCurve : CGPoint, curveLeft : CGPoint, midCurve : CGPoint, curveRight : CGPoint, endCurve :CGPoint){
        ff = 0.0
        ff += dis(a : startCurve,b : curveLeft)
        ff += dis(a : curveLeft,b : midCurve)
        ff += dis(a : midCurve,b : curveRight)
        ff += dis(a : curveRight,b : endCurve)
    }
    
    func calculateSN(sternalNotch :CGPoint, nippleFront :CGPoint){
        sn = dis(a : sternalNotch, b : nippleFront)
    }
    
    //Calculate breast volume according to breastV method
    func calBreastV(){
        breastV =  -231.66 + 0.5747*sn*sn + 18.5478*ff + 14.5087*fn
    }
}
