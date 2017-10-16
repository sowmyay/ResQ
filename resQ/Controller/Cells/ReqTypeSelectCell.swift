//
//  ReqTypeSelectCell.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/15/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class ReqTypeSelectCell: UITableViewCell {

    @IBOutlet weak var reqLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(title:String){
        reqLbl.text = title
    }
}
