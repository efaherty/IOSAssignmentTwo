//
//  ViewController.swift
//  IOSAssignmentTwo
//
//  Created by emily faherty on 11/29/21.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    var mapView: MKMapView!
    var poiSwitch: UISwitch!
    var poiLabel: UILabel!
    var findMe: UIButton!

    override func loadView() {
        mapView = MKMapView()
        poiSwitch = UISwitch()
        poiLabel = UILabel()
        findMe = UIButton()
        
        
        view = mapView
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self,
                                   action: #selector(mapTypeChanged(_:)),
                                   for: .valueChanged)
        
        poiSwitch.addTarget(self,
                                   action: #selector(switchUI(_:)),
                                   for: .valueChanged)
        
        findMe.addTarget(self,
                                   action: #selector(buttonClicked(_:)),
                                   for:.touchUpInside)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        poiSwitch.translatesAutoresizingMaskIntoConstraints = false
        poiLabel.translatesAutoresizingMaskIntoConstraints = false
        findMe.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(segmentedControl)
        view.addSubview(poiSwitch)
        view.addSubview(poiLabel)
        view.addSubview(findMe)
        
        findMe.setTitle("Find Me", for: .normal)
        
        poiLabel.text = "Points of Interest"
        
        let topConstraint =
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 38)
        
        let margins = view.layoutMarginsGuide
        
        let leadingConstraint =
            segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint =
                segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        let poiSwitchTopConstraint = poiSwitch.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8)
        let poiSwitchLeadingConstraint = poiSwitch.leadingAnchor.constraint(equalTo: poiLabel.trailingAnchor, constant: 12)
        
        let poiLabelTopConstraint = poiLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8)
        let poiLabelLeadingConstraint = poiLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        
        let findMeTopConstraint = findMe.topAnchor.constraint(equalTo: poiLabel.bottomAnchor, constant: 8)
        let findMeLeadingConstraint = findMe.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 8)
        findMe.layer.cornerRadius = 2
        findMe.setTitleColor(UIColor.black, for: .normal)
        let fmButtonWidthConstraint = findMe.widthAnchor.constraint(
        equalToConstant: findMe.titleLabel!.intrinsicContentSize.width + 2.0 * 3)
        
        findMe.backgroundColor = UIColor.white
        findMe.layer.borderWidth = 1
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        poiSwitchTopConstraint.isActive = true
        poiSwitchLeadingConstraint.isActive = true
        
        poiLabelTopConstraint.isActive = true
        poiLabelLeadingConstraint.isActive = true
        
        findMeTopConstraint.isActive = true
        findMeLeadingConstraint.isActive = true
        fmButtonWidthConstraint.isActive = true
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("something")
        
        // Do any additional setup after loading the view.
    }
    @IBAction func switchUI(_ sender: UISwitch) {
        print("switch")
        let switchStatus:Bool = sender.isOn
        
        if switchStatus == true {
            mapView.pointOfInterestFilter = .some(MKPointOfInterestFilter(excluding: []))
        } else {
            mapView.pointOfInterestFilter = .some(MKPointOfInterestFilter(including: []))
        }
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    
    @objc func buttonClicked(_ button: UIButton) {
        print("button")
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(
            latitude: 46.7601111,
            longitude:-94.0365377
        ),
        latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    
}

