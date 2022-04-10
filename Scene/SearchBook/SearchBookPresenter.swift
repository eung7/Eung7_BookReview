//
//  SearchBookPresenter.swift
//  Eung7_BookReview
//
//  Created by 김응철 on 2022/04/03.
//

import UIKit

protocol SearchBookProtocol {
    func setupViews()
    func dismissSearchBookVC()
    func reloadView()
}

protocol SearchBookDelegate {
    func sendBook(_ book : Book)
}

class SearchBookPresenter : NSObject {
    
    private let viewController : SearchBookProtocol
    private let delegate : SearchBookDelegate // 초기화를 시키기 위해서
    
    private let bookSearchManager = BookSearchManager()
    
    private var books : [Book] = []
    
    init(viewController : SearchBookProtocol,
         deleagte : SearchBookDelegate
    ) {
        self.viewController = viewController
        self.delegate = deleagte
    }
    
    func viewDidLoad() {
        viewController.setupViews()
    }
}

// 데이터 핸들링
extension SearchBookPresenter : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        bookSearchManager.request(from: text) { [weak self] newBooks in
            self?.books = newBooks
            self?.viewController.reloadView()
        }
    }
}

extension SearchBookPresenter : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(books[indexPath.row].title)"
        return cell
    }
}

extension SearchBookPresenter : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = books[indexPath.row]
        delegate.sendBook(selectedBook)
        
        viewController.dismissSearchBookVC()
    }
}
