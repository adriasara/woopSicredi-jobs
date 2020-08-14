//
//  EventsListCell.swift
//  woopSicredi-jobs
//
//  Created by Ádria Cardoso on 13/08/20.
//  Copyright © 2020 Ádria Cardoso. All rights reserved.
//

import UIKit
import Stevia

class EventsListCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.font = UIFont(name: "Arial-Regular", size: 10.0)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.backgroundColor = .white
        return titleLabel
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
        priceLabel.textAlignment = .right
        priceLabel.numberOfLines = 0
        priceLabel.textColor = .black
        priceLabel.backgroundColor = .white
        return priceLabel
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        return stackView
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    private func commonInit() {
        subviews()
        layout()
    }
    
    private func subviews() {
        
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(priceLabel)
        
        sv([titleLabel, stackView, locationLabel])
    }
    
    private func layout() {
        
        titleLabel.left(10).right(10).top(10)
        
        stackView.left(10).right(10).Top == titleLabel.Bottom + 10
        
        locationLabel.left(10).right(10).bottom(10).Top == stackView.Bottom + 10
    }
    
    func setTitleText(_ text: String) {
        titleLabel.text = text
    }
    
    func setDateText(_ text: String) {
        dateLabel.text = text
    }
    
    func setPriceText(_ text: String) {
        priceLabel.text = text
    }
    
    func setLocationText(_ text: String) {
        locationLabel.text = text
    }
}

extension EventsListCell {
    class var reusableIdentifier: String {
        return String(describing: self)
    }
}
