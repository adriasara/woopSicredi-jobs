//
//  EventsListView.swift
//  woopSicredi-jobs
//
//  Created by Ádria Cardoso on 13/08/20.
//  Copyright © 2020 Ádria Cardoso. All rights reserved.
//

import UIKit
import MaterialComponents

protocol EventListViewDelegate: NSObjectProtocol {
    func selectEvent(event: EventsListModel)
}

class EventsListView: UIView {
    
    private var eventListResult = [EventsListModel]()
    var eventsListViewModel: EventsListViewModel? = nil
    
    weak var delegate: EventListViewDelegate?
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.tintColor = .blue
        refreshControl.attributedTitle = NSAttributedString(string: "loading".localized())
        return refreshControl
    }()
    
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
        tbVEventList.refreshControl = refreshControl
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
        setupComponents()
        addActions()
    }
    
    private func subviews() {
        
        sv([tbVEventList])
    }
    
    private func layout() {
    
        tbVEventList.top(0).left(0).right(0).bottom(0)
    }
    
    private func setupComponents() {
        
        eventsListViewModel = EventsListViewModel(eventsListModel: .init())
    }
    
    private func addActions() {
        
        refreshControl.addTarget(self, action: #selector(refreshTbView), for: .valueChanged)
    }
    
    @objc private func refreshTbView() {
        
        requestEventList { (response) in
            self.tbVEventList.reloadData()
            
            if self.refreshControl.isRefreshing {

                self.refreshControl.endRefreshing()
            }
            
            if response != .success {
                
                let message = MDCSnackbarMessage()
                message.text = "error".localized()
                MDCSnackbarManager.show(message)
            }
        }
    }
    
    func getEventsList() -> [EventsListModel] {
        return eventListResult
    }
    
    func requestEventList(completion: @escaping (_ response: ResponseType?) -> Void) {
        
        refreshControl.beginRefreshing()
                
        eventsListViewModel?.requestEventsList(completion: { (response, result)  in
            
            if response == .success {
                if let eventList = result {
                    
                    self.eventListResult = eventList
                    completion(.success)
                }
            } else {
                completion(.error)
            }
            
            if self.refreshControl.isRefreshing {

                self.refreshControl.endRefreshing()
            }
        })
    }
}
