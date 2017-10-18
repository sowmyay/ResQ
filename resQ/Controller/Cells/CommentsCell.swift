//
//  CommentsCell.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/17/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class CommentsCell: UITableViewCell {

    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var postedAtLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!

    @IBAction func replyTouch(_ sender: Any) {
    }
    
    func config(comment:Comment){
        if let id = comment.id{
            self.authorLbl.text = String(id)
        }
        self.postedAtLbl.text = comment.createdAt
        self.descLbl.text = comment.desc
    }
}
