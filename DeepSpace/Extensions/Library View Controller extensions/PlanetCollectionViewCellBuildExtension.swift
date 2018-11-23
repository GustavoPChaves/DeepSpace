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
    
    func apodMenuOptionSelected(cell: PlanetCollectionViewCell?) {
        if self.apod == nil {
            NasaAPOD.request(hd: false) { apod in
                DispatchQueue.main.sync {
                    self.apod = apod
                    cell?.planetImage.image = apod.image
                    cell?.planetImage.contentMode = .scaleAspectFill
                    cell?.planetNameLabel.text = apod.title
                }
            }
        } else {
            cell?.planetImage.image = self.apod?.image
            cell?.planetImage.contentMode = .scaleAspectFill
            cell?.planetNameLabel.text = "Astronomy Picture Of the Day:\n\(self.apod!.title!)"
        }
    }
    
    func buildCollectionViewContent(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "planetThumb", for: indexPath) as? PlanetCollectionViewCell
        if cell == nil { cell = PlanetCollectionViewCell() }
        
        cell?.layer.cornerRadius = 13
        cell?.planetImage.backgroundColor = UIColor.black
        
        switch selectedMenuOption {
        case 0:
            self.solarSystemMenuOptionSelected(cell: cell,
                                               indexPath: indexPath)
        case 1:
            self.apodMenuOptionSelected(cell: cell)
        default:
            break
        }
        
        return cell!
    }
    
}
