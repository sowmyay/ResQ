//
//  RespondCell.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/17/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit
protocol RespondDelegate {
    func respond()
}
class RespondCell: UITableViewCell {

    var delegate : RespondDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func respondTouch(_ sender: Any) {
        self.delegate?.respond()
    }
    
}
