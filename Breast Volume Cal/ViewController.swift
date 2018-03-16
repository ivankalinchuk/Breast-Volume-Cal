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
var sn = 0;
var ff = 0;
var fn = 0;

    //for geometric method
var geometric = 0.0;
var coneHeight = 0.0;
var eclipseA = 0.0;
var eclipseB = 0.0;
var eclipseC = 0.0;



class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    //From Internet
    @IBOutlet weak var header: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var getStart: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

