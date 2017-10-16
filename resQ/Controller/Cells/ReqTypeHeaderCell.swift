//
//  ReqTypeHeaderCell.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/15/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

protocol ReqHeaderDelegate:class {
    func chooseTouched()
}
class ReqTypeHeaderCell: UITableViewCell {

    var delegate: ReqHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func chooseTouch(_ sender: Any) {
        self.delegate?.chooseTouched()
    }
}
