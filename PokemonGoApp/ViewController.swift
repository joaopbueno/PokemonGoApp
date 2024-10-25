//
//  ViewController.swift
//  PokemonGoApp
//
//  Created by João Bueno on 25/10/24.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var gerenciadorLocalizacao = CLLocationManager()

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
        
        mapview.delegate = self
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
        
        setupViews()
    }
    
<<<<<<< HEAD
=======
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse && status != .notDetermined {
            let alertController = UIAlertController(title: "Permissão de localização", message: "Necessario permissão para acesso a sua localização! Por favor habilite.", preferredStyle: .alert)
            
            let acaoConfiguracoes = UIAlertAction(title: "Abrir configurações", style: .default, handler: {(alertaConfiguracao) in
                if let configuracoes = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open( configuracoes as URL)
                }
            })
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertController.addAction(acaoConfiguracoes)
            alertController.addAction(acaoCancelar)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
>>>>>>> fc20126 (Botoes e assets)
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

