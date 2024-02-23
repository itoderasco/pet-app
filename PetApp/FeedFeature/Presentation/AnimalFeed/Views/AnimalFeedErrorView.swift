//
//  AnimalFeedErrorView.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import UIKit
import SnapKit

final class AnimalFeedErrorView: UIView {
    
    let imageView = UIImageView()
    
    let messageLabel = UILabel()
    
    let retryButton = UIButton(configuration: UIButton.Configuration.filled(), primaryAction: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        configureSubviews()
    }
    
    private func configureSubviews() {
        imageView.image = UIImage(systemName: "exclamationmark.circle")
        imageView.contentMode = .scaleAspectFit
        
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.text = "Something went wrong.\nPlease try again later"
        
        retryButton.setTitle("Retry", for: .normal)
        
    }
    
    private func setupSubviews() {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 16
        
        vStack.addArrangedSubview(imageView)
        vStack.addArrangedSubview(messageLabel)
        vStack.addArrangedSubview(retryButton)
        
        addSubview(vStack)
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        
        retryButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
        
        vStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
