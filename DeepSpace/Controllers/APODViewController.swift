//
//  APODViewController.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 27/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit
import CoreMotion
import SceneKit

class APODViewController: UIViewController, BackgroundDefault {

    @IBOutlet weak var apodSceneView: SCNView!
    @IBOutlet weak var apodTitle: UILabel!
    @IBOutlet weak var labelBackgroundView: UIView!
    var motionManager: CMMotionManager = CMMotionManager()
    @IBOutlet weak var headerLabel: UILabel!
    
    var apod: APOD?
    
    lazy private var activityIndicator : CustomActivityIndicatorView! = {
        let image : UIImage = UIImage(named: "Loading.png")!
        return CustomActivityIndicatorView(image: image)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = "Astronomy\nPicture\nOf the\nDay"
        self.setBackground(myScene: apodSceneView)
        self.view.blurredView(withFrame: self.view.bounds,
                              opacity: 0.5,
                              backgroundColor: UIColor(red: 0,
                                                       green: 0,
                                                       blue: 0,
                                                       alpha: 0.25),
                              insertAt: 1)
        
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(apodDetails))
        self.view.addGestureRecognizer(tapGesture)
        
        NasaAPOD.request(hd: true) { apod in
            DispatchQueue.main.async {
                GET.request(apod.url ?? "") { data in
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                            if let pngData = image.pngData() {
                                self.setBackground(myScene: self.apodSceneView, imageData: pngData)
                            } else if let jpegData = image.jpegData(compressionQuality: 1) {
                                 self.setBackground(myScene: self.apodSceneView, imageData: jpegData)
                            }
                        }
                    }
                }
                self.apod = apod
                self.apodTitle.text = apod.title
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.activityIndicator.positionate(inOriginY: 0,
                                           inCenter: self.view.center,
                                           withSize: self.view.frame.size)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let apod = sender as? APOD {
            let destination = segue.destination as? DetailsViewController
            destination?.presentedModel = apod
            
            if let image = apod.image {
                destination?.image = image
            }
        }
    }
    

    @objc func apodDetails() {
        if apod != nil {
            self.performSegue(withIdentifier: "details", sender: apod)
        }
    }

}