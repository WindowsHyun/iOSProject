//
//  PlayerDetailsViewController.swift
//  Ratings
//
//  Created by kpugame on 2016. 4. 14..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class PlayerDetailsViewController: UITableViewController {

    //Done 버튼을 누르면 입력한 새로운 Player 프라퍼티를 저장할 수 있도록 변수 선언
    var player:Player?
    
    //선택된 게임 이름 저장하는 변수, 디폴트 = "Chess"
    var game:String = "Chess" {
        didSet{
            detailLabel.text? = game
        }
    }
    
    //Lab 5
    //선택된 별점 개수를 저장하는 변수 디폴트 = 1
    //rating 변수가 변하면 ratingImageView 변경함
    var rating:Int = 1{
        didSet{
            ratingImageView.image? = imageForRating(rating)!
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    @IBAction func viewTapped(sender : AnyObject) {
        nameTextField.resignFirstResponder()
    }

    
    //Lab5
    //rating에 따라서 서로다른 별개수 이미지를 반환
    func imageForRating(rating:Int) -> UIImage? {
        let imageName = "\(rating)Stars"
        return UIImage(named: imageName)
    }
    
    //Lab5
    //GamePickerViewController에서 game을 선택하면 실행
    
    @IBAction func unwindWithSelectedStar(segue:UIStoryboardSegue){
        if let starPickerViewController = segue.sourceViewController as? StarPickerViewController{
            rating = starPickerViewController.rating
        }
    }
    
    //GamePickerViewController에서 game을 선택하면 실행되는 unwind segue 메소드
    //선택된 게임으로 game 변수 변경
    @IBAction func unwindWithSelectedGame(segue:UIStoryboardSegue) {
        if let gamePickerViewController = segue.sourceViewController as? GamePickerViewController,
        selectedGame = gamePickerViewController.selectedGame {
            game = selectedGame
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Lab5
        ratingImageView.image = imageForRating(rating)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0
        {
            nameTextField.becomeFirstResponder()
        }
    }
    
    //prepareForSegue메소드는 segue 실행될 때 호출되는 메소르
    //id를 SavePlayerDetail로 설정
    //새로운 Player를 name과 "Chess", rating = 1로 생성
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SavePlayerDetail" {
            player = Player(name: nameTextField.text!, game: game, rating: rating)
        }
        
        //게임을 다른걸로 다시 선택하고 싶다면 이전 선택했던 것이 checkmark되어 있어야함
        if segue.identifier == "PickGame" {
            if let gamePickerViewController = segue.destinationViewController as? GamePickerViewController {
                gamePickerViewController.selectedGame = game
            }
        }
        
        //Lab5
        //별점을 다른걸로 다시 선택하고 싶다면 이전 선택했던 것이 checkmark되어 있어야함
        if segue.identifier == "PickStar" {
        if let starPickerViewController = segue.destinationViewController as? StarPickerViewController{
            starPickerViewController.rating = rating
            }
        }
    }
    
    
    //init와 deinit을 override해서 add player view가 언제 메모리에 allocate 되는지 알 수 있다.
    //실제로 + 버튼을 누른 다음에 initialize되고 cancel 혹은 Done버튼을 누르면 메모리가 해제 된다.
    //콘솔창에 출력함!!
    required init?(coder aDecoder: NSCoder)
    {
        print("init PlayerDetailViewController")
        super.init(coder: aDecoder)
    }
    
    deinit
    {
        print("deinit PlayerDetailsViewController")
    }

}
