//
//  LocationSearchTableViewController.swift
//  miniDust
//
//  Created by HyunWindows on 2016. 5. 28..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class ThirdLocationTableViewController: UITableViewController, NSXMLParserDelegate {
    
    @IBOutlet weak var tbData: UITableView!
    // xml 파일을 다운로드 및 파싱하는 오브젝트
    var parser = NSXMLParser()
    // feed 데이터를 저장하는 mutable array
    var posts = NSMutableArray()
    // title과 date 같은 feed데이터를 저장하는 mutable dictionary
    let LocationData = MyLocation.sharedInstance
    // 싱글톤으로 제작하여 모든 스위프트에서 단일 변수로 만들기
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    
    var firstLocationData = ""
    var secondLocationData = ""
    var thirdLocationData = ""
    var encodeFirst:String = ""
    var encodeSecond:String = ""
    
    
    func beginParsing(){
        posts = []
        encodeFirst = UTF8Encode(firstLocationData)
        encodeSecond = UTF8Encode(secondLocationData)

        parser = NSXMLParser(contentsOfURL: (NSURL(string:"http://openapi.epost.go.kr/postal/retrieveLotNumberAdressService/retrieveLotNumberAdressService/getEupMyunDongList?ServiceKey=agRTEvpQv1bNvtoPQr3DNvE5juZ9EAws47JkmLbQnf4OYYAXw%2FAh9TULJtGxrEBzqH2767koxGlukyRTjweQcg%3D%3D&brtcCd=\(encodeFirst)&signguCd=\(encodeSecond)&numOfRows=999&pageSize=999&pageNo=1&startPage=1"))!)!
        parser.delegate = self
        parser.parse()
    }
    
    func parser(parser:NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,
                attributes attributeDict: [String : String]) {
        element = elementName
        if(elementName as NSString).isEqualToString("eupMyunDongList") // element 가 item이면 아래를 실행
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!){
        if element.isEqualToString("emdCd"){
            title1.appendString(string)
        }
    }
    
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!,namespaceURI: String!, qualifiedName qName: String!){
        if(elementName as NSString).isEqualToString("eupMyunDongList"){
            if !title1.isEqual(nil){
                elements.setObject(title1, forKey: "emdCd")
            }
            posts.addObject(elements)
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DataCell", forIndexPath: indexPath)
        cell.textLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("emdCd") as! NSString as String
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //테이블뷰 선택이 되었을때 나타나는 행동
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        let listText = "\(cell?.textLabel?.text as! NSString as String)"
        thirdLocationData = "\(listText)"
        print("전체 선택 : " + firstLocationData + " " + secondLocationData + " " + thirdLocationData)
        LocationData.ThirdLocation = thirdLocationData
    }
    
    
/*
     싱글톤 함수로 인하여 segue가 필요 없어짐.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "nextView"{
            let param = segue.destinationViewController as! miniDustViewController
            
            param.firstLocationData = firstLocationData
            param.secondLocationData = secondLocationData
            param.thirdLocationData = thirdLocationData
        }
    }
  */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
