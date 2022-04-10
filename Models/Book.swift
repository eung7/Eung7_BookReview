//
//  Book.swift
//  Eung7_BookReview
//
//  Created by 김응철 on 2022/04/03.
//

import Foundation

struct Book : Decodable {
    let title : String
    private let image : String?
    
    var imageURL : URL? {
        return URL(string: image ?? "")
    }
}

