//
//  PlayerViewController.swift
//  Ratings
//
//  Created by kpugame on 2016. 4. 12..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class PlayerViewController: UITableViewController {

    //player 변수는 Player 클래스 인스턴스 배열
    var players:[Player] = playersData
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Section은 1개
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Section의 row개수는 players 배열 원소 개수
        return players.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            //reuse identifier는 PlayerCell로 지정
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath)
            as! PlayerCell
            //indexPath는 (section, row)를 갖는다. Players배열에서 Player를 꺼내서 name, game을 title, subtitle로 지정
            let player = players[indexPath.row] as Player
            //cell.textLabel?.text = player.name
            //cell.detailTextLabel?.text = player.game
            cell.player = player
            return cell
    }
    
    //cancle 버튼을 누르면 동작
    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue)
    {
        if let PlayerDetailsViewController = segue.sourceViewController as? PlayerDetailsViewController
        {
            //새로운 player를 player 배열에 추가
            if let player = PlayerDetailsViewController.player
            {
                players.append(player)
                
                //새로운 row를 animation과 함께 추가
                let indexPath = NSIndexPath(forRow: players.count - 1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    
    //Done버튼을 누르면 동작
    @IBAction func savePlayerDetail(segue:UIStoryboardSegue)
    {
        if let PlayerDetailsViewController = segue.sourceViewController as? PlayerDetailsViewController
        {
            //새로운 player를 players 배열에 추가
            if let player = PlayerDetailsViewController.player
            {
                players.append(player)
                
                //새로운 row를 animation과 함께 추가
                let indexPath = NSIndexPath(forRow: players.count-1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
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
