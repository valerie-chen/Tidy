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

    // ticks
    for i in 0...59 {
      let path = UIBezierPath()
      let lineLayer = CAShapeLayer()
      let angle = Double(i) * Double.pi / 30
      if (i%5 == 0) {
        path.move(to: CGPoint(x: radius + cos(angle) * radius * 0.95,
                              y: radius + sin(angle) * radius * 0.95))
        path.addLine(to: CGPoint(x: radius + cos(angle) * radius * 0.8,
                                 y: radius + sin(angle) * radius * 0.8))
        lineLayer.lineWidth = 2
      } else {
        path.move(to: CGPoint(x: radius + cos(angle) * radius, y: radius + sin(angle) * radius))
        path.addLine(to: CGPoint(x: radius + cos(angle) * radius * 0.92,
                                 y: radius + sin(angle) * radius * 0.92))
        lineLayer.lineWidth = 1
      }
      lineLayer.path = path.cgPath
      lineLayer.strokeColor = UIColor.black.cgColor
      layer.addSublayer(lineLayer)
    }
    
    // clock border
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: radius, y: radius),
                                  radius: CGFloat(radius),
                                  startAngle: 0,
                                  endAngle: CGFloat(Double.pi * 2.0),
                                  clockwise: true)
    let circleLayer = CAShapeLayer()
    circleLayer.path = circlePath.cgPath
    circleLayer.fillColor = UIColor.clear.cgColor
    circleLayer.strokeColor = UIColor.black.cgColor
    circleLayer.zPosition = -1
    circleLayer.lineWidth = 2
    
    // red inner circle (seconds accessory)
    let redCirclePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y: self.frame.width/2),
                                       radius: 5,
                                       startAngle: 0,
                                       endAngle: CGFloat(Double.pi * 2.0),
                                       clockwise: true)
    let redCircleLayer = CAShapeLayer()
    redCircleLayer.path = redCirclePath.cgPath
    redCircleLayer.fillColor = UIColor.red.cgColor
    redCircleLayer.strokeColor = UIColor.red.cgColor
    
    layer.addSublayer(circleLayer)
    layer.addSublayer(redCircleLayer)
    
    // numbers
    for i in 0...3 {
      let numLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 24, height: 16))
      let angle = Double(i) * 0.5 * Double.pi
      numLabel.center = CGPoint(x: radius + cos(angle)*radius*0.67,
                                y: radius + sin(angle)*radius*0.67)
      numLabel.text = String(i == 3 ? 12 : 12-((i+1)*3))
      numLabel.textAlignment = .center
      numLabel.font = UIFont(name: "Futura-Bold", size: 10)!
      self.addSubview(numLabel)
    }
  }

  func drawHands() {
    let date = Date()
    let calendar = Calendar.current
    let radius = Double(self.frame.width/2)
    
    let secondPath = UIBezierPath()
    let minutePath = UIBezierPath()
    let hourPath = UIBezierPath()
    
    // second hand
    let second = calendar.component(.second, from: date)
    let secondAngle = (270 - Double(second) * 6)/360 * 2 * Double.pi
    secondPath.move(to: CGPoint(x: radius - cos(secondAngle) * radius * 0.2,
                                y: radius - sin(secondAngle) * radius * 0.2))
    secondPath.addLine(to: CGPoint(x: radius + cos(secondAngle) * radius,
                                   y: radius + sin(secondAngle) * radius))
    secondPath.lineWidth = CGFloat(0.5)
    
    // minute hand
    let minute = calendar.component(.minute, from: date)
    let minuteAngle = (270 - (Double(minute) + Double(second)/60) * 6)/360 * 2 * Double.pi
    minutePath.move(to: CGPoint(x: radius, y: radius))
    minutePath.addLine(to: CGPoint(x: radius + cos(minuteAngle) * radius * 0.8,
                                   y: radius + sin(minuteAngle) * radius * 0.8))
    minutePath.lineWidth = CGFloat(2)
    
    // hour hand
    let hour = calendar.component(.hour, from: date)
    let hourAngle = (270 - (Double(hour) + Double(minute)/60) * 30)/360 * 2 * Double.pi
    hourPath.move(to: CGPoint(x: radius, y: radius))
    hourPath.addLine(to: CGPoint(x: radius + cos(hourAngle) * radius * 0.6,
                                 y: radius + sin(hourAngle) * radius * 0.6))
    hourPath.lineWidth = CGFloat(2)

    minutePath.stroke()
    hourPath.stroke()
    UIColor.red.setStroke()
    secondPath.stroke()
    UIColor.black.setStroke()
  }
  
  func start() {
    let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
      self.setNeedsDisplay()
    }
    RunLoop.main.add(timer, forMode: .commonModes)
  }
}
