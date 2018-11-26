//
//  MenuOptionsActionsExtension.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 22/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
import UIKit

extension LibraryViewController {
    func solarSystemCell(cell: PlanetCollectionViewCell?,
                                       indexPath: IndexPath) {
        let imageName = allPlanets[indexPath.item].rawValue.replacingOccurrences(of: "/", with: "")
        cell?.planetImage.image = UIImage(named: "\(imageName).jpg")
        cell?.planetImage.contentMode = .scaleAspectFit
        cell?.planetImage.backgroundColor = UIColor.black
        cell?.planetNameLabel.text = imageName
    }
    
    func apodCell(cell: PlanetCollectionViewCell?,
                                indexPath: IndexPath) {
        let apod = self.apods[indexPath.item]
        cell?.planetImage.image = apod.image
        cell?.planetImage.contentMode = .scaleAspectFill
        
        var apodDateString: String = ""
        
        if let apodDate = apod.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let date = dateFormatter.date(from: apodDate)
            dateFormatter.dateFormat = "MM/dd/yyyy"
            apodDateString += "\n"
            apodDateString += dateFormatter.string(from: date!)
        }
        
        cell?.planetNameLabel.text = "\(apod.title ?? "")\(apodDateString)"
    }
    
    func exoplanetCell(cell: PlanetCollectionViewCell?,
                                      indexPath: IndexPath) {
        cell?.planetImage.image = UIImage(named: "picture.png")
        cell?.planetImage.contentMode = .scaleAspectFit
        cell?.planetImage.backgroundColor = UIColor.lightGray
        cell?.planetNameLabel.text = exoplanets[indexPath.item].name
    }
    
    func minorPlanetCell(cell: PlanetCollectionViewCell?,
                       indexPath: IndexPath) {
        cell?.planetImage.image = UIImage(named: "picture.png")
        cell?.planetImage.contentMode = .scaleAspectFit
        cell?.planetImage.backgroundColor = UIColor.lightGray
        cell?.planetNameLabel.text = minorPlanets[indexPath.item].name
        
        if cell?.planetImage.image == UIImage(named: "picture.png") {
            NasaMedia.search(search: minorPlanets[indexPath.item].name!, mediaTypes: [.image]) { results in
                let collection = results["collection"] as! [String:Any]
                let items = collection["items"] as! [[String:Any]]
                let links = items.first?["links"] as? [[String:Any]]
                let link = links?.first?["href"] as? String
                guard let linkUnwrapped = link else { return }
                
                GET.request(linkUnwrapped) { data in
                    DispatchQueue.main.async {
                        cell?.planetImage.image = UIImage(data: data)
                        cell?.planetImage.contentMode = .scaleAspectFill
                    }
                }
            }
        }
        
    }
    
    func buildCollectionViewContent(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "planetThumb", for: indexPath) as? PlanetCollectionViewCell
        if cell == nil { cell = PlanetCollectionViewCell() }
        
        cell?.layer.cornerRadius = 13
        cell?.planetImage.backgroundColor = UIColor.black
        
        cell?.contentView.layer.cornerRadius = 13
        cell?.contentView.layer.borderWidth = 1.0
        cell?.contentView.layer.borderColor = UIColor.clear.cgColor
        cell?.contentView.layer.masksToBounds = true
        
        cell?.layer.shadowColor = UIColor.black.cgColor
        cell?.layer.shadowOffset = CGSize(width: 1, height: 2)
        cell?.layer.shadowRadius = 0
        cell?.layer.shadowOpacity = 0.5
        cell?.layer.masksToBounds = false
        cell?.layer.shadowPath = UIBezierPath(roundedRect: cell!.bounds, cornerRadius: cell!.contentView.layer.cornerRadius).cgPath
        cell?.layer.backgroundColor = UIColor.clear.cgColor
        
        switch selectedMenuOption {
        case 0:
            self.solarSystemCell(cell: cell,
                                 indexPath: indexPath)
        case 1:
            self.apodCell(cell: cell,
                          indexPath: indexPath)
        case 2:
            self.exoplanetCell(cell: cell,
                               indexPath: indexPath)
        case 3:
            self.minorPlanetCell(cell: cell,
                                 indexPath: indexPath)
        default:
            break
        }
        
        if cell?.planetImage.image == nil {
            cell?.planetImage.image = UIImage(named: "picture.png")
            cell?.planetImage.contentMode = .scaleAspectFit
            cell?.planetImage.backgroundColor = UIColor.lightGray
        }
        
        return cell!
    }
    
}
