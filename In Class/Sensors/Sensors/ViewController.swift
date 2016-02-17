//
//  ViewController.swift
//  Sensors
//
//  Created by Blake Oistad on 11/16/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation
import AVFoundation

class ViewController: UIViewController, CLLocationManagerDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    
    
    //MARK:- Record Audio Methods
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    @IBAction func startRecording(sender: UIBarButtonItem) {
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.setActive(true)
            try audioSession.overrideOutputAudioPort(.Speaker)              //forces audio through speaker even with headphones)
        } catch {
            print("Audio Session Error")
        }
        
        //set up path to documents direcory
        let docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let filenameWithPath = docPath.stringByAppendingPathComponent("recording.caf")              //currently overwriting each recording session
        let url = NSURL.fileURLWithPath(filenameWithPath)
        
        let recordingSettings =
            [AVFormatIDKey:NSNumber(unsignedInt: kAudioFormatAppleIMA4),
            AVSampleRateKey:44100.0,
            AVNumberOfChannelsKey:2,
            AVEncoderBitRateKey:12800,
            AVLinearPCMBitDepthKey:16,
        AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue] as [String : AnyObject]
        
        do {
            audioRecorder = try AVAudioRecorder(URL: url, settings: recordingSettings)
            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
            print("Audio Recording Error")
        }
        
    }
    
    @IBAction func stopRecording(sender: UIBarButtonItem) {
        if audioRecorder.recording {
            audioRecorder.stop()
        }
    }
    
    @IBAction func playRecording(sender: UIBarButtonItem)  {
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: audioRecorder!.url)      //it will try to play what is there to play but if there isnt anything to play, audio player error
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
            audioPlayer.play()
        } catch {
            print("Audio Player Error")
        }
    }
    
    //MARK:- Camera Methods
    
    @IBOutlet weak var previewView: UIView!
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    @IBOutlet weak var capturedImage: UIImageView!
    var stillImageOutput: AVCaptureStillImageOutput?
    
    func startCaptureSession() {
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
        
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)           //type video is for photo and video btw
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError{
            error = error1
            input = nil
            print("Error \(error)")
        }
        if error == nil && captureSession!.canAddInput(input) {
            captureSession!.addInput(input)
            //add image output
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            if captureSession!.canAddOutput(stillImageOutput) {
                captureSession!.addOutput(stillImageOutput)
            }
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)              //created preview layer
            previewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill        //doesnt actually have anything to do with gravity
            previewLayer!.connection?.videoOrientation = .Portrait
            previewView.layer.addSublayer(previewLayer!)
            captureSession!.startRunning()
        }
    }
    
    @IBAction func didPressTakePhotoButton(sender: UIButton) {
        if let videoConnection = stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo) {          //if we got anything
            videoConnection.videoOrientation = .Portrait
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: { (sampleBuffer, error) -> Void in
                if sampleBuffer != nil {                        //if the sample buffer isnt empty
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)  //take the sample and take a jpg, could also do png
                    let dataProvider = CGDataProviderCreateWithCFData(imageData)
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, .RenderingIntentDefault)
                    let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: .Right)
                    self.capturedImage.image = image
                }
            })
        }
    }
    
    //MARK:- Rotation Angles
    
    private var motionManager = CMMotionManager()
    private var timer: NSTimer?
    @IBOutlet private var angleLabel: UILabel!
    
    
    @IBAction private func startAngleFinder(sender: UIButton) {
        timer = NSTimer(timeInterval: 0.2, target: self, selector: "getAngleInfo", userInfo: nil, repeats: true)    //create timer, add it to app run loop
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    @IBAction private func stopAngleFinder(sender: UIButton) {
        if let uTimer = timer {
            uTimer.invalidate()     //this will stop the timer if the timer has been started
        }
    }
    
    func getAngleInfo() {
        if let uDeviceMotion = motionManager.deviceMotion {
            let currentGravity = uDeviceMotion.gravity          //gravity is how fast you're moving the device from one point to another, measures acceleration
            let angleInRadians = atan2(currentGravity.y, currentGravity.x)      //only care about two angles, not caring about z axis (hence rotation)
            var angleInDegrees = (angleInRadians * 180.0 / M_PI)
            if angleInDegrees <= -90.0 {
                angleInDegrees += 450.0
            } else {
                angleInDegrees += 90.0
            }
            
            angleLabel.text = "Angle: " + String(format: "%.0f", angleInDegrees) + " degrees"
        }

    }
    
    //MARK:- Compass Methods
    
    var locationManager = CLLocationManager()
    @IBOutlet var headingLabel: UILabel!
    
    @IBAction func startGettingHeading(sender: UIButton) {
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
    }
    
    @IBAction func stopGettingHeading(sender: UIButton) {
        locationManager.stopUpdatingHeading()
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
        headingLabel.text = "Heading: \(headingString) \(wholeDegrees) degrees"
    }
    
    
    //MARK:- Shake Methods
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            print("Shaken Baby!")
        }
    }
    
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motionManager.startDeviceMotionUpdates()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        startCaptureSession()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer!.frame = previewView.bounds            //set the layer to the same size as the previewView
    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .All
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

