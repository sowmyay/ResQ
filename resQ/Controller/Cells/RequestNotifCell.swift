//
//  RequestNotifCell.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/13/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit
protocol NotifCellDelegate {
    func dismissNotif()
    func notifClicked()
}

class RequestNotifCell: UITableViewCell {

    @IBOutlet weak var reqImage: UIImageView!
    @IBOutlet weak var reqTitleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    var delegate:NotifCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func closeTouch(_ sender: Any) {
        self.delegate?.dismissNotif()
    }
    
    @IBAction func findHelpTouch(_ sender: Any) {
        self.delegate?.notifClicked()
    }
}
