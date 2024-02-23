//
//  AnimalDetailsView.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import UIKit
import SnapKit

final class AnimalDetailsView: UIView {
    
    private let scrollView = UIScrollView()
    
    let imageView = UIImageView()
    let statusLabel = UILabel()
    let breedLabel = UILabel()
    let detailsLabel = UILabel()
    let aboutView = AnimalDetailsAboutView()
    let descriptionLabel = UILabel()
    let contactView = AnimalDetailsContactStackView()
    
    init() {
        super.init(frame: .zero)
        
        setupSubviews()
        configureSubviews()
    }
    
    private func configureSubviews() {
        backgroundColor = .white

        imageView.backgroundColor = .systemGroupedBackground
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.cornerCurve = .continuous
        imageView.clipsToBounds = true
        
        statusLabel.font = .systemFont(ofSize: 14, weight: .medium)
        breedLabel.font = .systemFont(ofSize: 13, weight: .medium)
        detailsLabel.font = .systemFont(ofSize: 12)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 16)
    }
    
    private func setupSubviews() {
        let contentVStack = UIStackView()
        contentVStack.axis = .vertical
        contentVStack.spacing = 8
        
        contentVStack.addArrangedSubview(imageView)
        contentVStack.addArrangedSubview(statusLabel)
        contentVStack.addArrangedSubview(breedLabel)
        contentVStack.addArrangedSubview(detailsLabel)
        contentVStack.addArrangedSubview(aboutView)
        contentVStack.addArrangedSubview(descriptionLabel)
        contentVStack.addArrangedSubview(contactView)
        
        addSubview(scrollView)
        
        let contentView = UIView()
        contentView.addSubview(contentVStack)
        
        scrollView.addSubview(contentView)
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        contentVStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.equalTo(snp.width)
            make.bottom.greaterThanOrEqualToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

