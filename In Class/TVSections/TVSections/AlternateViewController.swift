//
//  AlternateViewController.swift
//  TVSections
//
//  Created by Blake Oistad on 11/11/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class AlternateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var alternateTableView: UITableView!
    
    var animalArray = [Animals(animalCategory: "Dogs", animalType: "Alaskan Malamute"),
        Animals(animalCategory: "Dogs", animalType: "Cocker Spaniel"),
        Animals(animalCategory: "Dogs", animalType: "Pit Bull"),
        Animals(animalCategory: "Dogs", animalType: "Bulldog"),
        Animals(animalCategory: "Dogs", animalType: "German Shepherd"),
        Animals(animalCategory: "Dogs", animalType: "Beagle"),
        Animals(animalCategory: "Dogs", animalType: "Collie"),
        Animals(animalCategory: "Dogs", animalType: "Brittany"),
        Animals(animalCategory: "Dogs", animalType: "Greyhound"),
        Animals(animalCategory: "Dogs", animalType: "Great Dane"),
        Animals(animalCategory: "Dogs", animalType: "Pekingese"),
        Animals(animalCategory: "Cats", animalType: "Asian"),
        Animals(animalCategory: "Cats", animalType: "Balinese"),
        Animals(animalCategory: "Cats", animalType: "Bengal"),
        Animals(animalCategory: "Cats", animalType: "Bombay"),
        Animals(animalCategory: "Cats", animalType: "Burmese"),
        Animals(animalCategory: "Cats", animalType: "Cyprus"),
        Animals(animalCategory: "Cats", animalType: "Korat"),
        Animals(animalCategory: "Cats", animalType: "Manx"),
        Animals(animalCategory: "Cats", animalType: "Napoleon")]

    var sectionsArray = [String]()
    
    func createSectionArray() -> [String] {
        var categorySet = Set<String>()
        for animal in animalArray {
            categorySet.insert(animal.animalCategory)       //will insert dogs, and will try again but since its a set it wont be able to duplicate it, same with cats and whatever other categories
        }
        return Array(categorySet)
    }
    
    func filterAnimalsByCategory(category: String) -> [Animals] {       //take the entire array and filter it
        let filteredAnimals = animalArray.filter({                      //sort of works like a loop
            $0.animalCategory == category                               //$0 gives access to current item as i loop through and get the animal category and see if its equal to category being passed in
                                                                        //are you a dog, yes, are you a dog, yes, are you a dog, no, so youre excluded from the filter
        })
        return filteredAnimals
    }
    
    
    //MARK: - Table View Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionsArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterAnimalsByCategory(sectionsArray[section]).count            //getting the section in the section array, filtering it by the category, and returing the count of said category
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = filterAnimalsByCategory(sectionsArray[indexPath.section]) [indexPath.row].animalType         //filter the initial array for the section were in, then go after the row and pull out the animal type
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsArray[section]
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Count: \(filterAnimalsByCategory(sectionsArray[section]).count)"
    }
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let newAnimal = Animals(animalCategory: "Pet", animalType: "Snake")               easy creation of new animal object using custom init
        sectionsArray = createSectionArray()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}





















