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
        setPoint()
        drawFrame()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var imageView: UIImageView!
    
   
    var lastPoint = CGPoint.zero
    var swiped = false
    var numberOfPoint = 8
    var lineWidth = 5
    var dotWidth = 10
    var points = [Point]()
    var touchedIndex = 0
    let recognizer = UITapGestureRecognizer()
    
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
    
    func setPoint(){
    for _ in 0..<numberOfPoint{
    points.append(Point())
    
    }
    points[0].location = CGPoint(x:(3/8)*imageView.frame.maxX, y:(1/4)*imageView.frame.maxY)
    points[1].location = CGPoint(x:(1/4)*imageView.frame.maxX, y:(7/16)*imageView.frame.maxY)
    points[2].location = CGPoint(x:(1/4)*imageView.frame.maxX, y:(9/16)*imageView.frame.maxY)
    points[3].location = CGPoint(x:(3/8)*imageView.frame.maxX, y:(3/4)*imageView.frame.maxY)
    points[4].location = CGPoint(x:(5/8)*imageView.frame.maxX, y:(3/4)*imageView.frame.maxY)
    points[5].location = CGPoint(x:(3/4)*imageView.frame.maxX, y:(9/16)*imageView.frame.maxY)
    points[6].location = CGPoint(x:(3/4)*imageView.frame.maxX, y:(7/16)*imageView.frame.maxY)
    points[7].location = CGPoint(x:(5/8)*imageView.frame.maxX, y:(1/4)*imageView.frame.maxY)
    
    for index in 0..<numberOfPoint{
    print("\(index) x: \(points[index].location.x)")
    print("\(index) y: \(points[index].location.y)")
    }
    }
    
    func drawFrame(){
        self.imageView.image = nil
        drawPointsAndLine(fromPoint:points[0].location, toPoint:points[1].location )
        drawPointsAndLine(fromPoint:points[1].location, toPoint:points[2].location )
        drawPointsAndLine(fromPoint:points[2].location, toPoint:points[3].location )
        drawPointsAndLine(fromPoint:points[3].location, toPoint:points[4].location )
        drawPointsAndLine(fromPoint:points[4].location, toPoint:points[5].location )
        drawPointsAndLine(fromPoint:points[5].location, toPoint:points[6].location )
        drawPointsAndLine(fromPoint:points[6].location, toPoint:points[7].location )
        drawLines(fromPoint: points[7].location, toPoint: points[7].location, width: dotWidth )
        
    }
    
    func drawPointsAndLine(fromPoint:CGPoint, toPoint:CGPoint){
        drawLines(fromPoint: fromPoint, toPoint: fromPoint, width: dotWidth )
        drawLines(fromPoint: fromPoint, toPoint: toPoint, width: lineWidth )
    }
    
    
    func drawLines(fromPoint:CGPoint, toPoint:CGPoint, width: Int){
        UIGraphicsBeginImageContext(self.view.frame.size)
        imageView.image?.draw(in: CGRect(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.size.width, height: self.view.frame.size.height))
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: fromPoint)
        context?.addLine(to: toPoint)
        
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(CGFloat(width))
        //context?.setStrokeColor(UIColor(Red:0, green:0, blue:0, alpha: 1).cgColor)
        
        context?.strokePath()
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch began")
        swiped = false
        if let touch = touches.first{
            lastPoint = touch.location(in: imageView)
            print("last point x: \(lastPoint.x)")
            print("last point y: \(lastPoint.y)")
            lastPoint.x += 71
            lastPoint.y += 130
        }
        
        var leastDifference:CGFloat = 999999.99
        for index in 0..<numberOfPoint{
            let difference = points[index].checkTouch(position: lastPoint)
            if difference < leastDifference{
                touchedIndex = index
                leastDifference = difference
            }
        }
        if leastDifference < 10000 {
            points[touchedIndex].isTouched = true
            print("touched index = \(touchedIndex)")
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        
        if let touch = touches.first{
            let currentPoint = touch.location(in: imageView)
            lastPoint = currentPoint
            lastPoint.x += 71
            lastPoint.y += 130
        }
        
            if points[touchedIndex].isTouched{
                points[touchedIndex].location = lastPoint
        }
        
        
        drawFrame()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch end")
        if let touch = touches.first{
            let currentPoint = touch.location(in: imageView)
            lastPoint = currentPoint
            lastPoint.x += 71
            lastPoint.y += 130
        }
        for index in 0..<numberOfPoint{
            points[index].isTouched = false
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
