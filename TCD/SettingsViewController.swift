//
//  SettingsViewController.swift
//  TCD
//
//  Created by Gregg Mojica on 5/2/15.
//  Copyright (c) 2015 Gregg Mojica. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var slider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()

        var vc = StatusObject()
        vc.updateStatus()
        
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()

        var color = UIColor(red:0.31, green:0.68, blue:0.81, alpha:1.0)
    
        NSUserDefaults.standardUserDefaults().floatForKey("sliderValue")
    
        
       // self.navigationController?.navigationBar.tintColor = color
        

        var nav = self.navigationController?.navigationBar
        // 2
        nav?.barStyle = UIBarStyle.Black
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func save(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setFloat(self.slider.value, forKey: "sliderValue")
        NSUserDefaults.standardUserDefaults().synchronize()

        
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
