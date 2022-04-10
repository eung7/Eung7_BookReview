//
//  UserDefaultsManager.swift
//  Eung7_BookReview
//
//  Created by 김응철 on 2022/04/03.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func getReviews() -> [BookReview]
    func setReviews(_ newValue : BookReview)
}

struct UserDefaultsManager : UserDefaultsManagerProtocol {
    enum Key : String {
        case review
    }
    
    func getReviews() -> [BookReview] {
        guard let data = UserDefaults.standard.data(forKey: Key.review.rawValue) else { return [] }
        return (try? PropertyListDecoder().decode([BookReview].self, from: data)) ?? []
        
    }
    
    func setReviews(_ newValue: BookReview) {
        var currentReviews : [BookReview] = getReviews()
        currentReviews.insert(newValue, at: 0)
        
        UserDefaults.standard.setValue(
            try? PropertyListEncoder().encode(currentReviews),
            forKey: Key.review.rawValue
        )
    }
}
