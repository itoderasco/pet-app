//
//  AnimalFeedViewController.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import UIKit
import RxSwift
import RxCocoa

final class AnimalFeedViewController: UIViewController {
        
    private let viewModel: AnimalFeedViewModel
    private let contentView = AnimalFeedView()
    
    private let disposeBag = DisposeBag()

    private typealias ViewState = AnimalFeedViewModel.State
    
    init(viewModel: AnimalFeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Pets Feed"
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBindings()

        viewModel.fetchFeedItems()
    }
    
    private func showErrorView(_ show: Bool) {
        contentView.errorView.isHidden = !show
    }
    
    private func showActivityIndicator(_ show: Bool) {
        show ? contentView.spinner.startAnimating() : contentView.spinner.stopAnimating()
    }
    
    private func viewStateDidChange(_ newState: ViewState) {
        switch newState {
        case .idle:
            break
        case .loading:
            showErrorView(false)
            showActivityIndicator(true)
        case .loaded:
            showErrorView(false)
            showActivityIndicator(false)
        case .failed:
            showErrorView(true)
            showActivityIndicator(false)
        }
    }
    
    private func setupBindings() {
        contentView.errorView
            .retryButton.rx.tap
            .subscribe(onNext: viewModel.fetchFeedItems)
            .disposed(by: disposeBag)
        
        viewModel.viewState
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                self?.viewStateDidChange(state)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupCollectionView() {
        contentView.collectionView
            .register(AnimalFeedItemCell.self, forCellWithReuseIdentifier: "FeedItem")
          
        contentView.collectionView.rx
            .itemSelected
            .bind(onNext: viewModel.didSelectItem)
            .disposed(by: disposeBag)
        
        viewModel.feedItems
            .asObservable()
            .bind(to: contentView.collectionView.rx.items(cellIdentifier: "FeedItem", cellType: AnimalFeedItemCell.self)) { index, element, cell in
                cell.nameLabel.text = element.name
                cell.coverPhoto.image = UIImage(named: "placeholder")
                
                if let url = element.photo?.small {
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url) {
                            let image = UIImage(data: data)
                            DispatchQueue.main.async {
                                cell.coverPhoto.image = image
                            }
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
