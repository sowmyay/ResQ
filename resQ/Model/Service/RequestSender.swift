//
//  RequestSender.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/15/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class RequestSender{
    
    let requestList:[BaseRequest.Type] = [TestRequest.self,
                                          ReqListRequest.self,
                                          CreateRequest.self,
                                          AddCommentRequest.self,
                                          GetDetailsRequest.self,
                                          LocationsRequest.self,
                                          RespondRequest.self,
                                          GetDeviceReqRequest.self]
    let handlerList:[BaseHandler.Type] = [TestHandler.self,
                                          ReqListHandler.self,
                                          CreateHandler.self,
                                          AddCommentHandler.self,
                                          GetDetailsHandler.self,
                                          LocationsHandler.self,
                                          RespondHandler.self,
                                          GetDeviceReqHandler.self]

    func sendRequest(_ request:BaseRequest, success:@escaping (_ response:BaseResponse)->Void, failure:@escaping (_ error:Any)->Void) {
        
        let handlerType:BaseHandler.Type = self.getHandler(request)
        
        let handlerClass    = handlerType.init()
        let url             = handlerClass.getURL(request)
        let dict            = handlerClass.constructDictionary(request)
        let httpMethod      = handlerClass.getHTTPMethod(request)
        
        HTTPServiceProvider.sharedInstance.submitJSON(dict, url: url, httpMethod: httpMethod, success: { (response) in
            let responseObject = handlerClass.parser(response)
            success(responseObject!)
        }){ (error) in
            failure(error)
        }
    }
    
    func getHandler(_ request:BaseRequest) -> BaseHandler.Type {
        var index = 0
        for item in requestList {
            if (item === type(of: request)) {break}
            else {index += 1}
        }
        return handlerList[index]
    }
}
