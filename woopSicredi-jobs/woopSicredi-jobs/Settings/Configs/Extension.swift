//
//  Extension.swift
//  woopSicredi-jobs
//
//  Created by Ádria Cardoso on 13/08/20.
//  Copyright © 2020 Ádria Cardoso. All rights reserved.
//

import UIKit
import CoreLocation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

extension Int {
    
    func convertMiliseconsToDate() -> String {
        let dateFormatter = DateFormatter()
        let dateVar = Date.init(timeIntervalSince1970: TimeInterval(self)/1000)
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
        
        return dateFormatter.string(from: dateVar)
    }
}

extension Decimal {
    
    func convertMoney() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        return formatter.string(from: self as NSNumber) ?? ""
    }
}

extension Double {
    
    func convertLocation(longitude: Double, completion: @escaping (_ response: String?) -> Void) {
            
        let location = CLLocation(latitude: self, longitude: longitude)
        var region: String = ""
        
        CLGeocoder().reverseGeocodeLocation(location) { (response, error) in
            
            if let result = response {

                guard let city = result.first?.locality else { return }
                guard let country = result.first?.country else { return }
            
                region = "\(city), \(country)"
                if !region.isEmpty {
                    print(region)
                    
                    completion(region)
                }
            } else {
                if error != nil {
                    print(error ?? NSError())
                }
            }
        }
    }
}
