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
        
        delegate?.selectEvent(event: getEventsList()[indexPath.row])
    }
}

extension EventsListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getEventsList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsListCell.reusableIdentifier, for: indexPath) as? EventsListCell else { return UITableViewCell() }
        
        cell.backgroundColor = .white
        cell.selectionStyle = .none

        let items = getEventsList()[indexPath.row]
        
        cell.setTitleText(items.title ?? "")
        cell.setDateText(items.date?.convertMiliseconsToDate() ?? "")
        cell.setPriceText(items.price?.convertMoney() ?? "")
        
        if let latitude = items.latitude {
            if let longitude = items.longitude {
                latitude.convertLocation(longitude: longitude) { (result, error) in
                    if error == nil {
                        if let location = result {
                            cell.setLocationText(location)
                        }
                    } else {
                        cell.setLocationText("")
                    }
                }
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
}
