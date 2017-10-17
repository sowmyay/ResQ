//
//  HTTPServiceProvider.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/15/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HTTPServiceProvider{

    static let sharedInstance = HTTPServiceProvider()
    
    func submitJSON(_ json:[String : AnyObject], url:String, httpMethod:String, success:@escaping (_ response:AnyObject)->Void, failure:@escaping (_ error:Any)->Void){

        //let passURL = "virtserver.swaggerhub.com/resQ/test/1.0.0/pet/findByStatus"
        print("URL:- \(url) \nHttpMethod:- \(httpMethod) \nRequest:- \(json)")
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        let AFrequest = Alamofire.request(url, method: (httpMethod == "POST" ? .post : .get), parameters: json, encoding: URLEncoding.methodDependent, headers: headers)
        
        AFrequest.responseJSON { (response) in
            print(response)
            do{
                switch response.result {
                case .success(let data):
//                    let json = JSON(data)
                    print(response.result.value )
                    success(response.result.value as AnyObject)
                case .failure(let error):
                    failure(error)
                }
            }catch{
                failure("ERROR")
            }
           
        }
    }

//    func sendAuthInHeader(json:[String:AnyObject]) -> (json: [String:AnyObject], auth: String?){
//        var modifiedJSON = json
//        if let sendAuthInHeader = modifiedJSON["auth_in_header"] as? Bool, sendAuthInHeader{
//            if let auth = modifiedJSON["auth_token"] as? String{
//                modifiedJSON.removeValue(forKey: "auth_token")
//                modifiedJSON.removeValue(forKey: "auth_in_header")
//                return (modifiedJSON, auth)
//            }
//        }
//        return (modifiedJSON, nil)
//    }
//
//    fileprivate func getParameterGetString(_ parameters:[String:AnyObject]) -> String {
//        var getString = String()
//        getString.append("?")
//        for (key,value) in parameters {
//            getString.append("&\(key)=\(value)")
//        }
//        return getString
//    }
}
