//
//  ClockView.swift
//  Tidy
//
//  Created by Valerie Chen on 12/24/17.
//  Copyright © 2017 Valerie Chen. All rights reserved.
//

import UIKit

class ClockView: UIView {
  
  override func draw(_ rect: CGRect) {
    self.drawHands()
  }
  
  func setup() {
    self.drawFrame()
  }
  
  internal func drawFrame() {
    let radius = Double(self.frame.width/2)

    for i in 0...59 {
      let path = UIBezierPath()
      let lineLayer = CAShapeLayer()
      let angle = Double(i) * Double.pi / 30
      path.move(to: CGPoint(x: CGFloat(radius + cos(angle) * radius),
                            y: CGFloat(radius + sin(angle) * radius)))
      if (i%5 == 0) {
        path.addLine(to: CGPoint(x: radius + cos(angle) * radius * 0.85,
                                 y: radius + sin(angle) * radius * 0.85))
        lineLayer.lineWidth = 2
      } else {
        path.addLine(to: CGPoint(x: radius + cos(angle) * radius * 0.92,
                                 y: radius + sin(angle) * radius * 0.92))
        lineLayer.lineWidth = 1
      }
      lineLayer.path = path.cgPath
      lineLayer.strokeColor = UIColor.black.cgColor
      layer.addSublayer(lineLayer)
    }
    
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y: self.frame.width/2),
                                  radius: CGFloat(radius),
                                  startAngle: 0,
                                  endAngle: CGFloat(Double.pi * 2.0),
                                  clockwise: true)
    let circleLayer = CAShapeLayer()
    circleLayer.path = circlePath.cgPath
    circleLayer.fillColor = UIColor.clear.cgColor
    circleLayer.strokeColor = UIColor.black.cgColor
    circleLayer.lineWidth = 2
    
    layer.addSublayer(circleLayer)
  }

  func drawHands() {
    let date = Date()
    let calendar = Calendar.current
    let radius = Double(self.frame.width/2)
    
    let secondPath = UIBezierPath()
    let minutePath = UIBezierPath()
    let hourPath = UIBezierPath()
    
    secondPath.move(to: CGPoint(x: radius, y: radius))
    minutePath.move(to: CGPoint(x: radius, y: radius))
    hourPath.move(to: CGPoint(x: radius, y: radius))
    
    // second hand
    let second = calendar.component(.second, from: date)
    let secondAngle = (270 - Double(second) * 6)/360 * 2 * Double.pi
    secondPath.addLine(to: CGPoint(x: radius + cos(secondAngle) * radius,
                             y: radius + sin(secondAngle) * radius))
    secondPath.lineWidth = CGFloat(0.5)
    
    // minute hand
    let minute = calendar.component(.minute, from: date)
    let minuteAngle = (270 - (Double(minute) + Double(second)/60) * 6)/360 * 2 * Double.pi
    minutePath.addLine(to: CGPoint(x: radius + cos(minuteAngle) * radius * 0.8,
                             y: radius + sin(minuteAngle) * radius * 0.8))
    
    // hour hand
    let hour = calendar.component(.hour, from: date)
    let hourAngle = (270 - (Double(hour) + Double(minute)/60) * 30)/360 * 2 * Double.pi
    hourPath.move(to: CGPoint(x: radius, y: radius))
    hourPath.addLine(to: CGPoint(x: radius + cos(hourAngle) * radius * 0.6,
                             y: radius + sin(hourAngle) * radius * 0.6))

    secondPath.stroke()
    minutePath.stroke()
    hourPath.stroke()
  }
  
  func start() {
    let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
      self.setNeedsDisplay()
    }
    RunLoop.main.add(timer, forMode: .commonModes)
  }
}
