//
//  BookSearchRequestModel.swift
//  Eung7_BookReview
//
//  Created by 김응철 on 2022/04/03.
//

import Foundation

struct BookSearchRequestModel : Codable {
    
    /// 검색할 책 키워드
    let query : String
}
