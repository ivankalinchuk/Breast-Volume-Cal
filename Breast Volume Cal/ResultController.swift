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
    @IBOutlet weak var geometricLabel: UILabel!
    @IBOutlet weak var breastvLabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let calculator = CalculationUnit()
        breastvLabel.text!.append(String(breastV))
        geometricLabel.text!.append(String(calculator.geometricCalculation()))
        // Do any additional setup after loading the view.
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
    }
    
}


