//
//  EventsListView.swift
//  woopSicredi-jobs
//
//  Created by Ádria Cardoso on 13/08/20.
//  Copyright © 2020 Ádria Cardoso. All rights reserved.
//

import UIKit

class EventsListView: UIView {
 
    private lazy var tbVEventList: UITableView = {
        let tbVEventList = UITableView(frame: .zero, style: .plain)
        tbVEventList.register(EventsListCell.self, forCellReuseIdentifier: EventsListCell.reusableIdentifier)
        tbVEventList.delegate = self
        tbVEventList.dataSource = self
        tbVEventList.isScrollEnabled = true
        tbVEventList.isPagingEnabled = false
        tbVEventList.backgroundColor = .white
        tbVEventList.separatorStyle = .singleLine
        tbVEventList.isUserInteractionEnabled = true
        tbVEventList.allowsSelectionDuringEditing = true
        tbVEventList.allowsSelection = true
        tbVEventList.tableFooterView = UIView()
        tbVEventList.layer.borderWidth = 1.0
        tbVEventList.layer.borderColor = UIColor.black.cgColor
        tbVEventList.backgroundColor = .white
        return tbVEventList
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
        
        sv([tbVEventList])
    }
    
    private func layout() {
    
        tbVEventList.top(0).left(0).right(0).bottom(0)
    }
    
    private func addActions() {
        
    }
}
