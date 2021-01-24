//
//  WebService.swift
//  NeriaProject
//
//  Created by Neria Jerafi on 24/01/2021.
//

import Foundation

enum WebServiceError:Error {
    case internetError
}

struct WebService {
    static func getRequest<T:Decodable>(stringUrl:String, completionHandler:@escaping(Result<T,WebServiceError>)->()){
        guard let url = URL(string: stringUrl) else { return  }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let responseData = data {
                do{
                let decodeData = try JSONDecoder().decode(T.self, from: responseData)
                    completionHandler(.success(decodeData))
                }catch{
                    completionHandler(.failure(.internetError))
                }
            }else{
                completionHandler(.failure(.internetError))
            }
            
        }.resume()
    }
}
