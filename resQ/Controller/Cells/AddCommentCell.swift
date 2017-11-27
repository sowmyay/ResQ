//
//  AddCommentCell.swift
//  resQ
//
//  Created by sowmya yellapragada on 11/15/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit
protocol AddCommentDelegate {
    func sendComment(comment:String?)
}
class AddCommentCell: UITableViewCell {

    @IBOutlet weak var txtFld: UITextField!
    var delegate: AddCommentDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func sendTouch(_ sender: Any) {
        self.delegate?.sendComment(comment: txtFld.text)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
