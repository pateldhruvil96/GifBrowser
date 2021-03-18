//
//  ServerRequest.swift
//  GifBrowser
//
//  Created by Dhruvil Patel on 3/16/21.
//

import Foundation
import Alamofire
class ServerRequest: NSObject {
    
    class func postcall(url : URL, httpMethod : HTTPMethod, params : [String: Any]?,completion:@escaping (_ success: [String:Any]?,_ failure : Error?)->()) {
      //  let deviceToken = UserDefaults.standard.value(forKey: USERIDTOKEN) as? String ?? ""
//        let authorization = "Bearer " + deviceToken
        let headers: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept": "application/json",
//            "Authorization":authorization
        ]
        AF.request(url, method:httpMethod , parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
            
            switch response.result{
            case .success(let value):
                guard let jsonDict = value as? [String:Any] else {
                    completion(nil,errors.unKnown)
                    return
                }
                completion(jsonDict,nil)
                break
                
            case .failure( _):
                if response.response?.statusCode == errors.Unauthorised.rawValue{
                    completion(nil,errors.Unauthorised)
                }else if response.response?.statusCode == errors.Unavilable.rawValue{
                    completion(nil,errors.Unavilable)
                }else{
                    completion(nil,errors.unKnown)
                }
                break
            }
        }
    }
    enum errors: Int, Error {
        case Unauthorised = 401
        case OkResponse = 200
        case Unavilable = 404
        case unKnown
    }
    struct ApiEndPoints {
        static let version = "v1"
        static let gif = "gifs"
        static let type = "trending"
    }
}
