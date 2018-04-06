//
//  CalibrateController.swift
//  Breast Volume Cal
//
//  Created by LotteryKitchen on 6/4/2561 BE.
//  Copyright © 2561 LotteryKitchen. All rights reserved.
//

import Foundation
import UIKit
@objc class CalibrateController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    let calculator = CalculationUnit();
    var isReady = false;
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBAction func cameraRoll(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.camera
        image.allowsEditing = false
        self.present(image , animated: true)
        
        isReady = true;
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            pictureView.image = image
        }
        else
        {
            //error
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func calibrate(_ sender: Any) {
        if(isReady){
            // create alert
            let alert = UIAlertController(title: "Calibrating Success", message: "Press 'Next' to go to next steps.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            
            
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


