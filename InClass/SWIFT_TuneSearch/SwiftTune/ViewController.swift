//
//  ViewController.swift
//  SwiftTune
//
//  Created by Blake Oistad on 11/3/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {


    //MARK: - Properties
    
    var networkManager = NetworkManager.sharedInstance          //this runs the network manager as soon as the program loads
    var dataManager = DataManager.sharedInstance
    @IBOutlet var tunesCollectionView :UICollectionView!
    
    //MARK: - Collection View Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.tunesArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! TuneCollectionViewCell
        let currentTune = dataManager.tunesArray[indexPath.row]
        cell.artistNameLabel!.text = currentTune.artistName
        cell.trackNameLabel!.text = currentTune.trackName
        
        //check for local existance of image file
        let localFileName = dataManager.cleanStringForFileManager(currentTune.artworkUrl100)
        if dataManager.fileIsLocal(localFileName) {
            cell.artworkImageView.image = UIImage(named: dataManager.getDocumentPathForFile(localFileName))
        } else {
            print("File not local")
            dataManager.getImageFromServer(localFileName, remoteFilename: currentTune.artworkUrl100, indexPathRow: indexPath.row)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 140)
    }
    
    
    //MARK: - Interactivity Methods
    
    @IBAction func searchButtonPressed(sender: UIBarButtonItem) {
        print("Search Button Pressed")
        if networkManager.serverAvailable {
            dataManager.getDataFromServer()
        } else {
            print("Server Not Available")
        }
    }
    
    func newDataReceived() {
        print("New Data Recieved")
        tunesCollectionView.reloadData()
    }
    
    func newImageReceived(note: NSNotification) {
        print("Got Image")
        tunesCollectionView.reloadData()
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newDataReceived", name: "receivedDataFromServer", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newImageReceived:", name: "gotImageFromServer", object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Yo!")

    }

}

