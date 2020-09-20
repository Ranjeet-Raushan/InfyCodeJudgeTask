//  InfyTaskClient.swift
//  InfyCodeJudgeTask
//  Created by Ranjeet Raushan on 20/09/20.
//  Copyright © 2020 Ranjeet Raushan. All rights reserved.


import Foundation
import Alamofire
import SwiftyJSON

enum Result {
    case success(JSON,String)
    case failure(Error)
}
final class InfyTaskClient {
    static let shared = InfyTaskClient()
    private init() {
    }
    
    func hitService(withBodyData data: [String: Any],toEndPoint url: String,using httpMethod: HTTPMethod,dueToAction requestType: String,completion: @escaping (Result) -> Void){
        print("EndPoint = \(url)"); print("BodyData = \(data)");print("Action = \(requestType)")
        var header = [String:String]()
        if (UserDefaults.standard.object(forKey: "access_token") as? String) != nil
        {
            header = ["Content-Type": "application/json","Authorization":"Bearer \(UserDefaults.standard.object(forKey: "access_token") as? String ?? "")"]

        }else
        {
            header = ["Content-Type": "application/json"]

        }
    

        Alamofire.request(url, method: httpMethod, parameters: data.isEmpty ? nil: data, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            switch(response.result) {
            case .success(let value):
                print("Response = \(value)")
                completion(Result.success(JSON(value),requestType))
                break
            case .failure(let error):
                print("Failure : \(response.result.error!)")
                print("let error : \(error.localizedDescription)")
                completion(Result.failure(error))
                break
            }
        }
    }
}
