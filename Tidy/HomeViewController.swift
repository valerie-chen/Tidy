//
//  HomeViewController.swift
//  Tidy
//
//  Created by Valerie Chen on 12/24/17.
//  Copyright © 2017 Valerie Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

  var _welcomeLabel = UILabel()
  var _clockView: ClockView?
  
  override func viewDidLoad() {
    // Do any additional setup after loading the view, typically from a nib.
    super.viewDidLoad()
    
    let dayString = self.getDayOfTheWeek()
    let nameString = self.getNameFromDeviceName()
    _welcomeLabel.frame = self.view.frame
    _welcomeLabel.text = String(format: "Hey %@, Happy %@!", nameString, dayString)
    _welcomeLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
    _welcomeLabel.textAlignment = .center
    
    let screenWidth = self.view.frame.width
    let clockOrigin = CGPoint(x: screenWidth * 0.25, y: screenWidth * 0.2)
    let clockSize = CGSize(width: screenWidth * 0.5, height: screenWidth * 0.5)
    let clockFrame = CGRect(origin: clockOrigin, size: clockSize)
    _clockView = ClockView(frame: clockFrame)
    _clockView?.backgroundColor = .clear
    _clockView?.setup()
    
//    let tapGesture = UIGestureRecognizer(target: _clockView, action: #selector(_clockView?.didTap))
//    _clockView?.addGestureRecognizer(tapGesture)
    
    self.view.addSubview(_welcomeLabel)
    self.view.addSubview(_clockView!)
    
    _clockView?.start()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func getDayOfTheWeek() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
    return dateFormatter.string(from: Date())
  }
  
  func getNameFromDeviceName() -> String {
    let deviceString = UIDevice.current.name
    let tokens = deviceString.components(separatedBy: "’s")
    return tokens[0]
  }
}

