//
//  CalibrateController.swift
//  Breast Volume Cal
//
//  Created by LotteryKitchen on 6/4/2561 BE.
//  Copyright © 2561 LotteryKitchen. All rights reserved.
//

import Foundation
import UIKit
class CalibrateController: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let calculator = CalculationUnit();
    var readyToCalibrate = false;
    @IBAction func camera(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.camera
        image.allowsEditing = false
        self.present(image , animated: true)
        
        readyToCalibrate = true;
    }
    
    @IBAction func calibrating(_ sender: UIButton) {
        if(readyToCalibrate){
            // create alert
            let alert = UIAlertController(title: "Calibrating Success", message: "Press 'Next' to go to next steps.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           
            //let calibratingLength = calculator.dis(a: <#T##CGPoint#>, b: <#T##CGPoint#>)
            //scaler = 1/calibratingLength
            
            // alert show
            self.present(alert, animated: true)
        
        }
        
        else{
            let alert = UIAlertController(title: "Cannot Calibrate!", message: "Please take a photo and try again.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
}

