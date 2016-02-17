//
//  DetailViewController.swift
//  SwiftToDo
//
//  Created by Blake Oistad on 10/27/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    var selectedToDo :ToDos?                    //here we may be passing in nil data from an add button that has no current ToDo data, hence the optional
    
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Got \(selectedToDo?.todoDescription)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


}
