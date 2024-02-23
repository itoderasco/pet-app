//
//  AnimalDetailsContactStackView.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import UIKit
import RxSwift

protocol AnimalDetailsContactActionDelegate: AnyObject {
    func writeEmail()
    func phoneCall()
}

final class AnimalDetailsContactStackView: UIStackView {
    
    private let locationItem = AnimalDetailsContactItemStackView()
    private let emailItem = AnimalDetailsContactItemStackView()
    private let phoneItem = AnimalDetailsContactItemStackView()
    
    weak var actionDelegate: AnimalDetailsContactActionDelegate? {
        didSet { setupBindings() }
    }
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .vertical
        spacing = 8
        
        addArrangedSubview(locationItem)
        addArrangedSubview(emailItem)
        addArrangedSubview(phoneItem)
        
        configureSubviews()
    }
    
    func setLocationAddress(_ address: String, email: String?, phone: String?) {
        locationItem.valueButton.setTitle(address, for: .normal)
        
        emailItem.valueButton.setTitle(email, for: .normal)
        emailItem.valueButton.isUserInteractionEnabled = email != nil
        
        phoneItem.valueButton.setTitle(phone, for: .normal)
        phoneItem.valueButton.isUserInteractionEnabled = phone != nil
    }
    
    private func setupBindings() {
        guard let delegate = actionDelegate else { return }
        
        emailItem.valueButton.rx.tap
            .subscribe(onNext: delegate.writeEmail)
            .disposed(by: disposeBag)
        
        phoneItem.valueButton.rx.tap
            .subscribe(onNext: delegate.phoneCall)
            .disposed(by: disposeBag)
    }
    
    private func configureSubviews() {
        locationItem.iconView.image = UIImage(systemName: "mappin.circle.fill")
        locationItem.valueButton.setTitleColor(.black, for: .normal)
        locationItem.valueButton.isUserInteractionEnabled = false
        
        emailItem.iconView.image = UIImage(systemName: "envelope.circle.fill")
        emailItem.valueButton.setTitleColor(.systemBlue, for: .normal)
        
        phoneItem.iconView.image = UIImage(systemName: "phone.circle.fill")
        phoneItem.valueButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
