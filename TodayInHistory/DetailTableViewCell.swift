//
//  DetailTableViewCell.swift
//  TodayInHistory
//
//  Created by Joseph Kleinschmidt on 8/20/16.
//  Copyright © 2016 Joseph Kleinschmidt. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
        
    @IBOutlet weak var buttonLabel: UIButton!
    @IBAction func openURL(sender: UIButton) {
        let url = NSURL(string: (sender.titleLabel?.text)!)
        UIApplication.sharedApplication().openURL(url!)
    }

}