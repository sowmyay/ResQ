//
//  RequestsListController.swift
//  ResQ
//
//  Created by sowmya yellapragada on 10/8/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class RequestsListController: BaseController, UITableViewDelegate, UITableViewDataSource, MakeReqDelegate {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var titles = ["Need help getting out!!", "Requesting food and water at our place", "Requesting Shelter", "Need help getting out!!", "Requesting food and water at our place"]
    var content = ["Trying to get to the shelter but we are currently trapped inside our house. Can someone please come and get us out of here? We are terrified and hungry.", "We're at the shelter at Sandy Springs. We need some food and water for the family. Could anyone help us? There are 5 members in our family and we have a 4 months old son.", "Trying to get to the shelter but we are currently trapped inside our house. Can someone please come and get us out of here? We are terrified and hungry.", "Trying to get to the shelter but we are currently trapped inside our house. Can someone please come and get us out of here? We are terrified and hungry.", "We're at the shelter at Sandy Springs. We need some food and water for the family. Could anyone help us? There are 5 members in our family and we have a 4 months old son."]
    var locations = ["3380 Peachtree Rd NE, Atlanta", "3380 Peachtree Rd NE, Atlanta", "3380 Peachtree Rd NE, Atlanta", "3380 Peachtree Rd NE, Atlanta", "3380 Peachtree Rd NE, Atlanta"]
    var status = [0, 1, 2, 3, 3]
    var timeSince = ["Just now", "1h", "1h", "2h", "3h"]
    var types = ["Evacuation", "Food", "Evacuation", "Evacuation", "Food"]
    
    var list = [HelpListing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllRequests()
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
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "reqNotifCell", for: indexPath) as! RequestNotifCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell", for: indexPath) as! RequestListCell
       
        let index = indexPath.row-1
        cell.config(request: list[index])
       // cell.config(title: titles[index], desc: content[index], status: status[index], loc: locations[index], timeSince: timeSince[index], type: types[index])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count + 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reqHeaderCell") as! RequestHeaderCell
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 49
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0{
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReqDetailsController") as! ReqDetailsController
            vc.config(help: list[indexPath.row - 1])
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func requestMade() {
        getAllRequests()
    }
    
    func getAllRequests(){
        let lat = 123.0
        let lng = -56.0
        let listRequest = ReqListRequest(lat: lat, lon: lng)
        RequestSender().sendRequest(listRequest, success: { (response) in
            let listResponse = response as! ReqListResponse
            self.list = listResponse.list
            self.tableView.reloadData()
        }) { (error) in
            print("\nError in get help list call :")
            print(error)
            print("\n")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MakeRequest"{
            let vc = segue.destination as! MakeReqController
            vc.delegate = self
        }
    }
    

}
