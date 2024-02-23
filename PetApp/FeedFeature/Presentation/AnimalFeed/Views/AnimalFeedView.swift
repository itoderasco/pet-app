//
//  AnimalFeedView.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import UIKit
import SnapKit

final class AnimalFeedView: UIView {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    let spinner = UIActivityIndicatorView()
    
    lazy private(set) var errorView = AnimalFeedErrorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionLayout()
        
        setupSubviews()
        configureSubviews()
    }
    
    private func configureSubviews() {
        collectionView.backgroundColor = .systemGray5
        collectionView.contentInset = .init(top: 8, left: 16, bottom: 16, right: 16)
        
        errorView.backgroundColor = .systemGray5
        errorView.isHidden = true
        
        spinner.style = .large
        spinner.hidesWhenStopped = true
    }
    
    private func setupSubviews() {
        addSubview(collectionView)
        addSubview(spinner)
        addSubview(errorView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupCollectionLayout() {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width - 32
        let interItemSpacing = CGFloat(12)
        let width = (screenWidth - interItemSpacing) / 2
        
        layout.minimumInteritemSpacing = interItemSpacing
        layout.itemSize = CGSize(width: width, height: width * 1.3)
        
        collectionView.collectionViewLayout = layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
