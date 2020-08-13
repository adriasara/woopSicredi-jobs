//
//  EventsDetailsView.swift
//  woopSicredi-jobs
//
//  Created by Ádria Cardoso on 13/08/20.
//  Copyright © 2020 Ádria Cardoso. All rights reserved.
//

import UIKit
import Stevia

class EventsDetailsView: UIView {
    
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
        titleLabel.textColor = .black
        return titleLabel
    }()
    
    private lazy var eventImage: UIImageView = {
        let eventImage = UIImageView(frame: .zero)
        eventImage.contentMode = .scaleAspectFill
        return eventImage
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let descriptionTextView = UITextView(frame: .zero)
        descriptionTextView.font = UIFont(name: "Arial-Regular", size: 10.0)
        descriptionTextView.textAlignment = .justified
        descriptionTextView.textColor = .black
        descriptionTextView.isEditable = false
        descriptionTextView.isScrollEnabled = true
        descriptionTextView.delegate = self
        return descriptionTextView
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel(frame: .zero)
        dateLabel.font = UIFont(name: "Arial-Regular", size: 10.0)
        dateLabel.textAlignment = .left
        dateLabel.numberOfLines = 0
        dateLabel.textColor = .black
        return dateLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel(frame: .zero)
        priceLabel.font = UIFont(name: "Arial-Regular", size: 10.0)
        priceLabel.textAlignment = .right
        priceLabel.numberOfLines = 0
        priceLabel.textColor = .black
        return priceLabel
    }()
    
    private lazy var locationLabel: UILabel = {
        let locationLabel = UILabel(frame: .zero)
        locationLabel.font = UIFont(name: "Arial-Regular", size: 10.0)
        locationLabel.textAlignment = .left
        locationLabel.numberOfLines = 0
        locationLabel.textColor = .black
        return locationLabel
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
    }
    
    private func subviews() {
        
        whiteView.sv([titleLabel, eventImage, descriptionTextView, dateLabel, priceLabel, locationLabel])
        sv([whiteView])
    }
    
    private func layout() {
        
        whiteView.left(0).right(0).top(0).bottom(0)
    
        titleLabel.top(15).left(10).right(10)
        
        eventImage.left(30).right(30).height(30%).Top == titleLabel.Bottom + 10
        
        descriptionTextView.left(10).right(10).Top == eventImage.Bottom + 10
    }
    
    func setupComponents(item: EventsListModel) {
        
        titleLabel.text = item.title
        
        if let image = item.image {
            if let url = URL(string: image) {
                do {
                    let data: Data = try Data(contentsOf: url)
                    eventImage.image = UIImage(data: data)
                } catch {
                    // error handling
                }
            }
        }
        
        descriptionTextView.text = item.description
    }
}
