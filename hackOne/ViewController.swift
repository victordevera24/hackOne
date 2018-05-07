//
//  ViewController.swift
//  hackOne
//
//  Created by Victor De Vera on 5/3/18.
//  Copyright © 2018 Victor De Vera. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var motionLabel: UILabel!
    
    @IBOutlet weak var poseLabel: UILabel!
    @IBAction func behindBack(_ sender: UIButton) {
        pose = "Hold phone in right hand and meet left hand behind back. Press start button and hold pose for 5 seconds"
        choice = 1
        updatePoseUI()
    }
    @IBAction func chairPose(_ sender: UIButton) {
        pose = "Hold phone between both palms and pose like picture. Press start button and hold pose for 5 seconds"
        choice = 2
        updatePoseUI()
    }
    @IBOutlet weak var startButton: UIButton!
    @IBAction func startButton(_ sender: Any) {
    }
    var backPose: Int = 0
    var sidePose: Int = 0
    var score: String = ""
    var choice: Int = 0
    @IBAction func startButtonPressed(_ sender: UIButton) {
        self.motionLabel.text = "5"
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.motionLabel.text = "4"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.motionLabel.text = "3"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.motionLabel.text = "2"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.motionLabel.text = "1"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if self.choice == 1 {
                print("hello")
                self.backPose = self.motion
                print(self.backPose)
                self.updateUI()
                if self.backPose <= 0 {
                    self.score = "nice try"
                }
                if self.backPose > 0 && self.backPose <= 40 {
                    self.score = "\u{1F31F} Go to sports day! Stop typing so much!\u{1F31F}"
                }
                if self.backPose > 40 && self.backPose <= 70 {
                    self.score = "\u{1F31F}\u{1F31F}Do more yoga\u{1F31F}\u{1F31F}"
                }
                if self.backPose > 70 && self.backPose < 100 {
                    self.score = "\u{1F31F}\u{1F31F}\u{1F31F}YOGA Master\u{1F31F}\u{1F31F}\u{1F31F}"
                }
                self.poseLabel.text = self.score
            }
            if self.choice == 2 {
                self.sidePose = self.sideMotion
                self.updateUI()
                if self.sidePose > 0 && self.sidePose < 40 && self.sidePose < 0 && self.sidePose > -40 {
                    self.score = "did this work"
                }
                if self.sidePose > 40 && self.sidePose < 70 && self.sidePose < -40 && self.sidePose > -70 {
                    self.score = "holy crap"
                }
                if self.sidePose > 70 && self.sidePose < 100  && self.sidePose < -70 && self.sidePose > -100 {
                    self.score = "\u{1F31F}\u{1F31F}\u{1F31F}\u{1F31F}\u{1F31F}\u{1F31F}"
                }
                self.poseLabel.text = self.score
            }
        }
    }
    var pose: String = ""
    func updatePoseUI() {
        poseLabel.text = pose
    }
    var motionManager = CMMotionManager()
    let opQueue = OperationQueue()
    override func viewDidLoad() {
        super.viewDidLoad()
        if motionManager.isDeviceMotionAvailable {
            print("We can detect device motion")
            startReadingMotionData()
        }
        else {
            print("We cannot detect device motion")
        }
    }
    var motion: Int = 0
    var sideMotion: Int = 0
    func startReadingMotionData() {
        // set read speed
        motionManager.deviceMotionUpdateInterval = 0.5
        // start reading
        motionManager.startDeviceMotionUpdates(to: opQueue) {
            (data: CMDeviceMotion?, error: Error?) in
            if let mydata = data {
//                print("mydata.gravity", mydata.gravity)
//                print("pitch raw", mydata.attitude.pitch)
                print("pitch", self.degrees(mydata.attitude.pitch))
                print("roll", self.degrees(mydata.attitude.roll))
                if self.degrees(mydata.attitude.pitch) < 0.0 {
                    print("Changed")
                    self.motion = Int(self.degrees(mydata.attitude.pitch))
                    self.updateUI()
                }
                if self.degrees(mydata.attitude.pitch) > 0.0 {
                    print("Changed")
                    self.motion = Int(self.degrees(mydata.attitude.pitch))
                    self.updateUI()
                }
                if self.degrees(mydata.attitude.roll) < 0.0 {
                    print("Changed")
                    self.sideMotion = Int(self.degrees(mydata.attitude.roll))
                    self.updateUI()
                }
                if self.degrees(mydata.attitude.roll) > 0.0 {
                    print("Changed")
                    self.sideMotion = Int(self.degrees(mydata.attitude.roll))
                    self.updateUI()
                }
                
            }
        }
    }
    // dispathQueue.main.asyncAfter(deadline: .now() + 2) {}
    
    func degrees(_ radians: Double) -> Double {
        return 180/Double.pi * radians
    }
    
    func updateUI() {
//        DispatchQueue.main.async {
//            self.motionLabel.text = String(self.motion)
//        }
        self.motionLabel.text = String(self.backPose)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

