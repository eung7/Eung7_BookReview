//
//  ReviewWritePresenter.swift
//  Eung7_BookReview
//
//  Created by 김응철 on 2022/04/03.
//

import Foundation

protocol ReviewWriteProtocol {
    func setupNavigationBar()
    func showCloseAlertSheet()
    func dismissReviewWriteVC()
    func presentToSearchBookVC()
    func setupViews()
    func updateViews(title : String, imageURL : URL?)
}

class ReviewWritePresenter {
    
    private let viewController : ReviewWriteProtocol
    private let userDefaultsManager = UserDefaultsManager()
    private var book : Book?
    
    let contentsTextViewPlaceHolder = "내용을 입력해주세요."
    
    init(viewController : ReviewWriteProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
    
    func didTapCloseBarButton() {
        viewController.showCloseAlertSheet()
    }
    
    func didTapSaveBarButton(contentsText : String?) {
        guard let book = book,
              contentsText != contentsTextViewPlaceHolder
        else { return }
        
        let bookReview = BookReview(
            title: book.title,
            contents: contentsText ?? "",
            imageURL: book.imageURL
        )
        userDefaultsManager.setReviews(bookReview)
        viewController.dismissReviewWriteVC()
    }
    
    func didTapBookTitleButton() { 
        viewController.presentToSearchBookVC()
    }
}

extension ReviewWritePresenter : SearchBookDelegate {
    
    func sendBook(_ book: Book) {
        self.book = book
        viewController.updateViews(title: book.title, imageURL: book.imageURL)
    }
}
