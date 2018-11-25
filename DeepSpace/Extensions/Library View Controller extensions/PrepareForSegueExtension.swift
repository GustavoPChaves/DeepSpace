//
//  PrepareForSegueExtension.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 22/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
import UIKit

extension LibraryViewController {
    func solarSystemDetailsPrepareForSegue(toViewController destination: DetailsViewController?,
                                           withSender sender: SolarSystemBodies) {
        SolarSystemAPI.getBody(sender) { planetObject in
            DispatchQueue.main.async {
                destination?.planets = self.allPlanets.filter { $0 != sender }
                destination?.presentedModel = planetObject
                
                let imageName = sender.rawValue.replacingOccurrences(of: "/", with: "")
                if let image = UIImage(named: "\(imageName).jpg") {
                    destination?.image = image
                } else {
                    destination?.image = UIImage(named: "picture.png")
                }
                
                if let tableView = destination?.detailsTableView {
                    tableView.reloadData()
                }
            }
        }
    }
    
    func apodDetailsPrepareForSegue(toViewController destination: DetailsViewController?,
                                    withSender sender: APOD) {
        DispatchQueue.main.async {
            destination?.presentedModel = sender
            
            if let image = sender.image {
                destination?.image = image
            } else {
                destination?.image = UIImage(named: "picture.png")
            }
            
            if let tableView = destination?.detailsTableView {
                tableView.reloadData()
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            let destination = segue.destination as? DetailsViewController
            if let sender = sender as? SolarSystemBodies {
                self.solarSystemDetailsPrepareForSegue(toViewController: destination, withSender: sender)
            } else if let sender = sender as? APOD {
                self.apodDetailsPrepareForSegue(toViewController: destination, withSender: sender)
            }
        }
    }
    
}
