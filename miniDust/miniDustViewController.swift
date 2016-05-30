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
    @IBOutlet var khailValue : UILabel!
    @IBOutlet weak var so2Value: UILabel!
    @IBOutlet weak var coValue: UILabel!
    @IBOutlet weak var no2Value: UILabel!
    @IBOutlet weak var o3Value: UILabel!
    @IBOutlet weak var pm10Value24Data: UILabel!
    
    @IBAction func refeshBtn(sender: UIButton) {
        print("갱신 버튼을 클릭했다!")
        pm10Update()
    }
    
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
    var parsingTime = NSMutableString()
    var parsingKhaiValue = NSMutableString()
    var parsingso2Value = NSMutableString()
    var parsingcoValue = NSMutableString()
    var parsingno2Value = NSMutableString()
    var parsingo3Value = NSMutableString()
    var parsingpm10Value24Data = NSMutableString()
    var noDataValue = false
    //-----------------------------------------------------------------------------
    
    let LocationData = MyLocation.sharedInstance
    
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
            parsingTime = NSMutableString()
            parsingTime = ""
            parsingKhaiValue = NSMutableString()
            parsingKhaiValue = ""
            parsingso2Value = NSMutableString()
            parsingso2Value = ""
            parsingcoValue = NSMutableString()
            parsingcoValue = ""
            parsingno2Value = NSMutableString()
            parsingno2Value = ""
            parsingo3Value = NSMutableString()
            parsingo3Value = ""
            parsingpm10Value24Data = NSMutableString()
            parsingpm10Value24Data = ""
            
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!){
        if element.isEqualToString("dataTime"){
            parsingTime.appendString(string)
        }
        if element.isEqualToString("khaiValue"){
            parsingKhaiValue.appendString(string)
        }
        if element.isEqualToString("pm10Value"){
            parsingpm10Value24Data.appendString(string)
        }
        if element.isEqualToString("o3Value"){
            parsingo3Value.appendString(string)
        }
        if element.isEqualToString("no2Value"){
            parsingno2Value.appendString(string)
        }
        if element.isEqualToString("coValue"){
            parsingcoValue.appendString(string)
        }
        if element.isEqualToString("so2Value"){
            parsingso2Value.appendString(string)
        }
    }
    
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!,namespaceURI: String!, qualifiedName qName: String!){
        if(elementName as NSString).isEqualToString("item"){
            if !parsingTime.isEqual(nil){
                elements.setObject(parsingTime, forKey: "dataTime")
            }
            if !parsingKhaiValue.isEqual(nil){
                elements.setObject(parsingKhaiValue, forKey: "khaiValue")
            }
            if !parsingpm10Value24Data.isEqual(nil){
                elements.setObject(parsingpm10Value24Data, forKey: "pm10Value")
            }
            if !parsingo3Value.isEqual(nil){
                elements.setObject(parsingo3Value, forKey: "o3Value")
            }
            if !parsingno2Value.isEqual(nil){
                elements.setObject(parsingno2Value, forKey: "no2Value")
            }
            if !parsingcoValue.isEqual(nil){
                elements.setObject(parsingcoValue, forKey: "coValue")
            }
            if !parsingso2Value.isEqual(nil){
                elements.setObject(parsingso2Value, forKey: "so2Value")
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
        // 시간값을 가져와 dataTime에 넣어준다.
            
        var khai = posts.objectAtIndex(0).valueForKey("khaiValue") as! NSString as String
        khai = khai.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        khailValue.text = "통합지수 : " + String(khai) + String("㎍/㎥")
        // 통합지수를 가져와서 뿌려주는데 통합지수 뒤에 공백과 줄구분이 있어 문자열 자르기를 이요하여 자른후 붙어넣기 한다.
            
        var pm10 = posts.objectAtIndex(0).valueForKey("pm10Value") as! NSString as String
        pm10 = pm10.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        pm10Value24Data.text = String(pm10) + String("㎍/㎥")
            
        var o3 = posts.objectAtIndex(0).valueForKey("o3Value") as! NSString as String
        o3 = o3.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        o3Value.text = String(o3) + String("ppm")
            
        var no2 = posts.objectAtIndex(0).valueForKey("no2Value") as! NSString as String
        no2 = no2.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        no2Value.text = String(no2) + String("ppm")
            
        var co = posts.objectAtIndex(0).valueForKey("coValue") as! NSString as String
        co = co.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        coValue.text = String(co) + String("ppm")
            
        var so2 = posts.objectAtIndex(0).valueForKey("so2Value") as! NSString as String
        so2 = so2.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        so2Value.text = String(so2) + String("ppm")
            
        print("파싱 데이터를 뿌림.")
        }else{
        print("No Data")
        dataTime.text = "No Data"
        khailValue.text = "통합지수 : " + "-" + String("㎍/㎥")
        pm10Value24Data.text = "-" + String("㎍/㎥")
        o3Value.text = "-" + String("ppm")
        no2Value.text = "-" + String("ppm")
        coValue.text = "-" + String("ppm")
        so2Value.text = "-" + String("ppm")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "update", userInfo: nil, repeats: true)
        var pm10Timer = NSTimer.scheduledTimerWithTimeInterval(3600.0, target: self, selector: "pm10Update", userInfo: nil, repeats: true)
        pm10Update()
        
        
        
        
        var urlstring = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty?ServiceKey=agRTEvpQv1bNvtoPQr3DNvE5juZ9EAws47JkmLbQnf4OYYAXw%2FAh9TULJtGxrEBzqH2767koxGlukyRTjweQcg%3D%3D&numOfRows=999&pageSize=999&pageNo=1&startPage=1&sidoName=%EA%B2%BD%EA%B8%B0"
        var url = NSURL(string: urlstring)
        var postData:String = ""
        var request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData.dataUsingEncoding(NSUTF8StringEncoding)
        var connection = NSURLConnection(request: request, delegate: nil, startImmediately: true)
        
        print(request.HTTPBody)
        
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
