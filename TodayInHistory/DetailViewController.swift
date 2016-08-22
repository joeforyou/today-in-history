//
//  DetailViewController.swift
//  TodayInHistory
//
//  Created by Joseph Kleinschmidt on 8/20/16.
//  Copyright © 2016 Joseph Kleinschmidt. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var links: NSArray = []
    var currentEvent: String?
    
    @IBOutlet weak var eventDetailTextLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventDetailTextLabel.text = currentEvent
        self.navigationController?.navigationBarHidden = false
        print(links)
    }
    
    //MARK: - TABLE VIEW
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "DetailCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DetailTableViewCell
        // Fetches the appropriate vehicle for the data source layout.
        
        let link = links[indexPath.row]["link"] as? String
        
        cell.buttonLabel.setTitle(link, forState: UIControlState.Normal)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count
    }
}
