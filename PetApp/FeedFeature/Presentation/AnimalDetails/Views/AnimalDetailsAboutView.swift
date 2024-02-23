//
//  AnimalDetailsAboutView.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import UIKit
import SnapKit

final class AnimalDetailsAboutView: UIView {
    
    private let header = UILabel()
    
    private let coatItem = AnimalDetailsRowItemStackView()
    private let healthItem = AnimalDetailsRowItemStackView()
    private let houseItem = AnimalDetailsRowItemStackView()
    private let goodWithItem = AnimalDetailsRowItemStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        configureSubviews()
    }
    
    func setCoatLength(_ coat: String, health: String, houseTrained: String, goodWith: String) {
        coatItem.valueLabel.text = coat
        healthItem.valueLabel.text = health
        houseItem.valueLabel.text = houseTrained
        goodWithItem.valueLabel.text = goodWith
    }
    
    private func configureSubviews() {
        header.text = "About"
        header.font = .systemFont(ofSize: 22, weight: .medium)
        
        coatItem.titleLabel.text = "Coat length".uppercased()
        healthItem.titleLabel.text = "Health".uppercased()
        houseItem.titleLabel.text = "House-trained".uppercased()
        goodWithItem.titleLabel.text = "Good in a home with".uppercased()
    }
    
    private func setupSubviews() {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.distribution = .fill
        
        let firstRow = AnimalDetailsRowStackView(coatItem, healthItem)
        let secondRow = AnimalDetailsRowStackView(houseItem, goodWithItem)
        
        vStack.addArrangedSubview(header)
        vStack.addArrangedSubview(firstRow)
        vStack.addArrangedSubview(secondRow)
        
        addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
