//
//  ReqDetailsCell.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/17/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit
import Alamofire

class ReqDetailsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{

    var images:NSArray?{
        didSet{
            if let imgArray = images, imgArray.count > 0{
                collectionViewHeight.constant = 100.0
                collectionView.isHidden = true
                self.collectionView.reloadData()
            }else{
                collectionViewHeight.constant = 0
                collectionView.isHidden = false
            }
        }
    }
    
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var postedAtLbl: UILabel!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var viewsLbl: UILabel!
    @IBOutlet weak var commentsLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func shareTouch(_ sender: Any) {
        
    }
    
    @IBAction func commentsTouch(_ sender: Any) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = images?.count{
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCVCell
        if let imgArray = images, let imageURL = URL(string:imgArray[indexPath.row] as! String){
            cell.imageView.af_setImage(withURL: imageURL)
        }
        return cell
    }
    
    func config(help:HelpListing, views:Int, comments:Int){
        self.images = help.images
        titleLbl.text     = help.subject
        detailsLbl.text      = help.description
        if let status = help.status{
            switch  status{
            case 0:
                statusLbl.text    = "Unassigned"
                statusLbl.textColor = UIColor(red: 235/255.0, green: 59/255.0, blue: 41/255.0, alpha: 1.0)
            case 1:
                statusLbl.text    = "Assigned to Volunteer"
                statusLbl.textColor = UIColor(red: 68/255.0, green: 155/255.0, blue: 77/255.0, alpha: 1.0)
            default:
                statusLbl.text    = "Completed"
                statusLbl.textColor = UIColor.gray
            }
        }else{
            statusLbl.text    = "Unassigned"
            statusLbl.textColor = UIColor(red: 235/255.0, green: 59/255.0, blue: 41/255.0, alpha: 1.0)
        }
        
        locationLbl.text       = help.loc
        postedAtLbl.text = help.createdAt
        typeLbl.text      = help.resource.map { $0.rawValue }
        viewsLbl.text = String(views) + " views"
        commentsLbl.text = String(comments) + " comments"
        authorLbl.text = help.author
    
    }
}
