//
//  UIViewControllerExtension.swift
//  Snake Arena
//
//  Created by Arish Khan on 19/04/22.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String? = "", _ message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        vc.addAction(action)
        self.present(vc, animated: true, completion: nil)
    }
}
