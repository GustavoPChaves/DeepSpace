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
            }
        }
    }
    
    func apodDetailsPrepareForSegue(toViewController destination: DetailsViewController?,
                                    withSender sender: APOD) {
        destination?.presentedModel = sender
            
        if let image = sender.image {
            destination?.image = image
        } else {
            destination?.image = UIImage(named: "picture.png")
        }
        
    }
    
    func genericDetailsPrepareForSegue(toViewController destination: DetailsViewController?,
                                         withSender sender: ConvertibleToArray) {
        destination?.presentedModel = sender
    }
    
    func dragonPrepareForSegue(toViewController destination: DetailsViewController?,
                               withSender sender: DragonDTO) {
        destination?.presentedModel = sender
        
        if let image = sender.image {
            destination?.image = image
        } else {
            destination?.image = UIImage(named: "picture.png")
        }
    }
    
    func rocketPrepareForSegue(toViewController destination: DetailsViewController?,
                               withSender sender: RocketsDTO) {
        destination?.presentedModel = sender
        
        if let image = sender.image {
            destination?.image = image
        } else {
            destination?.image = UIImage(named: "picture.png")
        }
    }
    
    func roadsterPrepareForSegue(toViewController destination: DetailsViewController?,
                               withSender sender: RoadsterDTO) {
        destination?.presentedModel = sender
        
        if let image = sender.image {
            destination?.image = image
        } else {
            destination?.image = UIImage(named: "picture.png")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            let destination = segue.destination as? DetailsViewController
            if let planet = sender as? SolarSystemBodies {
                self.solarSystemDetailsPrepareForSegue(toViewController: destination, withSender: planet)
            } else if let apod = sender as? APOD {
                self.apodDetailsPrepareForSegue(toViewController: destination, withSender: apod)
            } else if let exoplanet = sender as? Exoplanet {
                self.genericDetailsPrepareForSegue(toViewController: destination, withSender: exoplanet)
            } else if let minorPlanet = sender as? MinorPlanet {
                self.genericDetailsPrepareForSegue(toViewController: destination, withSender: minorPlanet)
            } else if let dragon = sender as? DragonDTO {
                self.dragonPrepareForSegue(toViewController: destination, withSender: dragon)
            } else if let rocket = sender as? RocketsDTO {
                self.rocketPrepareForSegue(toViewController: destination, withSender: rocket)
            } else if let roadster = sender as? RoadsterDTO {
                self.roadsterPrepareForSegue(toViewController: destination, withSender: roadster)
            }
        }
    }
    
}
