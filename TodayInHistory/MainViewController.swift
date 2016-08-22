//
//  MainViewController.swift
//  TodayInHistory
//
//  Created by Joseph Kleinschmidt on 8/19/16.
//  Copyright © 2016 Joseph Kleinschmidt. All rights reserved.
//

import UIKit
import CoreData

import Alamofire

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var eventTableView: UITableView!
    var events = [Event]()

    @IBOutlet weak var currentDateTextLabel: UILabel!
    
    @IBOutlet weak var datePickerViewBottomConstraint: NSLayoutConstraint!
    @IBAction func selectDateButtonPressed(sender: UIButton) {
        self.datePickerViewBottomConstraint.constant = -93
        self.view.setNeedsLayout()
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                print("picker view is showing")
        })
    }
    
    @IBAction func goButtonPressed(sender: UIButton) {
        self.datePickerViewBottomConstraint.constant = 250
        self.view.setNeedsLayout()
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            self.view.layoutIfNeeded()
            }, completion: { _ in
                print("picker view is hiding")
        })
        self.events = [Event]()
        self.viewDidLoad()
        self.eventTableView.reloadData()
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        // set preferences
        
        let sb = Selector(defaults.stringForKey("BackgroundColor")!)
        self.view.backgroundColor = UIColor.performSelector(sb).takeUnretainedValue() as? UIColor
        
        let st = Selector(defaults.stringForKey("TextColor")!)
        self.currentDateTextLabel.textColor = UIColor.performSelector(st).takeUnretainedValue() as? UIColor
        
        let sf = defaults.stringForKey("FontFamily")
        if defaults.boolForKey("BoldText") == true {
            self.currentDateTextLabel.font = UIFont(name: "\(sf!)-Bold", size: 18)
        }
        else {
            self.currentDateTextLabel.font = UIFont(name: sf!, size: 18)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentEmail = defaults.stringForKey("CurrentEmail") {
            //print(currentEmail)
        }
        if defaults.stringForKey("BackgroundColor") == nil {
            let backgroundColor = "whiteColor"
            defaults.setValue(backgroundColor, forKey: "BackgroundColor")
        }
        else if defaults.stringForKey("TextColor") == nil {
            let textColor = "blackColor"
            defaults.setValue(textColor, forKey: "TextColor")
        }
        else if defaults.stringForKey("FontFamily") == nil {
            let fontFamily = "Helvetica Neue"
            defaults.setValue(fontFamily, forKey: "FontFamily")
        }
        else if defaults.boolForKey("BoldText") == false {
            let boldText = false
            defaults.setBool(boldText, forKey: "BoldText")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        let date = self.datePicker.date

        let otherFormatter = NSDateFormatter()
        otherFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        let displayDate = otherFormatter.stringFromDate(date)
        
        let indexDispDateEnd = displayDate.endIndex.advancedBy(-6)
        
        let substringDispDate = displayDate.substringToIndex(indexDispDateEnd)
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let dateString = formatter.stringFromDate(date)
        
        let indexEnd = dateString.endIndex.advancedBy(-3)
        
        let substringDate = dateString.substringToIndex(indexEnd)
        
        self.currentDateTextLabel.text = "\(substringDispDate)"
        
        func getHistory() {
            Alamofire.request(.GET, "http://history.muffinlabs.com/date/\(substringDate)" )
                .responseJSON { response in
                    if let JSON = response.result.value!["data"]!!["Events"] as? NSArray {
                        for event in JSON {
                            let newEvent = Event.init(year: event["year"]!! as! String, text: event["text"]!! as! String)
                            if event["links"]!!.count > 0 {
                                let linkArray = event["links"]!! as! NSArray
                                newEvent!.links = linkArray
                                print(linkArray)
                            }
                            self.events.append(newEvent!)
                        }
                        self.eventTableView.reloadData()
                    }
            }
        }
        
        getHistory()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - API Call
    
    
    // MARK: - Custom Core Data methods...
    
    func saveNewUser(firstName: String, lastName: String, email: String, password: String){
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
        newUser.firstName = firstName
        newUser.lastName = lastName
        newUser.email = email
        newUser.password = password
        
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        
        //        fetchAllUsers()
    }
    
    // MARK: - TABLE VIEW functions
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let eventDetailVC = self.storyboard?.instantiateViewControllerWithIdentifier("DetailVC") as! DetailViewController
        
        eventDetailVC.title = events[indexPath.row].year
        eventDetailVC.links = events[indexPath.row].links
        eventDetailVC.currentEvent = events[indexPath.row].text
        
        self.navigationController?.pushViewController(eventDetailVC, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EventCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventTableViewCell
        // Fetches the appropriate vehicle for the data source layout.
        let anEvent = events[indexPath.row]
        
        cell.yearLabel.text = anEvent.year
        cell.eventTextLabel.text = anEvent.text
        let sf = defaults.stringForKey("FontFamily")
        cell.eventTextLabel.font = UIFont(name: sf!, size: 17.0)
        
        let numLinks = anEvent.links.count
        cell.noLinksLabel.text = "\(numLinks) link(s)"
        cell.noLinksLabel.font = UIFont(name:"HelveticaNeue-Italic", size: 16.0)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
}

