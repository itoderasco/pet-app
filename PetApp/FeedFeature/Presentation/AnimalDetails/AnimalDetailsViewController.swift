//
//  AnimalDetailsViewController.swift
//  PetApp
//
//  Created by Ion Toderasco on 22.02.2024.
//

import UIKit
import RxSwift
import RxCocoa
import MessageUI

final class AnimalDetailsViewController: UIViewController {
    
    private let viewModel: AnimalDetailsViewModel
    private let contentView = AnimalDetailsView()
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: AnimalDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = contentView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.petName

        if let url = viewModel.photoURL {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async { [weak self] in
                        self?.contentView.imageView.image = image
                    }
                }
            }
        }
        
        contentView.breedLabel.text = viewModel.breed
        
        contentView.statusLabel.text = viewModel.statusDetails
        
        contentView.detailsLabel.text = viewModel.petDetails
        
        contentView.aboutView.setCoatLength(
            viewModel.coat,
            health: viewModel.health,
            houseTrained: viewModel.houseTrained,
            goodWith: viewModel.goodWith
        )
        
        contentView.descriptionLabel.text = viewModel.description
        
        contentView.contactView.actionDelegate = self
        contentView.contactView.setLocationAddress(
            viewModel.address,
            email: viewModel.email,
            phone: viewModel.phone
        )
    }
}

extension AnimalDetailsViewController: AnimalDetailsContactActionDelegate, MFMailComposeViewControllerDelegate {
    
    func writeEmail() {
        guard MFMailComposeViewController.canSendMail(), let email = viewModel.email else {
            return
        }
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients([email])
        mail.setMessageBody("<p>I'm considering \(viewModel.petName) for adoption!</p>", isHTML: true)
        present(mail, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func phoneCall() {
        guard let phoneNumber = viewModel.phone,
              let url = URL(string: "tel://" + phoneNumber)
        else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
