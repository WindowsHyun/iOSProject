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
        self.FirstLocation = ""
        self.SecondLocation = ""
        self.ThirdLocation = ""
    }
}

func UTF8Encode(name: String) -> String {
    
    return name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
}