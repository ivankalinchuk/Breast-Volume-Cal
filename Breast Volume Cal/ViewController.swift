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
var breastV = 0;
var sn = 0.0;
var ff = 0.0;
var fn = 0.0;

    //for geometric method
var geometric = 0;
var coneHeight = 0.0;
var eclipseA = 0.0;
var eclipseB = 0.0;
var eclipseC = 0.0;
var scaler = -1.0;

//image singleton
/*
let startButton = UIImage(named: "button_get-start.png");
let nextButton = UIImage(named: "button_next.png");
let calculateButton = UIImage(named: "button_calculate.png");
let restartButton = UIImage(named: "button_restart.png");
let calibrateButton = UIImage(named: "button_calibrate.png");
let finishButton = UIImage(named: "button_finish.png");
*/

class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    //From Internet
    @IBOutlet weak var header: UILabel!
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil);
    
    @IBAction func start(_ sender: UIButton) {
        //var nextViewController = UIViewController();
        if(scaler <= 0){
            self.present(storyBoard.instantiateViewController(withIdentifier: "CalibrateController") as! CalibrateController, animated:true, completion:nil);
        }
            
        else{
            let alert = UIAlertController(title: "Do you want to calibrates again?", message: "You can calibrate your camera again.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Calibrate", style: .default, handler: {action in
                self.present(self.storyBoard.instantiateViewController(withIdentifier: "CalibrateController") as! CalibrateController, animated:true, completion:nil);
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {
                action in
                self.present(self.storyBoard.instantiateViewController(withIdentifier: "SideViewController") as! SideViewController, animated:true, completion:nil);
            }))
            
            self.present(alert, animated: true)
        }
        //self.present(nextViewController, animated:true, completion:nil);
    }
    
    @IBOutlet weak var image: UIImageView!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
    }
    
    
}

