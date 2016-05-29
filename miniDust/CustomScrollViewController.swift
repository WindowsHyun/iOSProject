//
//  CustomScrollViewController.swift
//  ScrollViews
//
//  Created by kpugame on 2016. 4. 26..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class CustomScrollViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var scrollView: UIScrollView!
    
    var containerView: UIView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //4가지 뷰를 가지는 컨테이너뷰 생성
        let containerSize = CGSize(width: 640.0, height: 640.0)
        containerView = UIView(frame: CGRect(origin: CGPoint(x: 0, y:0), size:containerSize))
        scrollView.addSubview(containerView)
        
        //redView는 상단에 빨간색 가로막대
        let redView = UIView(frame: CGRect(x: 0, y:0, width: 640, height: 80))
        redView.backgroundColor = UIColor.redColor();
        containerView.addSubview(redView)
        //blueView는 하단의 파란색 가로 막대
        let blueView = UIView(frame: CGRect(x: 0, y:560, width: 640, height: 80))
        blueView.backgroundColor = UIColor.blueColor();
        containerView.addSubview(blueView)
        //greenView는 가운데 녹색 정사각형
        let greenView = UIView(frame: CGRect(x: 160, y : 160, width: 320, height: 320))
        greenView.backgroundColor = UIColor.greenColor();
        containerView.addSubview(greenView)
        //imageView는 slow.png로 만들고 가운데 위치
        let imageView = UIImageView(image: UIImage(named: "slow.png"))
        imageView.center = CGPoint(x: 320, y: 320);
        containerView.addSubview(imageView)
        
        //스크롤뷰 크기는 컨테이너뷰 크기(640, 640)으로 설정
        scrollView.contentSize = containerSize;
        
        //minimum & maximum 줌 스케일 설정
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        //초기 zoomScale은 maximumZoomScale = 1.0으로 설정
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = 1.0
        
        centerScrollViewContents()
    }
    
    
    //컨테이너뷰를 화면 가운데 오도록 설정
    //imageView 대신에 containerView로 변경하고 나머지 동일
    func centerScrollViewContents(){
        let boundsSize = scrollView.bounds.size
        var contentsFrame = containerView.frame
        if contentsFrame.size.width < boundsSize.width{
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        containerView.frame = contentsFrame
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return containerView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }
}

