//
//  RequestsListController.swift
//  ResQ
//
//  Created by sowmya yellapragada on 10/8/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class RequestsListController: BaseController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var titles = ["Need help getting out!!", "Requesting food and water at our place", "Requesting Shelter", "Need help getting out!!", "Requesting food and water at our place"]
    var content = ["Trying to get to the shelter but we are currently trapped inside our house. Can someone please come and get us out of here? We are terrified and hungry.", "We're at the shelter at Sandy Springs. We need some food and water for the family. Could anyone help us? There are 5 members in our family and we have a 4 months old son.", "Trying to get to the shelter but we are currently trapped inside our house. Can someone please come and get us out of here? We are terrified and hungry.", "Trying to get to the shelter but we are currently trapped inside our house. Can someone please come and get us out of here? We are terrified and hungry.", "We're at the shelter at Sandy Springs. We need some food and water for the family. Could anyone help us? There are 5 members in our family and we have a 4 months old son."]
    var locations = ["3380 Peachtree Rd NE, Atlanta", "3380 Peachtree Rd NE, Atlanta", "3380 Peachtree Rd NE, Atlanta", "3380 Peachtree Rd NE, Atlanta", "3380 Peachtree Rd NE, Atlanta"]
    var status = [0, 1, 2, 3, 3]
    var timeSince = ["Just now", "1h", "1h", "2h", "3h"]
    var types = ["Evacuation", "Food", "Evacuation", "Evacuation", "Food"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequest()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func writeTouch(_ sender: Any) {
    }
    
    @IBAction func searchTouch(_ sender: Any) {
    }
    
    //MARK:- Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let identifier = "requestCell"
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "reqNotifCell", for: indexPath) as! RequestNotifCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell", for: indexPath) as! RequestListCell
       
        let index = indexPath.row-1
        cell.config(title: titles[index], desc: content[index], status: status[index], loc: locations[index], timeSince: timeSince[index], type: types[index])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count + 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reqHeaderCell") as! RequestHeaderCell
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 49
    }
    
    func makeRequest(){
        let request = TestRequest()
        RequestSender().sendRequest(request, success: { (response) in
            print(response)
        }) { (error) in
            print(error)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
