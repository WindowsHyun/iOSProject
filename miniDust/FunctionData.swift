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
    var WGS84_x :Double
    var WGS84_y :Double
    var TM_x : Double
    var TM_y : Double
    
    private init() {
        self.FirstLocation = "경기"
        self.SecondLocation = "시흥시"
        self.ThirdLocation = "정왕동"
        self.WGS84_x = 0.0
        self.WGS84_y = 0.0
        self.TM_x = 0.0
        self.TM_y = 0.0
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
    
    func beginParsing(url : String, motherData : String, ChildData : String) -> String{
        posts = []
        motherValue = motherData
        ChildValue = ChildData
        parser = NSXMLParser(contentsOfURL: (NSURL(string:url))!)!
        parser.delegate = self
        parser.parse()
        if ( posts.count != 0){
            returnData = posts.objectAtIndex(0).valueForKey(ChildValue) as! NSString as String
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