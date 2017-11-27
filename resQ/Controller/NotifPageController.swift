//
//  NotifPageController.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/29/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class NotifPageController: BaseController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var isNotifsView:Bool = true
    var pageIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier = "NewCommentCell"
        if isNotifsView{
            identifier = "NewMessageCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! NotifCell
        return cell
    }
}
