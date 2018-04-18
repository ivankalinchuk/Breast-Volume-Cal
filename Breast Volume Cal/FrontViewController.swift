//
//  FrontViewController.swift
//  Breast Volume Cal
//
//  Created by LotteryKitchen on 16/2/2561 BE.
//  Copyright © 2561 LotteryKitchen. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var calculateButton: UIButton!
    var lastPoint = CGPoint.zero
    var swiped = false
    var numberOfPoint = 10
    var lineWidth = 5
    var dotWidth = 10
    var touchedIndex = 0
    var points = [UIImageView]()
    var labels = [UILabel]()
    var lineColor = UIColor.white
    let initialRect = CGRect(x: 0, y: 0, width: 20, height: 20)
    var panGestureRecognizer = UIPanGestureRecognizer()
    var timer = 0
    var sternalNotch = CGPoint()
    var nippleFront = CGPoint()
    var photoReady = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.pan(_:)))
        calculateButton.isEnabled = false
        setTimer()
        setLabel()
        self.view.bringSubview(toFront: imageView)
        // Do any additional setup after loading the view.
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
    }
    
    @IBAction func Calculate(_ sender: UIButton) {
        let calculator = CalculationUnit();
        
        
        //Geometric Method Calaulation
        geometric = calculator.geometricCalculation();
        
        
        //Breast-V Method Calculation
        sternalNotch = points[8].center
        nippleFront = points[9].center
        calculator.calculateSN(sternalNotch: sternalNotch, nippleFront: nippleFront)
        calculator.calBreastV()
        
        calculator.calculateEclipseB(left: points[1].center, right: points[5].center)
    }
    
    @IBAction func camera(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.camera
        image.allowsEditing = false
        self.present(image , animated: true)
        if(!photoReady){
            setPoint()
        }
        photoReady = true
        calculateButton.isEnabled = true
    }
    
    @IBAction func library(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image , animated: true)
        if(!photoReady){
            setPoint()
        }
        photoReady = true
        calculateButton.isEnabled = true
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTimer(){
        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
        displayLink.preferredFramesPerSecond = 30
    }
    
    func setLabel(){
        for _ in 0..<numberOfPoint{
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
            label.center = CGPoint(x: 0, y:0)
            label.textAlignment = NSTextAlignment.center
            label.text = ""
            label.textColor = lineColor
            labels.append(label)
            self.view.addSubview(label)
        }
        labels[1].text = "Left"
        labels[5].text = "Right"
        labels[8].text = "Sternal Notch"
        labels[9].text = "Nipple"
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
        points[0].center = CGPoint(x: 232.0, y: 432.5)
        points[1].center = CGPoint(x: 220.0, y:505.0)
        points[2].center = CGPoint(x: 241.0, y: 541.5)
        points[3].center = CGPoint(x: 291.0, y: 585.0)
        points[4].center = CGPoint(x: 354.0, y: 562.0)
        points[5].center = CGPoint(x: 394.5, y: 498.5)
        points[6].center = CGPoint(x:399.0, y: 445.5)
        points[7].center = CGPoint(x: 392.0, y: 383.5)
        points[8].center = CGPoint(x: 393.5, y: 298.5)
        points[9].center = CGPoint(x: 266.0, y: 490.5)
        
    }
    
    @objc func update(){
        if (!photoReady){
            return
        }
        self.imageView.image = nil
        for index in 0..<numberOfPoint-2{
            //drawLines(fromPoint: points[index].center, toPoint: points[index+1].center)
        }
        for index in 0..<numberOfPoint{
            labels[index].center.x = points[index].center.x
            labels[index].center.y = points[index].center.y+20
        //print(labels[index].text!,points[index].center.x,points[index].center.y,separator: "  ")
        }
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
            view.center = CGPoint(x:view.center.x + translation.x, y: view.center.y + translation.y)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
            update()
        case.ended: break
        default: break
        }
    }

}
