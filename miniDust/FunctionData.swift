//
//  FunctionData.swift
//  miniDust
//
//  Created by HyunWindows on 2016. 5. 28..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import Foundation

class MyLocation {
    static let sharedInstance = MyLocation()
    var FirstLocation: String
    var SecondLocation: String
    var ThirdLocation: String
    var NearLocation: String
    var WGS84_x :Double
    var WGS84_y :Double
    var TM_x : Double
    var TM_y : Double
    var notAutoLocation : Bool
    
    private init() {
        self.FirstLocation = ""
        self.SecondLocation = ""
        self.ThirdLocation = ""
        self.NearLocation = ""
        self.WGS84_x = 0.0
        self.WGS84_y = 0.0
        self.TM_x = 0.0
        self.TM_y = 0.0
        self.notAutoLocation = false
    }
}


class parsingData: NSObject, NSXMLParserDelegate{
    var parser = NSXMLParser()
    // feed 데이터를 저장하는 mutable array
    var posts = NSMutableArray()
    // title과 date 같은 feed데이터를 저장하는 mutable dictionary
    var elements = NSMutableDictionary()
    var element = NSString()
    var parsingData = NSMutableString()
    var noDataValue = false
    var motherValue: String = ""
    var ChildValue: String = ""
    var returnData:String = ""
    
    func beginParsing(url : String, motherData : String, ChildData : String, DataNum : Int) -> String{
        posts = []
        motherValue = motherData
        ChildValue = ChildData
        parser = NSXMLParser(contentsOfURL: (NSURL(string:url))!)!
        parser.delegate = self
        parser.parse()
        if ( posts.count != 0){
            returnData = posts.objectAtIndex(DataNum).valueForKey(ChildValue) as! NSString as String
            returnData = returnData.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            return returnData
        }else{
            return "-"
        }
    }
    
    
    func parser(parser:NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,
                attributes attributeDict: [String : String]) {
        element = elementName
        if(elementName as NSString).isEqualToString(motherValue){
            noDataValue = true
            // element 가 item이면 아래를 실행
            elements = NSMutableDictionary()
            elements = [:]
            parsingData = NSMutableString()
            parsingData = ""
            
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!){
        if element.isEqualToString(ChildValue){
            parsingData.appendString(string)
        }
    }
    
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!,namespaceURI: String!, qualifiedName qName: String!){
        if(elementName as NSString).isEqualToString(motherValue){
            if !parsingData.isEqual(nil){
                elements.setObject(parsingData, forKey: ChildValue)
            }
            posts.addObject(elements)
        }
        
    }
    
}


func SplitString(data: String, first : String, last : String) -> String {
    let firstSplit = data.componentsSeparatedByString(first)
    let lastSplit = firstSplit[0].componentsSeparatedByString(last)
    return String(lastSplit[1])
}

func WebParsing(url : String) -> String {
    /*
     비동기식 파싱을 하면 로딩 중에 사용을 할수 있다 하지만
     비동기식으로 할경우 reguest값을 추출해낼수가 없다?
     그래서 동기식으로 작업을 한다.
     */
    let url = NSURL(string: url)
    let cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
    var request = NSMutableURLRequest(URL: url!, cachePolicy: cachePolicy, timeoutInterval: 2.0)
    request.HTTPMethod = "GET"
    // set data
    var dataString = ""
    let requestBodyData = (dataString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
    request.HTTPBody = requestBodyData
    
    var response: NSURLResponse? = nil
    var reponseError: NSError?
    var reply:NSData?
    
    do {
        reply = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
    } catch let error as NSError {
        reponseError = error
        reply = nil
    }
    
    let results = NSString(data:reply!, encoding:NSUTF8StringEncoding) as! String
    if (reply != nil){
        return results.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
    }else{
        return "-"
    }
}


func UTF8Encode(name: String) -> String {
    return name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
}


func returnRGB(value: Int)-> Array<Int>{
    var rgbList = []
    if (value == 0){
        rgbList = [0, 162, 232]
    }
    if (value == 1){
        rgbList = [34, 177, 76]
    }
    if (value == 2){
        rgbList = [255, 127, 39]
    }
    if (value == 3){
        rgbList = [207, 78, 78]
    }
    if (value == 4){
        rgbList = [255, 0, 0]
    }
    
    return rgbList as! Array<Int>
}


func imageName(selectData : String, value: Double)-> String{
    var khaiValue = [0, 50, 100, 210, 250, 999]
    var pm10Value24 = [0, 30, 80, 110, 150, 999]
    var o3Value = [0, 0.03, 0.09, 0.11, 0.15, 999]
    var no2Value = [0, 0.03, 0.06, 0.1, 0.2, 999]
    var coValue = [0, 2, 9, 11, 15, 999]
    var so2Value = [0, 0.02, 0.05, 0.11, 0.15, 999]
    
    for var index = 0; index < 5; index += 1 {
        if (selectData == "khaiValue"){
            if ( Double(khaiValue[index]) <= Double(value) && Double(value) <= Double(khaiValue[index+1]) ){
                return String(index)
            }
        }
        if (selectData == "pm10Value24"){
            if ( Double(pm10Value24[index]) <= Double(value) && Double(value) <= Double(pm10Value24[index+1]) ){
                return String(index)
            }
        }
        if (selectData == "o3Value"){
            if ( Double(o3Value[index]) <= Double(value) && Double(value) <= Double(o3Value[index+1]) ){
                return String(index)
            }
        }
        if (selectData == "no2Value"){
            if ( Double(no2Value[index]) <= Double(value) && Double(value) <= Double(no2Value[index+1]) ){
                return String(index)
            }
        }
        if (selectData == "coValue"){
            if ( Double(coValue[index]) <= Double(value) && Double(value) <= Double(coValue[index+1]) ){
                return String(index)
            }
        }
        if (selectData == "so2Value"){
            if ( Double(so2Value[index]) <= Double(value) && Double(value) <= Double(so2Value[index+1]) ){
                return String(index)
            }
        }
        
    }
    
    return "0.png"
}

extension String
{
    func replace(target: String, withString: String) -> String
    {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
}
