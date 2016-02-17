//
//  ViewController.swift
//  SwiftToDo
//
//  Created by Blake Oistad on 10/27/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //insert appDeleagate, as! means we know AppDelegate will always be there and will be needed
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext :NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var toDoArray = [ToDos]()               //alloc inits the empty todo array
    @IBOutlet weak var todoTableView :UITableView!
    
    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = toDoArray[indexPath.row].todoDescription
        return cell
    }
    
    //MARK: - Interactivity Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destController = segue.destinationViewController as! DetailViewController
        if segue.identifier == "editSegue" {
            let indexPath = todoTableView.indexPathForSelectedRow!      //need bang because we can only perform this if we know we have a selected index path
            let selectedToDo = toDoArray[indexPath.row]                //infers that selectedTodo is an object ToDo because it knows the array is of type ToDo
            destController.selectedToDo = selectedToDo
            todoTableView.deselectRowAtIndexPath(indexPath, animated: true)     //when we come back, row wont be highlighted anymore
        }
    }
    
    //MARK: - Core Data Methods
    
    func tempAddRecords() {
        let entityDescription :NSEntityDescription! = NSEntityDescription.entityForName("ToDos", inManagedObjectContext: managedObjectContext)
        let currentToDo :ToDos! = ToDos(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        currentToDo.todoDescription = "Fold the laundry"
        currentToDo.todoComplete = false
        currentToDo.todoDateDue = NSDate()
        currentToDo.dateEntered = NSDate()
        currentToDo.userID = "System"
        appDelegate.saveContext()
    }
    
    func fetchToDos() -> [ToDos]? {           //want it to return an array of ToDos
        let fetchRequest :NSFetchRequest! = NSFetchRequest(entityName: "ToDos")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "todoDescription", ascending: true)]       //sortdescriptors needs to be an array
        do {
            let tempArray = try managedObjectContext!.executeFetchRequest(fetchRequest) as! [ToDos]      //wrapping todos in [] because it is an array
            return tempArray
        } catch {
            return nil
        }
    }
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
//        tempAddRecords()
        //TODO: clean up this code
        toDoArray = fetchToDos()!
        todoTableView.reloadData()
        let firstToDo = toDoArray.first
        print("Count: \(toDoArray.count) ToDo:\(firstToDo!.todoDescription)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

