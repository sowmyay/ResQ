//
//  RequestListCell.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/13/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class RequestListCell: UITableViewCell {

    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var locLbl: UILabel!
    @IBOutlet weak var timeSinceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(title:String, desc:String, status:String, loc:String, timeSince:String, type:String){
        titleLbl.text     = title
        descLbl.text      = desc
        statusLbl.text    = status
        locLbl.text       = loc
        timeSinceLbl.text = timeSince
        typeLbl.text      = type
    }

}
