//
//  SearchBookViewController.swift
//  Eung7_BookReview
//
//  Created by 김응철 on 2022/04/03.
//

import SnapKit
import UIKit

class SearchBookViewController : UIViewController {
    
    private lazy var presenter = SearchBookPresenter(
        viewController: self,
        deleagte: delegate
    )
    
    private let delegate : SearchBookDelegate // 생성되면서 Presenter가 넘어옴
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        tableView.delegate = presenter
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    init(searchBookDelegate : SearchBookDelegate) {
        self.delegate = searchBookDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchBookViewController : SearchBookProtocol {
    
    func dismissSearchBookVC() {
        navigationItem.searchController?.dismiss(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter
        
        navigationItem.searchController = searchController
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func reloadView() {
        tableView.reloadData()
    }
}
