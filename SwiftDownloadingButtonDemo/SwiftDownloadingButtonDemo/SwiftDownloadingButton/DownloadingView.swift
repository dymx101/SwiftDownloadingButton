//
//  DownloadingView.swift
//  SwiftDownloadingButtonDemo
//
//  Created by Dong, Yiming (Agoda) on 4/11/17.
//  Copyright © 2017 Dong, Yiming (Agoda). All rights reserved.
//

import UIKit

class DownloadingView: UIView {

    var color = UIColor.blue
    var emptyLineWidth: CGFloat = 0.5
    var progressLineWidth: CGFloat = 5
    var rectCornerRadius: CGFloat = 4
    var progress = 0.3
    
    let startAngle = CGFloat(M_PI_2 * 3)
    var endAngle: CGFloat {
        get {
            return startAngle + CGFloat(M_PI * 2 * progress)
        }
    }
    
    var middle: CGPoint {
        get {
            return CGPoint(x: frame.width * 0.5, y: frame.height * 0.5);
        }
    }
    
    var radius: CGFloat {
        get {
            return min(middle.x, middle.y) - 0.5
        }
    }
    
    var stopButtonWidth: CGFloat {
        get {
            return radius * 0.5
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        doInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doInit()
    }
    
    func doInit() {
        backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawStopRect()
        drawEmptyCircle()
        drawProgress()
    }
    
    // MARK: private methods
    
    fileprivate func drawStopRect() {
        
        let x = middle.x - stopButtonWidth / 2
        let y = middle.y - stopButtonWidth / 2
        
        let rect = CGRect(x: x, y: y, width: stopButtonWidth, height: self.stopButtonWidth)
        let clipPath: CGPath = UIBezierPath(roundedRect: rect, cornerRadius: rectCornerRadius).cgPath
        
        if let context = UIGraphicsGetCurrentContext() {
            context.saveGState()
            context.setFillColor(color.cgColor)
            
            context.addPath(clipPath)
            context.closePath()
            context.fillPath()
            
            context.restoreGState()
        }
    }
    
    fileprivate func drawEmptyCircle(){
        drawCircle(endAngle: startAngle + CGFloat(M_PI * 2),lineWidth: emptyLineWidth, radius: radius)
    }

    fileprivate func drawProgress(){
        let endAngle = startAngle + CGFloat(M_PI * 2 * progress)
        let innerRadius = radius - progressLineWidth * 0.5
        self.drawCircle(endAngle: endAngle, lineWidth: progressLineWidth, radius: innerRadius)
    }
    
    fileprivate func drawCircle(endAngle:CGFloat,lineWidth:CGFloat,radius:CGFloat){
        let bezier = UIBezierPath()
        bezier.addArc(withCenter:middle, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        bezier.lineWidth = lineWidth
        
        color.setStroke()
        bezier.stroke()
    }
}
