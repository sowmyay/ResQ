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
    
    func config(request:HelpListing){
        titleLbl.text     = request.subject
        descLbl.text      = request.description
        if let status = request.status{
            switch  status{
            case 0:
                statusLbl.text    = "Unassigned"
                statusLbl.textColor = UIColor(red: 235/255.0, green: 59/255.0, blue: 41/255.0, alpha: 1.0)
            case 1:
                statusLbl.text    = "Assigned to Red Cross"
                statusLbl.textColor = UIColor(red: 68/255.0, green: 155/255.0, blue: 77/255.0, alpha: 1.0)
            default:
                statusLbl.text    = "Completed"
                statusLbl.textColor = UIColor.gray
            }
        }
        
        locLbl.text       = request.loc
        timeSinceLbl.text = request.createdAt
        typeLbl.text      = request.resource.map { $0.rawValue }
    }
    
    func config(title:String, desc:String, status:Int, loc:String, timeSince:String, type:String){
        titleLbl.text     = title
        descLbl.text      = desc
        switch status {
        case 0:
            statusLbl.text    = "Unassigned"
            statusLbl.textColor = UIColor(red: 235/255.0, green: 59/255.0, blue: 41/255.0, alpha: 1.0)
        case 1:
            statusLbl.text    = "Assigned to Red Cross"
            statusLbl.textColor = UIColor(red: 68/255.0, green: 155/255.0, blue: 77/255.0, alpha: 1.0)
        default:
            statusLbl.text    = "Completed"
            statusLbl.textColor = UIColor.gray
        }
        
        locLbl.text       = loc
        timeSinceLbl.text = timeSince
        typeLbl.text      = type
    }
    
    
    
}
