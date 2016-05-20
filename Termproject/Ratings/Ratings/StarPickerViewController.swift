//
//  StarPickerViewController.swift
//  Ratings
//
//  Created by kpugame on 2016. 4. 19..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class StarPickerViewController: UITableViewController {

    
    var stars:[Int] = [
    1,2,3,4,5]
    
    var rating:Int = 1
    
    //Lab5]
    //rating에 따라서 서로다른 별개수 이미지를 반환
    func imageForRating(rating:Int) -> UIImage? {
        let imageName = "\(rating)Stars"
        return UIImage(named: imageName)
    }
    
    
    //Lab5
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveSelectedStar" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(cell)
                if let index = indexPath?.row {
                    rating = stars[index]
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stars.count
    }

    
    //Lab5
    //row 선택되는 실행되는 delegate 메소드
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StarCell", forIndexPath: indexPath)
        if let ratingImageView = cell.viewWithTag(100) as? UIImageView{
            ratingImageView.image = self.imageForRating(indexPath.row + 1)
        }
        
        //현재 row가 선택된 게임이라면 Chekmark를 하라 코드추가
        if indexPath.row == (rating - 1){
            cell.accessoryType = .Checkmark
        }else {
            cell.accessoryType = .None
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //그전에 선택되었던 row는 checkmark를 해제함!!
        
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: rating - 1, inSection: 0))
        cell?.accessoryType = .None
        
        //row선택하면 즉시 그 row에 해당하는 games 배열의 스트링을 selectedGame에 저장
        rating = stars[indexPath.row]
        
        //선택된 row cell에 checkmark 함
        let cell2 = tableView.cellForRowAtIndexPath(indexPath)
        cell2?.accessoryType = .Checkmark
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
