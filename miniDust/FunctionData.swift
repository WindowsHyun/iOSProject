//
//  FunctionData.swift
//  miniDust
//
//  Created by HyunWindows on 2016. 5. 28..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import Foundation

struct myLocation {
    static var FirstLocation = ""
}

func UTF8Encode(name: String) -> String {
    
    return name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
}