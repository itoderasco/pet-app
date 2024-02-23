//
//  AnimalDetailsRowItemStackView.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import UIKit

final class AnimalDetailsRowItemStackView: UIStackView {
    
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        spacing = 8
        alignment = .leading
        distribution = .fill
        
        addArrangedSubview(titleLabel)
        addArrangedSubview(valueLabel)
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        valueLabel.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
