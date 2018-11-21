//
//  SolarSystemPlanetDetailsViewController.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 19/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class SolarSystemPlanetDetailsViewController: UIViewController {

    @IBOutlet weak var planetImageView: UIImageView!
    @IBOutlet weak var planetDetailsTableView: UITableView!
    
    let allPlanets : [SolarSystemBodies] = [.mercury, .venus, .earth, .mars, .jupiter, .saturn, .uranus, .neptune, .pluto]
    var planets : [SolarSystemBodies] = []
    var planet : SolarSystemBodies? = .earth
    
    var planetObjectProperties : [(property: String, value: String)] = []
    var cellSize : CGSize?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = 
        
        self.planetDetailsTableView.dataSource = self
        self.planetDetailsTableView.delegate = self
        
        let quarterOfScreenWidth = UIScreen.main.bounds.size.width/4
        cellSize = CGSize(width: quarterOfScreenWidth, height: 1.33 * quarterOfScreenWidth)
        
        let planetDetailsXIB = UINib(nibName: "PlanetyPropertyDetailsTableViewCell", bundle: Bundle.main)
        self.planetDetailsTableView.register(planetDetailsXIB, forCellReuseIdentifier: "planetDetails")
        
        let otherPlanetsXIB = UINib(nibName: "OtherPlanetsTableViewCell", bundle: Bundle.main)
        self.planetDetailsTableView.register(otherPlanetsXIB, forCellReuseIdentifier: "otherPlanets")
        
        self.updatePlanetObject(planet!)
        
    }
    
    func updatePlanetObject(_ planet: SolarSystemBodies) {
        self.planetDetailsTableView.contentOffset.y = 0.0
        SolarSystemAPI.getBody(planet) { planetObject in
            DispatchQueue.main.sync {
                self.planet = planet
                self.planets = self.allPlanets.filter { $0 != planet }
                self.planetObjectProperties = planetObject.toArray()
                self.planetDetailsTableView.reloadData()
                
                let imageName = planet.rawValue.replacingOccurrences(of: "/", with: "")
                if let image = UIImage(named: "\(imageName).jpg") {
                    self.planetImageView.image = image
                    self.planetImageView.backgroundColor = UIColor.black
                } else {
                    self.planetImageView.image = UIImage(named: "picture.png")
                    self.planetImageView.backgroundColor = UIColor.lightGray
                }
            }
        }
    }
    
    func isTheCellWithCollectionView(tableViewRow: Int) -> Bool {
        return tableViewRow == self.planetDetailsTableView.numberOfRows(inSection: 0) - 1
    }
    
    func collapseImageOnScroll(_ scrollView: UIScrollView) {
        let safeAreaY = (self.navigationController?.navigationBar.frame.size.height ?? 0) + UIApplication.shared.statusBarFrame.size.height
        let scrollOffset = scrollView.contentOffset.y
        let imageViewHeight = self.planetImageView.frame.size.height
        
        UIView.animate(withDuration: 0.2) {
            if scrollOffset > 0 {
                self.planetImageView.frame.origin.y = safeAreaY - imageViewHeight
                self.planetDetailsTableView.frame.origin.y = safeAreaY
                self.planetDetailsTableView.frame.size.height = self.view.frame.size.height - safeAreaY
            } else {
                let tableY = safeAreaY + imageViewHeight
                self.planetImageView.frame.origin.y = safeAreaY
                self.planetDetailsTableView.frame.origin.y = tableY
                self.planetDetailsTableView.frame.size.height = self.view.frame.size.height - tableY
            }
        }
    }
    
}

extension SolarSystemPlanetDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetObjectProperties.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !isTheCellWithCollectionView(tableViewRow: indexPath.row) {
            var cell = self.planetDetailsTableView.dequeueReusableCell(withIdentifier: "planetDetails", for: indexPath) as? PlanetyPropertyDetailsTableViewCell
            
            if cell == nil {
                cell = PlanetyPropertyDetailsTableViewCell()
            }
            
            cell?.propertyLabel.text = planetObjectProperties[indexPath.row].property
            cell?.valueLabel.text = planetObjectProperties[indexPath.row].value
            
            return cell!
        } else {
            var cell = self.planetDetailsTableView.dequeueReusableCell(withIdentifier: "otherPlanets", for: indexPath) as? OtherPlanetsTableViewCell
            
            if cell == nil {
                cell = OtherPlanetsTableViewCell()
            }
            
            let anotherPlanetXIB = UINib(nibName: "AnotherPlanetCollectionViewCell", bundle: Bundle.main)
            cell?.otherPlanetsCollectionView.register(anotherPlanetXIB, forCellWithReuseIdentifier: "planetThumb")
            cell?.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !isTheCellWithCollectionView(tableViewRow: indexPath.row) {
            return 50
        } else {
            return cellSize!.height + 16
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let location = scrollView.panGestureRecognizer.location(in: self.planetDetailsTableView)
        let indexPath = self.planetDetailsTableView.indexPathForRow(at: location)
        
        let lastRowIndex = self.planetDetailsTableView.numberOfRows(inSection: 0) - 1
        if indexPath?.row == lastRowIndex { return }
        
        self.collapseImageOnScroll(scrollView)
    }
    
}

extension SolarSystemPlanetDetailsViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "planetThumb", for: indexPath) as? AnotherPlanetCollectionViewCell
        
        if cell == nil {
            cell = AnotherPlanetCollectionViewCell()
        }
        
        let imageName = planets[indexPath.item].rawValue.replacingOccurrences(of: "/", with: "")
        cell?.planetImage.image = UIImage(named: "\(imageName).jpg")
        cell?.planetNameLabel.text = imageName
        
        cell?.layer.cornerRadius = 13
        cell?.planetImage.backgroundColor = UIColor.black
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.updatePlanetObject(planets[indexPath.item])
    }
    
}
