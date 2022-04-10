//
//  ReviewWriteViewController.swift
//  Eung7_BookReview
//
//  Created by 김응철 on 2022/04/03.
//

import UIKit
import SnapKit
import Kingfisher

class ReviewWriteViewController : UIViewController {
    
    private lazy var presenter = ReviewWritePresenter(viewController: self)
    
    private lazy var bookTitleButton : UIButton = {
        let button = UIButton()
        button.setTitle("책 제목", for: .normal)
        button.setTitleColor(UIColor.tertiaryLabel, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 23.0, weight: .bold)
        button.addTarget(self, action: #selector(didTapBookTitleButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var contentsTextView : UITextView = {
        let textView = UITextView()
        textView.textColor = .tertiaryLabel
        textView.text = presenter.contentsTextViewPlaceHolder
        textView.font = .systemFont(ofSize: 16.0, weight: .medium)
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondaryLabel
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension ReviewWriteViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .tertiaryLabel else { return }
        textView.text = ""
        textView.textColor = .label
    }
}

extension ReviewWriteViewController : ReviewWriteProtocol {
    
    func updateViews(title : String, imageURL : URL?) {
        bookTitleButton.setTitle(title, for: .normal)
        bookTitleButton.setTitleColor(.label, for: .normal)
        imageView.kf.setImage(with: imageURL)
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapCloseBarButton)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didTapSaveBarButton)
        )
    }
    
    func showCloseAlertSheet() {
        let alertController = UIAlertController(
            title: "작성중인 내용이 있습니다. 정말 닫으시겠습니까?",
            message: nil,
            preferredStyle: .alert
        )
        
        let closeAction = UIAlertAction(
            title: "닫기",
            style: .destructive,
            handler: { [weak self] _ in
                self?.dismiss(animated: true)
            })
        
        let cancelAction = UIAlertAction(
            title: "취소",
            style: .cancel
        )
        
        [ closeAction, cancelAction ]
            .forEach { alertController.addAction($0) }
        
        present(alertController, animated: true)
    }
    
    func dismissReviewWriteVC() {
        dismiss(animated: true)
    }
    
    func presentToSearchBookVC() {
        let vc = UINavigationController(rootViewController: SearchBookViewController(searchBookDelegate: presenter))
        
        present(vc, animated: true)
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        [ bookTitleButton, contentsTextView, imageView ]
            .forEach { view.addSubview($0)  }
        
        bookTitleButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        contentsTextView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(bookTitleButton.snp.bottom).offset(16)
        }
        
        imageView.snp.makeConstraints {
            $0.leading.equalTo(bookTitleButton.snp.leading)
            $0.trailing.equalTo(bookTitleButton.snp.trailing)
            $0.top.equalTo(contentsTextView.snp.bottom).offset(16)
            
            $0.height.equalTo(200)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
}

private extension ReviewWriteViewController {
    @objc func didTapCloseBarButton() {
        presenter.didTapCloseBarButton()
    }
    
    @objc func didTapSaveBarButton() {
        presenter.didTapSaveBarButton(contentsText: contentsTextView.text)
    }
    
    @objc func didTapBookTitleButton() {
        presenter.didTapBookTitleButton()
    }
}
