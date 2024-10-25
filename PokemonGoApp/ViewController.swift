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
    var coreDataPokemon = CoreDataPokemon()
    var pokemons: [Pokemon] = []

    private lazy var mapView: MKMapView = {
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
        
        mapView.delegate = self
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
        //recuperando pokemons
        self.coreDataPokemon = CoreDataPokemon()
        self.pokemons = self.coreDataPokemon.recuperarTodosOsPokemons()
        
        
        Timer.scheduledTimer(withTimeInterval: 8, repeats: true) { timer in
            let latAleatoria = (Double(arc4random_uniform(500))-250) / 100000.0
            let lonAleatoria = (Double(arc4random_uniform(500))-250) / 100000.0
            
            if let coordenadas = self.gerenciadorLocalizacao.location?.coordinate {
                
                let totalPokemons = UInt32(self.pokemons.count)
                let indicePokemonAleatorio = arc4random_uniform(totalPokemons)
                
                let pokemon = self.pokemons[Int(indicePokemonAleatorio)]
                
                let annotation = PokemonAnotacao(coordenadas: coordenadas, pokemon: pokemon)
                
                annotation.coordinate.latitude += latAleatoria
                annotation.coordinate.longitude += lonAleatoria
                
                self.mapView.addAnnotation(annotation)
            }
            
        }
        
        setupViews()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        
        if annotation is MKUserLocation {
            annotationView.image = UIImage(named: "player")
        }else{
            let pokemonName = (annotation as! PokemonAnotacao).pokemon
            if let nomeImagem = pokemonName.nomeImagem {
                annotationView.image = UIImage(named: nomeImagem)
            }
        }
        
        return annotationView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        
        let regionRadius: CLLocationDistance = 500
        let region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        mapView.setRegion(region, animated: true)
    }
    
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
    
    @objc func centerPlayer() {
        guard let currentLocation = gerenciadorLocalizacao.location?.coordinate else { return }
        
        let regionRadius: CLLocationDistance = 500
        let region = MKCoordinateRegion(center: currentLocation, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        mapView.setRegion(region, animated: true)
    }
    
    @objc func pokebolaAcao() {
        self.navigationController?.pushViewController(PokedexViewController(), animated: true)
    }
    
    private func setupViews() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        view.addSubview(mapView)
        
        mapView.addSubview(bussolaButton)
        mapView.addSubview(pokebolaButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            bussolaButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 60),
            bussolaButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            
            pokebolaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokebolaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            pokebolaButton.widthAnchor.constraint(equalToConstant: 50),
            pokebolaButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}


