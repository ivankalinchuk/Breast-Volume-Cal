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
    var numberOfPoint = 4
    var lineWidth = 5
    var dotWidth = 10
    var points = [UIImageView]()
    var labels = [UILabel]()
    var lineColor = UIColor.white
    var panGestureRecognizer = UIPanGestureRecognizer()
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
        calculator.calculateEclipseB(left: points[0].center, right: points[1].center)
        calculator.calculateSN(sternalNotch: points[2].center, nippleFront: points[3].center)
        calculator.calBreastV()
        //print("Breast width : " + String(calculator.dis(a: points[0].center, b: points[1].center)))
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
        labels[0].text = "Left"
        labels[1].text = "Right"
        labels[2].text = "Sternal Notch"
        labels[3].text = "Nipple"
    }
    
    func setPoint(){
        let initialRect = CGRect(x: 0, y: 0, width: 20, height: 20)
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
        points[0].center = CGPoint(x: 220.0, y: 505.0)
        points[1].center = CGPoint(x: 394.5, y: 498.5)
        points[2].center = CGPoint(x: 393.5, y: 298.5)
        points[3].center = CGPoint(x: 266.0, y: 490.5)
        
    }
    
    @objc func update(){
        if (!photoReady){
            return
        }
        self.imageView.image = nil
        drawLines()
        for index in 0..<numberOfPoint{
            labels[index].center.x = points[index].center.x
            labels[index].center.y = points[index].center.y+20
        //print(labels[index].text!,points[index].center.x,points[index].center.y,separator: "  ")
        }
    }
    
    
    func drawLines(){
        UIGraphicsBeginImageContext(imageView.frame.size)
        imageView.image?.draw(in: imageView.frame)
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: points[2].center)
        context?.addLine(to: points[3].center)

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
