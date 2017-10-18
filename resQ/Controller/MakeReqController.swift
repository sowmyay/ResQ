//
//  MakeReqController.swift
//  ResQ
//
//  Created by sowmya yellapragada on 10/8/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class MakeReqController: BaseController, UITextFieldDelegate, PHTextViewDelegate, UITableViewDelegate, UITableViewDataSource, ReqHeaderDelegate {

    var heightIncreased:Bool = false
    var reqTypes = ["Evacuation", "Food", "Medication", "Other"]
    var reqImages = ["shelter", "add", "add", "add"]
    var selectedReq = -1
    @IBOutlet weak var chooseBttn: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameTxtFld: PaddingTextField!
    @IBOutlet weak var subTxtFld: PaddingTextField!
    @IBOutlet weak var contentTxtView: PlaceHolderTextView!
    @IBOutlet weak var reqTypeTableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popUpView.isHidden = true
        self.tableHeight.constant = CGFloat(45*1 + 44 * reqTypes.count)
        NotificationCenter.default.addObserver(self, selector: #selector(MakeReqController.keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MakeReqController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
        NotificationCenter.default.removeObserver(NSNotification.Name.UIKeyboardDidShow)
        NotificationCenter.default.removeObserver(NSNotification.Name.UIKeyboardWillHide)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postTouch(_ sender: Any) {
        if validityCheck(){
            postRequest()
        }
    }
    
    @IBAction func chooseTouch(_ sender: Any) {
        self.popUpView.isHidden = false
        self.view.bringSubview(toFront: popUpView)
        
    }
    
    func chooseTouched() {
         self.popUpView.isHidden = true
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if !heightIncreased{
                heightIncreased = true
                self.bottomConstraint.constant += keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if heightIncreased{
                heightIncreased = false
                self.bottomConstraint.constant -= keyboardSize.height
            }
        }
    }
    
    func phTextViewDidEndEditing() {
        
    }
    
    func phTextViewShouldBeginEditing() {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reqTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reqTypeCell", for: indexPath) as! ReqTypeSelectCell
        cell.config(title: reqTypes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reqHeaderCell") as! ReqTypeHeaderCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedReq = indexPath.row
        self.popUpView.isHidden = true
        chooseBttn.titleLabel?.text = reqTypes[selectedReq]
        chooseBttn.imageView?.image = UIImage(named: reqImages[selectedReq])
    }
    
    func validityCheck() -> Bool{
        var status = 0
        if let _ = nameTxtFld.text{
            status += 1
        }
        if let _ = subTxtFld{
            status += 1
        }
        if let text = contentTxtView.text, text != contentTxtView.placeholder{
            status += 1
        }
        
        return (status == 3 ? true : false)
    }
    
    func postRequest(){
        let name = nameTxtFld.text!
        let subject = subTxtFld.text!
        let desc = contentTxtView.text!
        let create = CreateRequest(lat: 124.0, lng: -57.0, reqType: true, name: name, subject: subject, desc: desc)
        RequestSender().sendRequest(create, success: { (response) in
            let alert = UIAlertController(title: "Request Posted", message: "Please await help!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive, handler: { (action) in
                
            })
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }) { (error) in
            print(error)
        }
    }

}
