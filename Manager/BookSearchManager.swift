//
//  BookSearchManager.swift
//  Eung7_BookReview
//
//  Created by 김응철 on 2022/04/03.
//

import Foundation
import Alamofire

struct BookSearchManager {
    func request(from keyword : String, completionHandler : @escaping ([Book]) -> Void) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/book.json") else { return }
        
        let parameters = BookSearchRequestModel(query: keyword)
        
        // ID : OEVjFIrvWUYMXPYGibPs
        // PW : nHYyTuXM1F
        
        let headers : HTTPHeaders = [
            "X-Naver-Client-Id" : "OEVjFIrvWUYMXPYGibPs",
            "X-Naver-Client-Secret" : "nHYyTuXM1F"
        ]
        
        AF
            .request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: BookSearchResponseModel.self) { response in
                switch response.result {
                case .failure(let err) :
                    print("\(err.localizedDescription)")
                case .success(let result) :
                    completionHandler(result.items)
                }
            }
            .resume()
    }
}


