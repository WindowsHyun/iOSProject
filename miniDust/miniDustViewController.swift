//
//  miniDustViewController.swift
//  miniDust
//
//  Created by HyunWindows on 2016. 5. 28..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit


class miniDustViewController: UIViewController, NSXMLParserDelegate {
    
    @IBOutlet weak var totalDust: UIImageView!
    @IBOutlet weak var pm10Dust: UIImageView!
    @IBOutlet weak var o3Dust: UIImageView!
    @IBOutlet weak var no2Dust: UIImageView!
    @IBOutlet weak var coDust: UIImageView!
    @IBOutlet weak var so2Dust: UIImageView!
    @IBOutlet var myLocation : UILabel!
    @IBOutlet var nearLocation: UILabel!
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
    var siteURL:String = ""
    var encodeName:String = ""
    var noDataValue = false
    var test:String = ""
    //-----------------------------------------------------------------------------
    
    let LocationData = MyLocation.sharedInstance
    let GetParsing = parsingData()
    
    func update() {
        // 실시간으로 위치조회의 데이터를 받아온다.
        myLocation.text = "현재 위치 : " + LocationData.FirstLocation + " " + LocationData.SecondLocation + " " + LocationData.ThirdLocation
    }
    
    func pm10Update() {
        
        if ( LocationData.notAutoLocation == false){
            //---------------------------------------------------------------------------------------------------
            // 자동 위치가 아닌 수동위치일경우 활성화 하지 않는다.
            print("GPS위치를 이용하여 현재가 어디 동인지까지 찾는다..!")
            siteURL = "https://apis.daum.net/local/geo/coord2addr?apikey=d8807fd4a736291f4878c3cd37d8612d&inputCoordSystem=WGS84&y=\(LocationData.WGS84_x)&x=\(LocationData.WGS84_y)&output=xml"
            let recData:String = WebParsing(siteURL)
            
            // GPS 위치를 다음API를 이용해서 해당 위치가 무슨시 무슨구 무슨동인지 알아오게 한다.
            LocationData.FirstLocation = SplitString(recData, first: "' code2", last: "name1='")
            LocationData.SecondLocation = SplitString(recData, first: "' code3", last: "name2='")
            LocationData.ThirdLocation = SplitString(recData, first: "' x=", last: "name3='")
            //---------------------------------------------------------------------------------------------------
            
            print("파싱을 시작전 현재 위치를 기준으로 가까운 위치를 찾는다..!")
            siteURL = "http://openapi.airkorea.or.kr/openapi/services/rest/MsrstnInfoInqireSvc/getNearbyMsrstnList?ServiceKey=agRTEvpQv1bNvtoPQr3DNvE5juZ9EAws47JkmLbQnf4OYYAXw%2FAh9TULJtGxrEBzqH2767koxGlukyRTjweQcg%3D%3D&tmX=\(LocationData.TM_x)&tmY=\(LocationData.TM_y)&numOfRows=999&pageSize=999&pageNo=1&startPage=1"
            // TM좌표를 통해서 현재위치 에서 가장 가까운 측정소를 반환해준다.
            
            let nearAir = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "stationName", DataNum: 0)
            LocationData.NearLocation = String(nearAir)
            //---------------------------------------------------------------------------------------------------
        }else{
            //---------------------------------------------------------------------------------------------------
            // 수동 위치일경우 해당 위치를 찾아야 한다.
            let selectLocation = "\(LocationData.FirstLocation) \(LocationData.SecondLocation) \(LocationData.ThirdLocation)"
            encodeName = UTF8Encode(selectLocation)
            siteURL = "https://apis.daum.net/local/geo/addr2coord?apikey=d8807fd4a736291f4878c3cd37d8612d&q=\(encodeName)&output%20=xml"
            let ws_x = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "point_x", DataNum: 0)
            let ws_y = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "point_y", DataNum: 0)
            // 해당 위치를 다음API를 이용하여 위경도를 가져온다.
            
            let recData:String = WebParsing("https://apis.daum.net/local/geo/transcoord?apikey=d8807fd4a736291f4878c3cd37d8612d&fromCoord=WGS84&y=\(ws_y)&x=\(ws_x)&toCoord=TM&output=xml")
            LocationData.TM_x = Double(SplitString(recData, first: "' y", last: "x='"))!
            LocationData.TM_y = Double(SplitString(recData, first: "' />", last: "y='"))!
            // 다음API를 이용하여 TM 좌표계를 받아온다.
            
            siteURL = "http://openapi.airkorea.or.kr/openapi/services/rest/MsrstnInfoInqireSvc/getNearbyMsrstnList?ServiceKey=agRTEvpQv1bNvtoPQr3DNvE5juZ9EAws47JkmLbQnf4OYYAXw%2FAh9TULJtGxrEBzqH2767koxGlukyRTjweQcg%3D%3D&tmX=\(LocationData.TM_x)&tmY=\(LocationData.TM_y)&numOfRows=999&pageSize=999&pageNo=1&startPage=1"
            let nearAir = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "stationName", DataNum: 0)
            LocationData.NearLocation = String(nearAir)
            // TM좌표를 통해서 현재위치 에서 가장 가까운 측정소를 반환해준다.
            //---------------------------------------------------------------------------------------------------
        }
        nearLocation.text = "측정소 : (\(LocationData.NearLocation))"
        
        
        print("이제 파싱을 시작한다..!")
        encodeName = UTF8Encode(LocationData.NearLocation)
        siteURL = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?ServiceKey=0XhuR6MWTmnuwV8IZ3UntOteG%2BqKHXdHVDCtFHQu3Y67n4Wwwuc6zCOj%2Bk0TrBN6bvqswhm2BtIvs6sP8%2FQruA%3D%3D&numOfRows=10&pageSize=10&pageNo=1&startPage=1&stationName=\(encodeName)&dataTerm=DAILY"
        // 파싱을 하기위한 URL등을 미리 입력해주어 중복된 값들을 하나로 통일 시킨다.
        dataTime.text = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "dataTime", DataNum: 0)
        let khailValueData = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "khaiValue", DataNum: 0)
        let pm10ValueData = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "pm10Value", DataNum: 0)
        let o3ValueData = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "o3Value", DataNum: 0)
        let no2ValueData = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "no2Value", DataNum: 0)
        let coValueData = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "coValue", DataNum: 0)
        let so2ValueData = GetParsing.beginParsing(siteURL, motherData: "item", ChildData: "so2Value", DataNum: 0)
        
        khailValue.text = "통합지수 : " + khailValueData + String("㎍/㎥")
        totalDust.image = UIImage(named: (imageName("khaiValue", value: Double(khailValueData)!) + ".png"))

        let rgbvalue:Int = Int(imageName("khaiValue", value: Double(khailValueData)!))!
        if (rgbvalue == 0){
            self.view.backgroundColor = UIColor.init(colorLiteralRed: 0.14, green: 0.69, blue: 0.96, alpha: 1)
        }
        if (rgbvalue == 1){
            self.view.backgroundColor = UIColor.init(colorLiteralRed: 0.03, green: 0.85, blue: 0.03, alpha: 1)
        }
        if (rgbvalue == 2){
            self.view.backgroundColor = UIColor.init(colorLiteralRed: 1, green: 0.85, blue: 0, alpha: 1)
        }
        if (rgbvalue == 3){
            self.view.backgroundColor = UIColor.init(colorLiteralRed: 1, green: 0.32, blue: 0, alpha: 1)
        }
        if (rgbvalue == 4){
            self.view.backgroundColor = UIColor.init(colorLiteralRed: 1, green: 0, blue: 0, alpha: 1)
        }
        // 아 벡터로 받아와서 하려다가 그냥 수작업...
        
        
        pm10Value24Data.text = pm10ValueData + String("㎍/㎥")
        pm10Dust.image = UIImage(named: (imageName("pm10Value24", value: Double(pm10ValueData)!) + ".png"))
        
        o3Value.text = o3ValueData + String("ppm")
        o3Dust.image = UIImage(named: (imageName("o3Value", value: Double(o3ValueData)!) + ".png"))
        
        no2Value.text = no2ValueData + String("ppm")
        no2Dust.image = UIImage(named: (imageName("no2Value", value: Double(no2ValueData)!) + ".png"))
        
        coValue.text = coValueData + String("ppm")
        coDust.image = UIImage(named: (imageName("coValue", value: Double(coValueData)!) + ".png"))
        
        so2Value.text = so2ValueData + String("ppm")
        so2Dust.image = UIImage(named: (imageName("so2Value", value: Double(so2ValueData)!) + ".png"))
        print("파싱 데이터를 뿌림.")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recData:String = WebParsing("https://apis.daum.net/local/geo/transcoord?apikey=d8807fd4a736291f4878c3cd37d8612d&fromCoord=WGS84&y=\(LocationData.WGS84_x)&x=\(LocationData.WGS84_y)&toCoord=TM&output=xml")
        
        LocationData.TM_x = Double(SplitString(recData, first: "' y", last: "x='"))!
        LocationData.TM_y = Double(SplitString(recData, first: "' />", last: "y='"))!
        print("TM 좌표 : " + String(LocationData.TM_x) + ", " + String(LocationData.TM_y) )
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "update", userInfo: nil, repeats: true)
        let pm10Timer = NSTimer.scheduledTimerWithTimeInterval(3600.0, target: self, selector: "pm10Update", userInfo: nil, repeats: true)
        pm10Update()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
