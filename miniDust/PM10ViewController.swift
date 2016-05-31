//
//  PM10ViewController.swift
//  miniDust
//
//  Created by HyunWindows on 2016. 6. 1..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class PM10ViewController: UIViewController {

    @IBOutlet weak var pm10Image: UIImageView!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var informOverall: UITextView!
    @IBOutlet weak var informCause: UITextView!
    @IBOutlet weak var informGrade: UITextView!
    @IBOutlet weak var refreshBtn: UIButton!
    
    @IBAction func refreshBtn(sender: UIButton) {
        pm10DataUpdate()
    }
    
    
    let GetParsing = parsingData()
    
    var imageRange:Int = 0
    var imageData = ["", "", ""]
    
    func pm10ImageUpdate() {
        if let url = NSURL(string: imageData[imageRange]) {
            if let data = NSData(contentsOfURL: url) {
                pm10Image.image = UIImage(data: data)
            }
        }
        // 이미지를 NSData에 받아와서 그 데이터를 이미지에 뿌려준다.
        
        imageRange += 1
        
        if ( imageRange >= 3){
            imageRange = 0
        }
    }
    
    func pm10DataUpdate(){
        
        var todaysDate:NSDate = NSDate()
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var todayString:String = dateFormatter.stringFromDate(todaysDate)
        // 현재의 날짜를 yyyy-MM-dd 로 받아온다.
        let siteURL:String = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMinuDustFrcstDspth?ServiceKey=agRTEvpQv1bNvtoPQr3DNvE5juZ9EAws47JkmLbQnf4OYYAXw%2FAh9TULJtGxrEBzqH2767koxGlukyRTjweQcg%3D%3D&numOfRows=10&pageSize=10&pageNo=1&startPage=1&searchDate=\(todayString)&informCode=pm10"
        
        todayDate.text = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "dataTime", DataNum: 0)
        informOverall.text = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "informOverall", DataNum: 0)
        informCause.text = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "informCause", DataNum: 0)
        informGrade.text = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "informGrade", DataNum: 0).replace(",", withString:", ")
        imageData[0] = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "imageUrl1", DataNum: 1)
        imageData[1] = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "imageUrl2", DataNum: 1)
        imageData[2] = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "imageUrl3", DataNum: 1)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        pm10DataUpdate()
        
        pm10ImageUpdate()
        let pm10ImgaeTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "pm10ImageUpdate", userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
