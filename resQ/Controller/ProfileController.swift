//
//  ProfileController.swift
//  ResQ
//
//  Created by sowmya yellapragada on 10/8/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class ProfileController: BaseController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var editBttn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTxtFld: PaddingTextField!
    @IBOutlet weak var phoneTxtFld: PaddingTextField!
    @IBOutlet weak var popUpView: UIView!
    
    private let refreshControl = UIRefreshControl()
    var list = [HelpListing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDeviceSpecific()
        nameTxtFld.text = Singleton.instance.name
        phoneTxtFld.text = Singleton.instance.phone
        titleLbl.text = Singleton.instance.name
        editBttn.layer.borderColor = UIColor.white.cgColor
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 44.0
        
        let tapper = UITapGestureRecognizer(target: self, action:#selector(dismissFilter))
        tapper.cancelsTouchesInView = false
        popUpView.addGestureRecognizer(tapper)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red: 235/255.0, green: 59/255.0, blue: 41/255.0, alpha: 1.0)
    }
    
    @objc private func refresh(_ sender: Any) {
        getDeviceSpecific()
    }
    
    @IBAction func editProfileTouch(_ sender: Any) {
        self.popUpView.isHidden = false
        
        self.view.bringSubview(toFront: popUpView)
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        self.popUpView.isHidden = true
        UIApplication.shared.sendAction(#selector(UIView.endEditing(_:)), to:nil, from:nil, for:nil)
        if let name = nameTxtFld.text, let phone = phoneTxtFld.text{
            Singleton.instance.name = name
            Singleton.instance.phone = phone
            titleLbl.text = name
        }
    }
    
    @objc func dismissFilter(){
        UIApplication.shared.sendAction(#selector(UIView.endEditing(_:)), to:nil, from:nil, for:nil)
        popUpView.isHidden = true
    }
    
    func getDeviceSpecific(){
        let req = GetDeviceReqRequest()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        showLoadingIndicator()
        RequestSender().sendRequest(req, success: { (response) in
            self.hideLoadingIndicator()
            self.refreshControl.endRefreshing()
            let listResponse = response as! GetDeviceReqResponse
            self.list = listResponse.list
            self.tableView.reloadData()
        }) { (error) in
            self.hideLoadingIndicator()
            self.refreshControl.endRefreshing()
            print("\nError in get help list call :")
            print(error)
            print("\n")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileRequestCell", for: indexPath) as! RequestListCell
        cell.config(request: list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileHeaderCell") as! RequestHeaderCell
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReqDetailsController") as! ReqDetailsController
        vc.config(help: list[indexPath.row])
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
