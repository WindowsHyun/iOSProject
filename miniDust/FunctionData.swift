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
    
    private init() {
        self.FirstLocation = "경기"
        self.SecondLocation = "시흥시"
        self.ThirdLocation = "정왕동"
    }
}

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

func UTF8Encode(name: String) -> String {
    
    return name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
}