//
//  ViewController.swift
//  Eung7_BookReview
//
//  Created by 김응철 on 2022/04/03.
//

import UIKit
import SnapKit

class ReviewListViewController: UIViewController {
    
    private lazy var presenter = ReviewListPresenter(viewController: self)
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // TODO : UserDefaults 내용 업데이트 하기
        presenter.viewWillAppear()
    }
}

extension ReviewListViewController : ReviewListProtocol {
    
    func setupNavigationBar() {
        navigationItem.title = "도서 리뷰"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let rightBarButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapRightBarButton)
        )
        navigationItem.rightBarButtonItem = rightBarButton
    }
     
    func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func presentToReviewWriteVC() {
        let vc = UINavigationController(rootViewController: ReviewWriteViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func reloadTableView() {
        tableView.reloadData()
        print("I just have reloaded!")
    }
}

private extension ReviewListViewController {
    @objc func didTapRightBarButton() {
        presenter.didTapRightBarButton()
    }
}

