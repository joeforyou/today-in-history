//
//  ProfileViewController.swift
//  TodayInHistory
//
//  Created by Joseph Kleinschmidt on 8/19/16.
//  Copyright © 2016 Joseph Kleinschmidt. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func saveButtonPressed(sender: UIButton) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setValue(emailTextField.text, forKey: "CurrentEmail")
        defaults.setValue(firstNameTextField.text, forKey: "CurrentFirst")
        defaults.setValue(lastNameTextField.text, forKey: "CurrentLast")
        defaults.setValue(passwordTextField.text, forKey: "CurrentPassword")
        defaults.synchronize()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let currentEmail = defaults.stringForKey("CurrentEmail")
        let currentFirst = defaults.stringForKey("CurrentFirst")
        let currentLast = defaults.stringForKey("CurrentLast")
        let currentPassword = defaults.stringForKey("CurrentPassword")
        
        emailTextField.text = currentEmail
        firstNameTextField.text = currentFirst
        lastNameTextField.text = currentLast
        passwordTextField.text = currentPassword
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
