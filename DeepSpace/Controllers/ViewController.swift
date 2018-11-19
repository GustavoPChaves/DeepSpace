//
//  ViewController.swift
//  DeepSpace
//
//  Created by Adriel Freire on 12/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        NasaMedia.search(search: "HIP", keywords: [], mediaTypes: [.image]) { json in
////            print(json)
//        }
        
//        NasaAPOD.request(hd: false) { apod in
//            print(apod.hdurl)
//        }
        
//        NasaExoplanet.getExoplanetExtendedData { exoplanets in
//            for exoplanet in exoplanets {
//                print(exoplanet.name!)
//                print(exoplanet.bestMassEarthUnits!)
//                print(exoplanet.density!)
//                print(exoplanet.publishDate!)
//                print(exoplanet.status!)
//
//                print(exoplanet.hostStar!.hipparcosCatalogName!)
//                print(exoplanet.hostStar!.metallicity!)
//                print(exoplanet.hostStar!.metallicityRatio!)
//
//                print("")
//            }
//        }
        
        MinorPlanetAPI.fetch { minorPlanets in
            print(minorPlanets[0])
        }

        SolarSystemAPI.fetch { planets in
            print(planets)
        }
//
//        SolarSystemAPI.getBody(.mars) { planet in
//            print("\n\n\(planet)")
//        }
        
    }


}
