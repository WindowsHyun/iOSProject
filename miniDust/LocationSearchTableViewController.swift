//
//  LocationSearchTableViewController.swift
//  miniDust
//
//  Created by HyunWindows on 2016. 5. 28..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class LocationSearchTableViewController: UITableViewController, NSXMLParserDelegate {

    @IBOutlet weak var tbData: UITableView!
    // xml 파일을 다운로드 및 파싱하는 오브젝트
    var parser = NSXMLParser()
    // feed 데이터를 저장하는 mutable array
    var posts = NSMutableArray()
    // title과 date 같은 feed데이터를 저장하는 mutable dictionary
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var send = myLocation()
    
    func beginParsing(){
        posts = []
        parser = NSXMLParser(contentsOfURL: (NSURL(string:"http://openapi.epost.go.kr/postal/retrieveLotNumberAdressService/retrieveLotNumberAdressService/getBorodCityList?ServiceKey=agRTEvpQv1bNvtoPQr3DNvE5juZ9EAws47JkmLbQnf4OYYAXw%2FAh9TULJtGxrEBzqH2767koxGlukyRTjweQcg%3D%3D&numOfRows=999&pageSize=999&pageNo=1&startPage=1"))!)!
        parser.delegate = self
        parser.parse()
        print(posts.count)
    }
    
    func parser(parser:NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,
                attributes attributeDict: [String : String]) {
        element = elementName
        if(elementName as NSString).isEqualToString("borodCity") // element 가 item이면 아래를 실행
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!){
        if element.isEqualToString("brtcNm"){
            title1.appendString(string)
        }
    }
    
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!,namespaceURI: String!, qualifiedName qName: String!){
        if(elementName as NSString).isEqualToString("borodCity"){
            if !title1.isEqual(nil){
                elements.setObject(title1, forKey: "brtcNm")
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
        cell.textLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("brtcNm") as! NSString as String
        

        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //테이블뷰 선택이 되었을때 나타나는 행동
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        let listText = "\(cell?.textLabel?.text as! NSString as String)"
        //print("선택한 위치는(List 선택 값) : \(listText)")
        //print("선택한 위치는(파싱 List 값) : \(posts.objectAtIndex(indexPath.row).valueForKey("brtcNm") as! NSString as String)")
        send.FirstLocation = "\(listText)"
        print(send.FirstLocation)
        
        

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // 오류 아직 미해결...
        // 데이터를 받은경우 그 데이터를 미세먼지 조회 레이블에 전달을 하게 하려 한다.
        // 하지만 그방법이 제대로 구현되지 않는다.
        var destViewController : miniDustViewController = segue.destinationViewController as! miniDustViewController
        destViewController.firstLocation = send.FirstLocation
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
