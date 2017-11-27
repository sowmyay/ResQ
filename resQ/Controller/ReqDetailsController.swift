//
//  ReqDetailsCOntroller.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/16/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class ReqDetailsController: BaseController, UITableViewDelegate, UITableViewDataSource, AddCommentDelegate, RespondDelegate {

    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    var listing:HelpListing?
    var showRespond:Bool = false{
        didSet{
            numberOfRows = showRespond ? comments.count + 2 : comments.count + 1
        }
    }
    var comments = [Comment](){
        didSet{
            numberOfRows = showRespond ? comments.count + 2 : comments.count + 1
        }
    }
    var commentsCount:Int = 0
    var viewCount:Int = 0
    var numberOfRows = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetails()
        tableView.estimatedSectionHeaderHeight = 100.0
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red: 235/255.0, green: 59/255.0, blue: 41/255.0, alpha: 1.0)
    }
    
    @objc private func refresh(_ sender: Any) {
        getDetails()
    }
    
    func config(help: HelpListing){
        self.listing = help
        if let status = help.status{
            if status == 0{
               showRespond = true
            }
        }else{
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
        numberOfRows = showRespond ? comments.count + 2 : comments.count + 1
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell") as! ReqDetailsCell
        cell.config(help: listing!, views: self.viewCount, comments: self.commentsCount)
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if showRespond && indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "respondCell", for: indexPath) as! RespondCell
            cell.delegate = self
            return cell
        }
        if (indexPath.row == numberOfRows - 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "addCommentCell", for: indexPath) as! AddCommentCell
            cell.delegate = self
            return cell
        }
        let identifier = (indexPath.row%2 == 1 ? "commentsCell" : "subCommentsCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CommentsCell
        cell.config(comment: comments[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if showRespond && indexPath.row == 1{
        }
        
    }
    
    func sendComment(comment:String?) {
        addComment(comment: comment)
    }
    
    func respond(){
        if let id = listing?.id{
            let request = RespondRequest(id: id)
            RequestSender().sendRequest(request, success: { (response) in
                let _  = response as! RespondResponse
                let alert = UIAlertController(title: "Thank you for Responding", message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .destructive, handler: { (action) in
                    self.getDetails()
                    self.showRespond = false
                    self.listing?.status = 1
                    
                })
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }) { (error) in
                print("Respond error")
            }
        }
    }
    
    func getDetails(){
        if let id = listing?.id{
            let request = GetDetailsRequest(requestID: id)
            RequestSender().sendRequest(request, success: { (response) in
                self.refreshControl.endRefreshing()
                let detailsResponse = response as! GetDetailsResponse
                self.comments = detailsResponse.comments
                self.commentsCount = detailsResponse.count ?? 0
                self.viewCount = detailsResponse.views ?? 0
                self.tableView.reloadData()
            }, failure: { (error) in
                self.refreshControl.endRefreshing()
                print(error)
            })
        }
    }
    
    func addComment(comment: String?){
        if let id = listing?.id, let c = comment{
            let request = AddCommentRequest(id: id, desc: c)
            RequestSender().sendRequest(request, success: { (response) in
                let _ = response as! AddCommentResponse
                self.getDetails()
                
            }, failure: { (error) in
                print("Add comment error")
            })
        }
    }
    
    
    
}
