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
    
    
/*
    let calculator = CalculationUnit();
<<<<<<< HEAD
    var readyToCalibrate = false;
    var numberOfPoint = 2;
    var points = [UIImageView]()
    var lineColor = UIColor.black
    let initialRect = CGRect(x: 0, y: 0, width: 20, height: 20)
    var panGestureRecognizer = UIPanGestureRecognizer()
    var timer = 0
    var lineWidth = 5
    var dotWidth = 10
    var photoReady = false
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func camera(_ sender: Any) {
        if(!photoReady){
            setPoint()
        }
        photoReady = true
=======
    var isReady = false;
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBAction func cameraRoll(_ sender: Any) {
>>>>>>> 2eec204dde6d8871b380065bc95458ddcd29ddf5
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
    
<<<<<<< HEAD
    override func viewDidLoad() {
        super.viewDidLoad()
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.pan(_:)))
        setTimer()
        // Do any additional setup after loading the view.
    }
    
    func setTimer(){
        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
        displayLink.preferredFramesPerSecond = 30
    }
    
    func setPoint(){
        for _ in 0..<numberOfPoint{
            let dotView = UIImageView(frame: initialRect)
            var panGestureRecognizer = UIPanGestureRecognizer()
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.pan(_:)))
            dotView.backgroundColor  = lineColor
            dotView.layer.cornerRadius = 10
            dotView.clipsToBounds = true
            dotView.addGestureRecognizer(panGestureRecognizer)
            dotView.isUserInteractionEnabled = true
            self.view.addSubview(dotView)
            points.append(dotView)
        }
        points[0].center = CGPoint(x:200, y:200)
        points[1].center = CGPoint(x:200, y:400)
    }
    
    @objc func update(){
        if (!photoReady){
            return
        }
        self.imageView.image = nil
        drawLines(fromPoint: points[0].center, toPoint: points[1].center)
    }
    
    
    func drawLines(fromPoint:CGPoint, toPoint:CGPoint){
        UIGraphicsBeginImageContext(self.view.frame.size)
        imageView.image?.draw(in: self.view.frame)
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: fromPoint)
        context?.addLine(to: toPoint)
        
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(CGFloat(lineWidth))
        context?.setStrokeColor(lineColor.cgColor)
        
        context?.strokePath()
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @objc func pan(_ recognizer: UIPanGestureRecognizer){
        guard let view = recognizer.view else { return }
        switch recognizer.state {
        case .began: fallthrough
        case .changed:
            let translation = recognizer.translation(in: self.view)
            view.center = CGPoint(x:view.center.x, y: view.center.y + translation.y)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
            update()
        case.ended: break
        default: break
        }
    }
    
    @IBAction func calibrating(_ sender: UIButton) {
        if(readyToCalibrate){
=======
    
    @IBAction func calibrate(_ sender: Any) {
        if(isReady){
>>>>>>> 2eec204dde6d8871b380065bc95458ddcd29ddf5
            // create alert
            let alert = UIAlertController(title: "Calibrating Success", message: "Press 'Next' to go to next steps.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
<<<<<<< HEAD
            //calibrating
            let calibratingLength = calculator.dis(a: points[0].center, b: points[1].center)
            scaler = 1/calibratingLength
=======
            
            
>>>>>>> 2eec204dde6d8871b380065bc95458ddcd29ddf5
            
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
*/
}
