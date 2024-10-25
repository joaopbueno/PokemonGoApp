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
    
    private lazy var bussolaButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "compass"), for: .normal)
        button.addTarget(self, action: #selector(centerPlayer), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var pokebolaButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "pokeball"), for: .normal)
        button.addTarget(self, action: #selector(pokebolaAcao), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
    }
    
    @objc func centerPlayer() {
        print("clicou")
    }
    
    @objc func pokebolaAcao() {
        print("clicou")
    }
    
    private func setupViews() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        view.addSubview(mapview)
        
        mapview.addSubview(bussolaButton)
        mapview.addSubview(pokebolaButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mapview.topAnchor.constraint(equalTo: view.topAnchor),
            mapview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            bussolaButton.topAnchor.constraint(equalTo: mapview.topAnchor, constant: 60),
            bussolaButton.trailingAnchor.constraint(equalTo: mapview.trailingAnchor, constant: -20),
            
            pokebolaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokebolaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            pokebolaButton.widthAnchor.constraint(equalToConstant: 50),
            pokebolaButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

