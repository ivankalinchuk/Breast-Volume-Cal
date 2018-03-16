//
//  ViewController.swift
//  BVC
//
//  Created by LotteryKitchen on 9/2/2561 BE.
//  Copyright © 2561 LotteryKitchen. All rights reserved.
//

import UIKit
import AVFoundation




class ResultController: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    //From Internet
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func breastVCalulation(sn : Double,ff : Double ,fn : Double )->(Double){
        let result = -231.66 + 0.5747*sn*sn + 18.5478 * ff + 14.5087 * fn;
        return result;
    }
    /*
    func geometricCalculation(eclipseA : Double , eclipseB : Double ,eclipseC : Double, triangleHeight : Double , triangleBase : Double )->(Double){
        let eclipse = 4/6 * Double.pi * eclipseA * eclipseB * eclipseC;
        let cone = 1/6 * Double.pi * eclipseA * eclipseB * coneHeight;
        let result = eclipse + cone;
        return result;
    }
    */
}


