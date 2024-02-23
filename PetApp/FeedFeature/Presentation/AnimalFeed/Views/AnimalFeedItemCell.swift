//
//  AnimalFeedItemCell.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import UIKit
import SnapKit

class AnimalFeedItemCell: UICollectionViewCell {
    
    let coverPhoto: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .secondarySystemBackground
        return imgView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .purple
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        configureSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverPhoto.image = nil
    }
    
    private func configureSubviews() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerCurve = .continuous
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }
    
    private func setupSubviews() {
        contentView.addSubview(coverPhoto)
        contentView.addSubview(nameLabel)
        
        coverPhoto.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(coverPhoto.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
