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


class parsingData{
    var parser = NSXMLParser()
    // feed 데이터를 저장하는 mutable array
    var posts = NSMutableArray()
    // title과 date 같은 feed데이터를 저장하는 mutable dictionary
}




/*
class pm10Data {
    static let sharedInstance = pm10Data()
    var dateTime: String
    var so2Value: String
    var coValue: String
    var o3Value: String
    var no2Value: String
    var pm10Value: String
    var khaiValue: String
    
    private init() {
        self.dateTime = ""
        self.so2Value = ""
        self.coValue = ""
        self.o3Value = ""
        self.no2Value = ""
        self.pm10Value = ""
        self.khaiValue = ""
    }
}
*/
func UTF8Encode(name: String) -> String {
    
    return name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
}