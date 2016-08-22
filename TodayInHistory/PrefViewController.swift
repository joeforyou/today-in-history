//
//  PrefViewController.swift
//  TodayInHistory
//
//  Created by Joseph Kleinschmidt on 8/19/16.
//  Copyright © 2016 Joseph Kleinschmidt. All rights reserved.
//

import UIKit

class PrefViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var pickerArray = []
    var selectedPicker = 0
    var backColors = ["White", "Black", "Gray", "Red", "Green", "Blue", "Cyan", "Yellow", "Magenta", "Orange", "Purple", "Brown"]
    var textColors = ["Black", "Gray", "Blue", "Brown"]
    var colorName: String?
    var fonts: Array<String> = []
    var bold: Bool?

    @IBOutlet weak var pickerViewOutlet: UIPickerView!
    
    @IBOutlet weak var currentBackColor: UILabel!
    @IBOutlet weak var currentTextColor: UILabel!
    @IBOutlet weak var currentFont: UILabel!
    
    @IBAction func changeBackColor(sender: UIButton) {
        self.selectedPicker = 1
        self.pickerViewOutlet.reloadAllComponents()
        print(self.selectedPicker)
    }
 
    @IBAction func changeTextColor(sender: UIButton) {
        self.selectedPicker = 2
        self.pickerViewOutlet.reloadAllComponents()
        print(self.selectedPicker)
    }
    
    @IBAction func changeFont(sender: UIButton) {
        self.selectedPicker = 3
        self.pickerViewOutlet.reloadAllComponents()
        print(self.selectedPicker)
    }
    
    @IBOutlet weak var onOffSwitch: UISwitch!
    
    @IBAction func switchPressed(sender: UISwitch) {
        if defaults.boolForKey("BoldText") == false {
            defaults.setBool(true, forKey: "BoldText")
        }
        else {
            defaults.setBool(false, forKey: "BoldText")
        }
        defaults.synchronize()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.currentBackColor.text = defaults.stringForKey("BackgroundColor")
        self.currentTextColor.text = defaults.stringForKey("TextColor")
        self.currentFont.text = defaults.stringForKey("FontFamily")
        if defaults.boolForKey("BoldText") == true {
            onOffSwitch.setOn(true, animated: true)
        }
        else {
            onOffSwitch.setOn(false, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerViewOutlet.dataSource = self
        self.pickerViewOutlet.delegate = self
        
        let fontFamilyNames = UIFont.familyNames()
        for familyName in fontFamilyNames {
            self.fonts.append(familyName)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if self.selectedPicker == 1 {
            self.pickerArray = backColors
        }
        else if self.selectedPicker == 2 {
            self.pickerArray = textColors
        }
        else if self.selectedPicker == 3 {
            self.pickerArray = fonts
        }
        
        return self.pickerArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row] as? String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.selectedPicker == 1 {
            self.colorName = "\(backColors[row].lowercaseString)Color"
            defaults.setValue(colorName, forKey: "BackgroundColor")
            defaults.synchronize()
            self.currentBackColor.text = defaults.stringForKey("BackgroundColor")
        }
        else if self.selectedPicker == 2 {
            self.colorName = "\(textColors[row].lowercaseString)Color"
            defaults.setValue(colorName, forKey: "TextColor")
            defaults.synchronize()
            self.currentTextColor.text = defaults.stringForKey("TextColor")

        }
        else if self.selectedPicker == 3 {
            let font = fonts[row]
            defaults.setValue(font, forKey: "FontFamily")
            defaults.synchronize()
            self.currentFont.text = defaults.stringForKey("FontFamily")
        }
        
    }

}
