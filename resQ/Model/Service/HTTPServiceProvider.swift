//
//  HTTPServiceProvider.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/15/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit
import Alamofire

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
            switch response.result {
            case .success( _):
                success(response.result.value as AnyObject)
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
