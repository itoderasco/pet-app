//
//  AnimalDetailsContactItemStackView.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import UIKit
import SnapKit

final class AnimalDetailsContactItemStackView: UIStackView {
    
    let iconView = UIImageView()
    let valueButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
        alignment = .leading
        distribution = .fill
        
        addArrangedSubview(iconView)
        addArrangedSubview(valueButton)
        addArrangedSubview(UIView())
        
        iconView.contentMode = .scaleAspectFit
        iconView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 24, height: 40))
        }
        
        var config = UIButton.Configuration.plain()
        config.titleAlignment = .leading
        valueButton.configuration = config
        
        valueButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
