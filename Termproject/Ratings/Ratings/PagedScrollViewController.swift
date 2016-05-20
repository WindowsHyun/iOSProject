//
//  PagedScrollViewController.swift
//  ScrollViews
//
//  Created by kpugame on 2016. 4. 26..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class PagedScrollViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    //1페이지마다 1개 이미지를 갖는 UIIamge 배열
    var pageImages: [UIImage] = []
    //UIImageView 배열로써 optional임, 왜냐하면 필요할 떄 로딩하므로!
    var pageViews: [UIImageView?] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. 5개 photo로부터 UIImage 배열생성
        pageImages = [UIImage(named: "photo1.png")!,
            UIImage(named: "photo2.png")!,
            UIImage(named: "photo3.png")!,
            UIImage(named: "photo4.png")!,
            UIImage(named: "photo5.png")!]
        
        let pageCount = pageImages.count
        
        //2. 현재 페이지는 0으로 설정하고 페이지 개수 설정
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        
        //3. 페이지 개수 만큼 pageView 배열 원소를 nil로 생성
        //나중에 로딩할 때 실제 pageImages에서 가져옴
        for _ in 0..<pageCount{
            pageViews.append(nil)
        }
        
        //4. 스크롤뷰 컨텐트 width = 스크롤뷰 프레임 width x pageImage 개수
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count)
            , height: pagesScrollViewSize.height)
        
        //5. 이미지 로딩
        loadVisiblePages()
    }
  
    func loadPage(page: Int)
    {
        if page < 0 || page >= pageImages.count {
            //페이지 인덱스 범위를 벗어나면 그냥 리턴!
            return
        }
        
        //1. 초기에 pageViews 배열은 nil로 이루어져 있는데, nil이 아니라면 로딩이 된 것이므로
        //아무 할일 없음
        if let pageView = pageViews[page] {
            
        } else {
            //2. pageView가 nil이면 로딩해야 함
            //y오프셋은 0이고 x 오프셋은 화면너비*페이지인댁스로 설정
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            //3. 새로운 UIIamgeView생성하고 scrollView에 추가
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            
            //4. 새로 생성한 newPageView를 배열의 nil 대신 삽입
            pageViews[page] = newPageView
        }
    }
    
    //현재 페이지 앞뒤를 제외하고 나머지는 pageViews 배열에서 제거할 것임
    func purgePage(page: Int){
        if page < 0 || page >= pageImages.count{
            //페이지 인덱스 범위를 벗어난 경우
            return
        }
        
        //pageView[page]가 nil이 아니면 scrollView에서 제거하고
        //pageView[page]는 nill로 만듦
        if let pageView = pageViews[page]{
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    
    //현재페이지와 앞 뒤 페이지만 로딩하고 나머지는 메모리에서 제거 purge
    func loadVisiblePages()
    {
        //현재 페이지 번호 계산
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        //pageControl 현재 페이지 갱싱
        pageControl.currentPage = page
        
        //현재 페이지 앞뒤 페이지 설정
        let firstPage = page - 1
        let lastPage = page + 1
        
        //페이지 0..< 앞페이지 전까지 제거
        for var index = 0; index < firstPage; ++index{
            purgePage(index)
        }
        
        //앞, 현재, 뒤 3개 페이지만 로딩
        for index in firstPage...lastPage{
            loadPage(index)
        }
        
        //뒤페이지<..<끝페이지까지 제거
        for var index = lastPage + 1; index < pageImages.count; ++index{
            purgePage(index)
        }
    }
    
    //UIScrollViewDelegate메소드
    func scrollViewDidScroll(scrollView: UIScrollView!){
        loadVisiblePages()
    }

}
