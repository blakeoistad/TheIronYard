//
//  ViewController.swift
//  SwiftTuneTV
//
//  Created by Blake Oistad on 11/18/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    var dataManager = DataManager.sharedInstance
    var networkManager = NetworkManager.sharedInstance
    
    @IBOutlet weak var tuneCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    var audioPlayer: AVPlayer!

    
    //MARK:- Data Methods
    
    func newDataReceived() {
        tuneCollectionView.reloadData()
    }
    
    func newImageReceived() {
        tuneCollectionView.reloadData()
    }
    
    
    //MARK:- Interactivity Methods
    
    @IBAction func getButtonPressed(sender: UIButton) {
        if networkManager.serverAvailable {
            dataManager.getDataFromServer(searchTextField.text!)
        } else {
            print("Server not available at get")
        }
    }
    
    
    
    //MARK:- Collection View Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.tunesArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! TuneCollectionViewCell
        let currentTune = dataManager.tunesArray[indexPath.row]
        cell.artistNameLabel.text = currentTune.artistName
        cell.trackNameLabel.text = currentTune.trackName
        
        let localFileName = dataManager.cleanStringForFileManager(currentTune.artworkUrl100)
        if dataManager.fileIsLocal(localFileName) {
            cell.artworkImageView.image = UIImage(named: dataManager.getCachesPathForFile(localFileName))
        } else {
            dataManager.getImageFromServer(localFileName, remoteFilename: currentTune.artworkUrl100, indexPathRow: indexPath.row)
        }
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let currentItem = dataManager.tunesArray[indexPath.row]
//        if currentItem.hasFocus {
//            return CGSizeMake(200, 240)
//        } else {
        
            return CGSizeMake(100, 120)
//        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Selected \(indexPath.row)")
        let currentItem = dataManager.tunesArray[indexPath.row]
        let url = NSURL(string: currentItem.previewURL)!
        let playerItem = AVPlayerItem(URL: url)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer.play()
    }
    
    func collectionView(collectionView: UICollectionView, canFocusItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, shouldUpdateFocusInContext context: UICollectionViewFocusUpdateContext) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didUpdateFocusInContext context: UICollectionViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        print("Prev: \(context.nextFocusedIndexPath?.row)")
        if context.nextFocusedView != nil {
            coordinator.addCoordinatedAnimations({ () -> Void in
                context.nextFocusedView!.transform = CGAffineTransformMakeScale(1.5, 1.5)
            }, completion: nil)
        }
        if context.previouslyFocusedView != nil {
            coordinator.addCoordinatedAnimations({ () -> Void in
                context.previouslyFocusedView!.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }, completion: nil)
        }
    }
    
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newDataReceived", name: "receivedDataFromServer", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newImageReceived", name: "gotImageFromServer", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

