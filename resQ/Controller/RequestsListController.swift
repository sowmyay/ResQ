//
//  RequestsListController.swift
//  ResQ
//
//  Created by sowmya yellapragada on 10/8/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class RequestsListController: BaseController, UITableViewDelegate, UITableViewDataSource, MakeReqDelegate, NotifCellDelegate {

    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var titles = ["Need help getting out!!", "Requesting food and water at our place", "Requesting Shelter", "Need help getting out!!", "Requesting food and water at our place"]
    var content = ["Trying to get to the shelter but we are currently trapped inside our house. Can sovarne please come and get us out of here? We are terrified and hungry.", "We're at the shelter at Sandy Springs. We need some food and water for the family. Could anyone help us? There are 5 members in our family and we have a 4 months old son.", "Trying to get to the shelter but we are currently trapped inside our house. Can someone please come and get us out of here? We are terrified and hungry.", "Trying to get to the shelter but we are currently trapped inside our house. Can someone please come and get us out of here? We are terrified and hungry.", "We're at the shelter at Sandy Springs. We need some food and water for the family. Could anyone help us? There are 5 members in our family and we have a 4 months old son."]
    var locations = ["3380 Peachtree Rd NE, Atlanta", "3380 Peachtree Rd NE, Atlanta", "3380 Peachtree Rd NE, Atlanta", "3380 Peachtree Rd NE, Atlanta", "3380 Peachtree Rd NE, Atlanta"]
    var status = [0, 1, 2, 3, 3]
    var timeSince = ["Just now", "1h", "1h", "2h", "3h"]
    var types = ["Evacuation", "Food", "Evacuation", "Evacuation", "Food"]
    var showNotifCell:Bool = true
    
    var list = [HelpListing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllRequests()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red: 235/255.0, green: 59/255.0, blue: 41/255.0, alpha: 1.0)
//        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing Data ...", attributes: nil)
        
    }

    @objc private func refresh(_ sender: Any) {
        getAllRequests()
    }
    
    @IBAction func writeTouch(_ sender: Any) {
    }
    
    @IBAction func searchTouch(_ sender: Any) {
    }
    
    //MARK:- Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "reqNotifCell", for: indexPath) as! RequestNotifCell
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell", for: indexPath) as! RequestListCell
        let index = indexPath.row-1
        cell.config(request: list[index])
//        if indexPath.row == (showNotifCell ? list.count + 1 : list.count) - 1{
//            let modified = list[index]
//            modified.status = 1
//            cell.config(request: modified)
//        }else{
//
//        }
        
       // cell.config(title: titles[index], desc: content[index], status: status[index], loc: locations[index], timeSince: timeSince[index], type: types[index])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (showNotifCell ? list.count + 1 : list.count)
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
//            if indexPath.row == (showNotifCell ? list.count + 1 : list.count) - 1{
//                let modified = self.list[indexPath.row - 1]
//                modified.status = 1
//                vc.config(help: modified)
//            }else{
//                vc.config(help: list[indexPath.row - 1])
//            }
//
    
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func requestMade() {
        getAllRequests()
    }
    
    func dismissNotif() {
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        showNotifCell = false
        tableView.endUpdates()
    }
    
    func notifClicked() {
        self.tabBarController?.selectedIndex = 0
    }
    
    func getAllRequests(){
        let lat = 44.0
        let lng = -93.0
        let listRequest = ReqListRequest(lat: lat, lon: lng)
        showLoadingIndicator()
        RequestSender().sendRequest(listRequest, success: { (response) in
            self.hideLoadingIndicator()
            self.refreshControl.endRefreshing()
            let listResponse = response as! ReqListResponse
            self.list = listResponse.list
            self.tableView.reloadData()
        }) { (error) in
            self.hideLoadingIndicator()
            self.refreshControl.endRefreshing()
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
