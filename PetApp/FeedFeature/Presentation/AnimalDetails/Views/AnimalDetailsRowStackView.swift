//
//  AnimalDetailsRowStackView.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import UIKit

final class AnimalDetailsRowStackView: UIStackView {
    
    init(_ subviews: AnimalDetailsRowItemStackView...) {
        super.init(frame: .zero)
        
        axis = .horizontal
        spacing = 12
        alignment = .leading
        distribution = .fillEqually
        
        for view in subviews {
            addArrangedSubview(view)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
