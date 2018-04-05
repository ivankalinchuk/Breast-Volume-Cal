//
//  sideViewController.swift
//  Breast Volume Cal
//
//  Created by LotteryKitchen on 15/2/2561 BE.
//  Copyright © 2561 LotteryKitchen. All rights reserved.
//

import UIKit

class SideViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.pan(_:)))
        setTimer()
        setPoint()
        setLabel()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var imageView: UIImageView!
    
   
    var lastPoint = CGPoint.zero
    var swiped = false
    var numberOfPoint = 7
    var lineWidth = 5
    var dotWidth = 10
    var touchedIndex = 0
    var points = [UIImageView]()
    var lineColor = UIColor.black
    let initialRect = CGRect(x: 0, y: 0, width: 20, height: 20)
    var panGestureRecognizer = UIPanGestureRecognizer()
    var timer = 0
    var startCurve = CGPoint()
    var endCurve = CGPoint()
    var curveRight = CGPoint()
    var curveLeft = CGPoint()
    var midCurve = CGPoint()
    var labels = [UILabel]()
    
    @IBAction func camera(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.camera
        image.allowsEditing = false
        self.present(image , animated: true)
    }
    
    @IBAction func library(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image , animated: true)
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
            labels.append(label)
            self.view.addSubview(label)
        }
        labels[0].text = "TopSide"
        labels[1].text = "StartCurve"
        labels[2].text = "CurveLeft"
        labels[3].text = "MidCurve"
        labels[4].text = "CurveRight"
        labels[5].text = "EndCurve"
        labels[6].text = "Nipple"
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
        /*points[0].center = CGPoint(x:(3/8)*imageView.frame.maxX, y:(1/4)*imageView.frame.maxY)
        points[1].center = CGPoint(x:(1/4)*imageView.frame.maxX, y:(7/16)*imageView.frame.maxY)
        points[2].center = CGPoint(x:(1/4)*imageView.frame.maxX, y:(9/16)*imageView.frame.maxY)
        points[3].center = CGPoint(x:(3/8)*imageView.frame.maxX, y:(3/4)*imageView.frame.maxY)
        points[4].center = CGPoint(x:(5/8)*imageView.frame.maxX, y:(3/4)*imageView.frame.maxY)
        points[5].center = CGPoint(x:(3/4)*imageView.frame.maxX, y:(9/16)*imageView.frame.maxY)
        points[6].center = CGPoint(x:(3/4)*imageView.frame.maxX, y:(7/16)*imageView.frame.maxY)*/
        points[0].center = CGPoint(x:195.5, y:241.5)
        points[1].center = CGPoint(x:194.0, y:514.0)
        points[2].center = CGPoint(x:233.0, y:596.5)
        points[3].center = CGPoint(x:323.5, y:638.5)
        points[4].center = CGPoint(x:435.0, y:595.0)
        points[5].center = CGPoint(x:452.0, y:515.0)
        points[6].center = CGPoint(x:454.0, y:451.5)
    }
    
    @objc func update(){
        self.imageView.image = nil
        for index in 0..<numberOfPoint-2{
            drawLines(fromPoint: points[index].center, toPoint: points[index+1].center)
        }
        for index in 0..<numberOfPoint{
            labels[index].center.x = points[index].center.x
            labels[index].center.y = points[index].center.y+20
            print(labels[index].text!,points[index].center.x,points[index].center.y,separator: "  ")
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
