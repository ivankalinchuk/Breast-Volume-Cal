//
//  ViewController.swift
//  BVC
//
//  Created by LotteryKitchen on 9/2/2561 BE.
//  Copyright © 2561 LotteryKitchen. All rights reserved.
//

import UIKit
import AVFoundation

// Global Variable Declaration
    //for breast V method
var breastV = 0.0;
var sn = 0.0;
var ff = 0.0;
var fn = 0.0;

    //for geometric method
var geometric = 0.0;
var coneHeight = 0.0;
var eclipseA = 0.0;
var eclipseB = 0.0;
var eclipseC = 0.0;
var scaler = -1.0;


class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    //From Internet
    @IBOutlet weak var header: UILabel!
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil);
    
    @IBAction func start(_ sender: UIButton) {
        var nextViewController = UIViewController();
        if(scaler <= 0){
            nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextView") as! CalibrateController;
        }
            
        else{
            let alert = UIAlertController(title: "Do you want to calibrates again?", message: "You can calibrate your camera again.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Calibrate", style: .default, handler: {action in
                nextViewController = self.storyBoard.instantiateViewController(withIdentifier: "nextView") as! CalibrateController;
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {
                action in
                nextViewController = self.storyBoard.instantiateViewController(withIdentifier: "nextView") as! SideViewController;
            }))
            
            self.present(alert, animated: true)
        }
        self.present(nextViewController, animated:true, completion:nil);
    }
    @IBOutlet weak var image: UIImageView!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

