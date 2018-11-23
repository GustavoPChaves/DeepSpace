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
                destination?.detailsTableView.reloadData()
                
                let imageName = sender.rawValue.replacingOccurrences(of: "/", with: "")
                if let image = UIImage(named: "\(imageName).jpg") {
                    destination?.image = image
                    destination?.planetImageView.backgroundColor = UIColor.black
                } else {
                    destination?.image = UIImage(named: "picture.png")
                    destination?.planetImageView.backgroundColor = UIColor.lightGray
                }
            }
        }
    }
    
    func apodDetailsPrepareForSegue(toViewController destination: DetailsViewController?,
                                    withSender sender: APOD) {
        DispatchQueue.main.async {
            destination?.presentedModel = sender
            if let tableView = destination?.detailsTableView {
                tableView.reloadData()
            }
            
            if let image = sender.image {
                destination?.image = image
                if let imageView = destination?.planetImageView {
                    imageView.backgroundColor = UIColor.black
                    imageView.contentMode = .scaleAspectFill
                }
            } else {
                destination?.image = UIImage(named: "picture.png")
                if let imageView = destination?.planetImageView {
                    imageView.backgroundColor = UIColor.lightGray
                    imageView.contentMode = .scaleAspectFit
                }
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
