//
//  miniDustViewController.swift
//  miniDust
//
//  Created by HyunWindows on 2016. 5. 28..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class miniDustViewController: UIViewController, NSXMLParserDelegate {

    @IBOutlet var myLocation : UILabel!
    @IBOutlet var dataTime : UILabel!
    //-----------------------------------------------------------------------------
    // 파싱을 위한 변수 만들기
    @IBOutlet weak var tbData: UITableView!
    // xml 파일을 다운로드 및 파싱하는 오브젝트
    var parser = NSXMLParser()
    // feed 데이터를 저장하는 mutable array
    var posts = NSMutableArray()
    // title과 date 같은 feed데이터를 저장하는 mutable dictionary
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var noDataValue = false
    //-----------------------------------------------------------------------------
    
    let LocationData = MyLocation.sharedInstance
    let pm10Information = pm10Data.sharedInstance
    
    var encodeName:String = ""
    
    func beginParsing(){
        posts = []
        encodeName = UTF8Encode(LocationData.ThirdLocation)
        parser = NSXMLParser(contentsOfURL: (NSURL(string:"http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?ServiceKey=0XhuR6MWTmnuwV8IZ3UntOteG%2BqKHXdHVDCtFHQu3Y67n4Wwwuc6zCOj%2Bk0TrBN6bvqswhm2BtIvs6sP8%2FQruA%3D%3D&numOfRows=10&pageSize=10&pageNo=1&startPage=1&stationName=\(encodeName)&dataTerm=DAILY"))!)!
        parser.delegate = self
        parser.parse()
    }
    
    func parser(parser:NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,
                attributes attributeDict: [String : String]) {
        element = elementName
        if(elementName as NSString).isEqualToString("item"){
            noDataValue = true
            // element 가 item이면 아래를 실행
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!){
        if element.isEqualToString("dataTime"){
            title1.appendString(string)
        }
    }
    
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!,namespaceURI: String!, qualifiedName qName: String!){
        if(elementName as NSString).isEqualToString("item"){
            if !title1.isEqual(nil){
                elements.setObject(title1, forKey: "dataTime")
            }
            posts.addObject(elements)
        }
        
    }
    
    
    
    func update() {
        // 실시간으로 위치조회의 데이터를 받아온다.
        myLocation.text = "현재 위치 : " + LocationData.FirstLocation + " " + LocationData.SecondLocation + " " + LocationData.ThirdLocation
    }
    
    func pm10Update() {
        // 실시간으로 초미세먼지 데이터를 받아온다.
        beginParsing()
        print("파싱을 시작함..!")
        if ( posts.count != 0){
        // 파싱한 데이터가 있을경우에만 작성해준다..!
        dataTime.text = posts.objectAtIndex(0).valueForKey("dataTime") as! NSString as String
        print("파싱 데이터를 뿌림.")
        }else{
        print("No Data")
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "update", userInfo: nil, repeats: true)
        //var pm10Timer = NSTimer.scheduledTimerWithTimeInterval(600.0, target: self, selector: "pm10Update", userInfo: nil, repeats: true)
        pm10Update()
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
