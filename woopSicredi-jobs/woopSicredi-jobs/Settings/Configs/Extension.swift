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
    
    func isValidEmail() -> Bool {
            
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
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
    
    func convertLocation(longitude: Double, completion: @escaping (_ response: String?, _ error: NSError?) -> Void) {
            
        let location = CLLocation(latitude: self, longitude: longitude)
        var region: String = ""
        
        CLGeocoder().reverseGeocodeLocation(location) { (response, error) in
            
            if let result = response {

                guard let city = result.first?.locality else { return }
                guard let country = result.first?.country else { return }
            
                region = "\(city), \(country)"
                if !region.isEmpty {
                    completion(region, nil)
                }
            } else {
                if let error = error {
                    completion(nil, error as NSError)
                }
            }
        }
    }
}

extension UIViewController {

    func presentAlertController(title: String, message: String, completion: @escaping (_ text: [String]?) -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
        alertController.addTextField { (textField : UITextField) -> Void in
            textField.placeholder = "enter_name".localized()
            textField.backgroundColor = .white
        }
        
        alertController.addTextField { (textField : UITextField) -> Void in
            textField.placeholder = "enter_email".localized()
            textField.backgroundColor = .white
            textField.accessibilityLabel = "enterEmailTxtField"
        }
        
        let checkInAction = UIAlertAction(title: "Check-in", style: .default, handler: { alert -> Void in
            
            var nameAndEmail = [String]()
            
            guard let name = alertController.textFields?[0].text else { return }
            guard let email = alertController.textFields?[1].text else { return }
            nameAndEmail.append(name)
            nameAndEmail.append(email)
            
            completion(nameAndEmail)
        })
        let cancelAction = UIAlertAction(title: "cancel".localized(), style: .default, handler: {
            (action : UIAlertAction) -> Void in })

        checkInAction.accessibilityLabel = "checkInButtonAlert"
        
        alertController.addAction(checkInAction)
        alertController.addAction(cancelAction)
                
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAlertMessage(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok".localized(), style: .default, handler: {
            (action : UIAlertAction) -> Void in
            
            self.navigationController?.popViewController(animated: true)
        })

        cancelAction.accessibilityLabel = "okButtonAlert"
        
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func openShareActivity(image: UIImage) {
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        present(activityViewController, animated: true, completion: nil)
    }
}

extension UIView {
    
    func asImage() -> UIImage {
        
        if #available(iOS 10.0, *) {
            
            let render = UIGraphicsImageRenderer(bounds: bounds)
            return render.image { renderContext in
                layer.render(in: renderContext.cgContext)
            }
        } else {
            
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
           
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}
