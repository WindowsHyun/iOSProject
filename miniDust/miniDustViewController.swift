//
//  miniDustViewController.swift
//  miniDust
//
//  Created by HyunWindows on 2016. 5. 28..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class miniDustViewController: UIViewController {

    @IBOutlet var myLabel : UILabel!
    
    var LocationData = MyLocation.sharedInstance
    
    var firstLocationData = ""
    var secondLocationData = ""
    var thirdLocationData = ""
    
    func update() {
        // Something cool
        myLabel.text = LocationData.FirstLocation + " " + LocationData.SecondLocation + " " + LocationData.ThirdLocation
        print("언제 불러오나?")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "update", userInfo: nil, repeats: true)
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
