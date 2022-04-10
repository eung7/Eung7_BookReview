//
//  ReviewListPresenter.swift
//  Eung7_BookReview
//
//  Created by 김응철 on 2022/04/03.
//

import UIKit
import Kingfisher

protocol ReviewListProtocol  {
    func setupNavigationBar()
    func setupViews()
    func presentToReviewWriteVC()
    func reloadTableView()
}

class ReviewListPresenter : NSObject {
    
    private let viewController : ReviewListProtocol
    private let userDefaultsManager = UserDefaultsManager()
    private var review : [BookReview] = []
    
    init(viewController : ReviewListProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
    
    func viewWillAppear() {
        review = userDefaultsManager.getReviews()
        viewController.reloadTableView()
    }
    
    func didTapRightBarButton() {
        viewController.presentToReviewWriteVC()
    }
}

// 데이터 기반 DataSource : Presenter에서 구현 (View와는 관련 없음)
extension ReviewListPresenter : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return review.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let review = review[indexPath.row]
        cell.textLabel?.text = review.title
        cell.detailTextLabel?.text = review.contents
        cell.imageView?.kf.setImage(with: review.imageURL, placeholder: .none, options: .none, completionHandler: { _ in
            cell.setNeedsLayout()
        })
        
        cell.selectionStyle = .none
        
        return cell
    }
}
