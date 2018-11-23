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
    func solarSystemMenuOptionSelected(cell: PlanetCollectionViewCell?,
                                       indexPath: IndexPath) {
        let imageName = allPlanets[indexPath.item].rawValue.replacingOccurrences(of: "/", with: "")
        cell?.planetImage.image = UIImage(named: "\(imageName).jpg")
        cell?.planetImage.contentMode = .scaleAspectFit
        cell?.planetNameLabel.text = imageName
    }
    
    func apodMenuOptionSelected(cell: PlanetCollectionViewCell?,
                                indexPath: IndexPath) {
        let apod = self.apods[indexPath.item]
        cell?.planetImage.image = apod.image
        cell?.planetImage.contentMode = .scaleAspectFill
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let apodDate = dateFormatter.date(from: apod.date!)
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let apodDateString = dateFormatter.string(from: apodDate!)
        
        cell?.planetNameLabel.text = "\(apod.title!)\n\(apodDateString)"
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
            self.solarSystemMenuOptionSelected(cell: cell,
                                               indexPath: indexPath)
        case 1:
            self.apodMenuOptionSelected(cell: cell,
                                        indexPath: indexPath)
        default:
            break
        }
        
        if cell?.planetImage.image == nil {
            cell?.planetImage.image = UIImage(named: "picture.png")
            cell?.planetImage.contentMode = .scaleAspectFit
        }
        
        return cell!
    }
    
}
