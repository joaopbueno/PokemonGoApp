//
//  ViewController.swift
//  PokemonGoApp
//
//  Created by João Bueno on 25/10/24.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    private lazy var mapview: MKMapView = {
        let mapview = MKMapView()
        mapview.translatesAutoresizingMaskIntoConstraints = false
        mapview.showsUserLocation = true
        
        return mapview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
    }
    
    private func setupViews() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        view.addSubview(mapview)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mapview.topAnchor.constraint(equalTo: view.topAnchor),
            mapview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapview.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

}

