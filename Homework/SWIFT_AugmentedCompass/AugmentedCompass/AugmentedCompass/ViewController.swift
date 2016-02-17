//
//  ViewController.swift
//  AugmentedCompass
//
//  Created by Blake Oistad on 11/16/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation
import AVFoundation

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    //MARK:- Camera Methods
    
    @IBOutlet weak var previewView: UIView!
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?

    func startCaptureSession() {
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
        
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print("Error \(error)")
        }
        if error == nil && captureSession!.canAddInput(input) {
            captureSession!.addInput(input)
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
//            previewLayer!.connection?.videoOrientation = .Portrait
            previewView.layer.addSublayer(previewLayer!)
            captureSession!.startRunning()
        }
    }
    
    
    
    //MARK:- Orientation Methods
    
    var locationManager = CLLocationManager()
    @IBOutlet var headingLabel: UILabel!
    
    func startGettingHeading() {
     locationManager.delegate = self
     locationManager.startUpdatingHeading()
    }

    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        var headingString = ""
        switch newHeading.magneticHeading {
        case 0...22.5:
            headingString = "N"
        case 22.5...67.5:
            headingString = "NE"
        case 67.5...112.5:
            headingString = "E"
        case 112.5...157.5:
            headingString = "SE"
        case 157.5...202.5:
            headingString = "S"
        case 202.5...247.5:
            headingString = "SW"
        case 247.5...292.5:
            headingString = "W"
        case 292.5...337.5:
            headingString = "NW"
        case    337.5...360.0:
            headingString = "N"
            
        default:
            headingString = "?"
        }
        let wholeDegrees = String(format: "%.0f", newHeading.magneticHeading)
        headingLabel.text = "\(wholeDegrees)° \(headingString)"
    }
    
    
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGettingHeading()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        startCaptureSession()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer!.frame = previewView.bounds
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

