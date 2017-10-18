//
//  ReqDetailsCOntroller.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/16/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class ReqDetailsController: BaseController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var listing:HelpListing?
    var showRespond:Bool = false
    var comments = [Comment]()
    var commentsCount:Int = 0
    var viewCount:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetails()
    }
    
    func config(help: HelpListing){
        self.listing = help
        if let status = help.status, status == 0{
            showRespond = true
        }
    }
    
    @IBAction func viewLocationTouch(_ sender: Any) {
    }
    
    @IBAction func bookmarkTouch(_ sender: Any) {
    }
    
    @IBAction func moreOptions(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showRespond ? comments.count + 2 : comments.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! ReqDetailsCell
            cell.config(help: listing!, views: self.viewCount, comments: self.commentsCount)
            return cell
        }
        if showRespond && indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "respondCell", for: indexPath) as! RespondCell
            return cell
        }
        let identifier = (indexPath.row%2 == 1 ? "commentsCell" : "subCommentsCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CommentsCell
        cell.config(comment: comments[indexPath.row - 1])
        return cell
    }
    
    func getDetails(){
        if let id = listing?.id{
            let request = GetDetailsRequest(requestID: id)
            RequestSender().sendRequest(request, success: { (response) in
                let detailsResponse = response as! GetDetailsResponse
                self.comments = detailsResponse.comments
                self.commentsCount = detailsResponse.count ?? 0
                self.viewCount = detailsResponse.views ?? 0
                self.tableView.reloadData()
            }, failure: { (error) in
                print(error)
            })
        }
        
    }
    
    
    
}
