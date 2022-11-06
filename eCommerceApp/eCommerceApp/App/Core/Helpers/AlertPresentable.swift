//
//  AlertPresentable.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 27.10.2022.
//

import UIKit

protocol AlertPresentable {}

extension AlertPresentable where Self: UIViewController {
    func showAlert(title: String? = nil,
                       message: String? = nil,
                       cancelButtonTitle: String? = nil,
                       handler: ((UIAlertAction) -> Void)? = nil ) {
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK",
                                              style: .default,
                                              handler: handler)
            
            if let cancelButtonTitle {
                let cancelAction = UIAlertAction(title: cancelButtonTitle,
                                                 style: .cancel)
                alertController.addAction(cancelAction)
            }
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true)
        }
        
    func showError(_ error: Error) {
        showAlert(title: "Error Occurred",
                  message: error.localizedDescription)
    }
    
    func showActionSheet(title: String? = nil,
                         message: String? = nil,
                         buttonTitle: String? = nil,
                         style: UIAlertAction.Style? = nil,
                         handler: ((UIAlertAction) -> Void)? = nil) {
        let actionSheet = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .actionSheet)
        let defaultAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        if let buttonTitle {
            let buttonAction = UIAlertAction(title: buttonTitle,
                                             style: style ?? .default,
                                             handler: handler)
            actionSheet.addAction(buttonAction)
        }
        actionSheet.addAction(defaultAction)
        self.present(actionSheet, animated: true)
    }
    
    func showActionError(_ error: Error) {
        showActionSheet(title: "Error Occurred",
                        message: error.localizedDescription)
    }
    
}
