//
//  EventsDetailsView.swift
//  woopSicredi-jobs
//
//  Created by Ádria Cardoso on 13/08/20.
//  Copyright © 2020 Ádria Cardoso. All rights reserved.
//

import UIKit
import Stevia

protocol EventsDetailsViewDelegate: NSObjectProtocol {
    func loginAction()
}

class EventsDetailsView: UIView {
    
    weak var delegate: EventsDetailsViewDelegate?
    
    private lazy var whiteView: UIView = {
        let whiteView = UIView(frame: .zero)
        whiteView.backgroundColor = .white
        return whiteView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.font = UIFont(name: "Arial-Medium", size: 10.0)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.backgroundColor = .white
        titleLabel.textColor = .black
        return titleLabel
    }()
    
    private lazy var eventImage: UIImageView = {
        let eventImage = UIImageView(frame: .zero)
        eventImage.backgroundColor = .white
        eventImage.contentMode = .scaleAspectFit
        return eventImage
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let descriptionTextView = UITextView(frame: .zero)
        descriptionTextView.font = UIFont(name: "Arial-Regular", size: 10.0)
        descriptionTextView.textAlignment = .justified
        descriptionTextView.textColor = .black
        descriptionTextView.backgroundColor = .white
        descriptionTextView.isEditable = false
        descriptionTextView.isScrollEnabled = true
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        return descriptionTextView
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel(frame: .zero)
        dateLabel.font = UIFont(name: "Arial-Regular", size: 10.0)
        dateLabel.textAlignment = .left
        dateLabel.numberOfLines = 0
        dateLabel.textColor = .black
        dateLabel.backgroundColor = .white
        return dateLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel(frame: .zero)
        priceLabel.font = UIFont(name: "Arial-Regular", size: 10.0)
        priceLabel.textAlignment = .left
        priceLabel.numberOfLines = 0
        priceLabel.textColor = .black
        priceLabel.backgroundColor = .white
        return priceLabel
    }()
    
    private lazy var locationLabel: UILabel = {
        let locationLabel = UILabel(frame: .zero)
        locationLabel.font = UIFont(name: "Arial-Regular", size: 10.0)
        locationLabel.textAlignment = .left
        locationLabel.numberOfLines = 0
        locationLabel.textColor = .black
        locationLabel.backgroundColor = .white
        return locationLabel
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton(frame: .zero)
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.setTitleColor(.white, for: .normal)
        return loginButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        subviews()
        layout()
        addActions()
    }
    
    private func subviews() {
        
        whiteView.sv([titleLabel, eventImage, descriptionTextView, dateLabel, priceLabel, locationLabel])
        sv([whiteView, loginButton])
    }
    
    private func layout() {
        
        whiteView.centerVertically().centerHorizontally().height(80%).width(90%)
    
        titleLabel.top(15).left(10).right(10)
        
        eventImage.left(10).right(10).height(30%).Top == titleLabel.Bottom + 15
        
        descriptionTextView.left(10).right(10).height(40%).Top == eventImage.Bottom + 10
        
        dateLabel.left(10).right(10).Top == descriptionTextView.Bottom + 15
        
        priceLabel.left(10).right(10).Top == dateLabel.Bottom + 10
        
        locationLabel.left(10).right(10).Top == priceLabel.Bottom + 10
        
        loginButton.left(50).right(50).height(40).bottom(20)
    }
    
    private func addActions() {
        
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    }
    
    @objc private func loginAction() {
        delegate?.loginAction()
    }
    
    func setupComponents(item: EventsListModel) {
        
        titleLabel.text = item.title
        
        if let image = item.image {
            if let url = URL(string: image) {
                do {
                    let data: Data = try Data(contentsOf: url)
                    eventImage.image = UIImage(data: data)
                } catch {
                    eventImage.image = #imageLiteral(resourceName: "no-photo")
                }
            }
        }
        
        descriptionTextView.text = item.description
        
        if let date = item.date {

            dateLabel.text = "date".localized() + ": \(date.convertMiliseconsToDate())"
        }
        
        if let price = item.price {

            priceLabel.text = "value".localized() + ": \(price.convertMoney())"
        }
        
        if let latitude = item.latitude {
            if let longitude = item.longitude {
                latitude.convertLocation(longitude: longitude) { (result, error) in
                    if error == nil {
                        if let location = result {
                            self.locationLabel.text = "location".localized() + ": \(location)"
                        }
                    } else {
                        self.locationLabel.text = "location".localized() + ": -"
                    }
                }
            }
        }
    }
}
