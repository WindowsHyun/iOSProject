//
//  ScrollViewContainer.swift
//  ScrollViews
//
//  Created by kpugame on 2016. 4. 28..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class ScrollViewContainer: UIView {
    //페이지 바깥을 눌러도 페이지가 변하도록 넓은 scrollView를 만들고
    @IBOutlet var scrollView: UIScrollView!
    //스크롤뷰 컴테이너 바운드 안을 누르기만 하면 스크롤뷰 리턴 함!
    override func hitTest(point: CGPoint, withEvent event: UIEvent!)->UIView?{
        let view = super.hitTest(point, withEvent: event)
        if let theView = view{
            if theView == self{
                return scrollView
            }
        }
        
        return view
    }
   
}
