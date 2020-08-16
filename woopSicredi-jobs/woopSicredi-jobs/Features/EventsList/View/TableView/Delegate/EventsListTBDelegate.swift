//
//  EventsListTBDelegate.swift
//  woopSicredi-jobs
//
//  Created by Ádria Cardoso on 13/08/20.
//  Copyright © 2020 Ádria Cardoso. All rights reserved.
//

import UIKit

extension EventsListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.selectEvent(event: getEventsList()?[indexPath.row] ?? EventsListModel())
    }
}

extension EventsListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let eventList = getEventsList() {
            return eventList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsListCell.reusableIdentifier, for: indexPath) as? EventsListCell else { return UITableViewCell() }
        
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {

            cell.accessibilityLabel = "my_cell"
        }

        if let eventList = getEventsList() {
            let items = eventList[indexPath.row]

            
            cell.setTitleText(items.title ?? "title".localized() + ": -")
            cell.setDateText(items.date?.convertMiliseconsToDate() ?? "date".localized() + ": -")
            cell.setPriceText(items.price?.convertMoney() ?? "price".localized() + ": -")
            
            if let latitude = items.latitude {
                if let longitude = items.longitude {
                    latitude.convertLocation(longitude: longitude) { (result, error) in
                        if error == nil {
                            if let location = result {
                                cell.setLocationText(location)
                            }
                        } else {
                            cell.setLocationText("location".localized() + ": -")
                        }
                    }
                } else {
                    cell.setLocationText("location".localized() + ": -")
                }
            } else {
                cell.setLocationText("location".localized() + ": -")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
}
