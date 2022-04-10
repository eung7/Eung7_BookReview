//
//  BookSearchResponseModel.swift
//  Eung7_BookReview
//
//  Created by 김응철 on 2022/04/03.
//

import Foundation

struct BookSearchResponseModel : Decodable {
    var items : [Book] = []
}

