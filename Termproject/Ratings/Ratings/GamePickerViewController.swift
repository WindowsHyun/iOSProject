//
//  GamePickerViewController.swift
//  Ratings
//
//  Created by kpugame on 2016. 4. 19..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class GamePickerViewController: UITableViewController {

    //game 리스트 배열 하드코드
    var games:[String] = [
        "Angry birds",
        "Chees",
        "Russian Roulette",
        "Spin the bottle",
        "Texas Hold'em poker",
        "Tic-Tac-Toe"
    ]
    
    
    //game을 선택하고 back버튼을 눌렀을때 그 값을 저장했다가 보내기 위해서 변수 선언
    //selectedGame이 변경되면 games 배열에서 인덱스를 가져옴
    var selectedGame:String? {
        didSet {
            if let game = selectedGame {
                selectedGameIndex = games.indexOf(game)
            }
        }
    }
    
    var selectedGameIndex:Int?
    
    //row 선택되면 selectedGame을 update하는 tableView(:didSelectRowAtIndexPath)가
    //실행되기 전에 unwind segue가 실행되므로
    //selectedGame을 unwind 전에 update해야함!!!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveSelectedGame" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(cell)
                if let index = indexPath?.row {
                    selectedGame = games[index]
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //Section은 1개
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //row의 개수는 games 배열 원소의 개수
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return games.count
    }
    
    //row 선택되는 실행되는 delegate 메소드
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //그전에 선택되었던 row는 checkmark를 해제함
        if let index = selectedGameIndex
        {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.accessoryType = .None
        }
        
        //row선택하면 즉시 그 row에 해당하는 games 배열의 스트링을 selectedGame에 저장
        selectedGame = games[indexPath.row]
        
        //선택죈 row cell에 checkmark 함
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
    }

    //table view cell은 "GameCell" id를 가지며, 타이틀은 games 배열에서 꺼내서 설정
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath)
        cell.textLabel?.text = games[indexPath.row]
        //현재 row가 선택된 게임이라면 Checkmark를 하라 코드추가
        if indexPath.row == selectedGameIndex
        {
            cell.accessoryType = .Checkmark
        }
        else
        {
            cell.accessoryType = .None
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
