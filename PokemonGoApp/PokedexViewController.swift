//
//  PokedexViewController.swift
//  PokemonGoApp
//
//  Created by João Bueno on 25/10/24.
//

import UIKit

class PokedexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pokemonsCapturados: [Pokemon] = []
    var pokemonsNaoCapturados: [Pokemon] = []
    
    private lazy var pokemonsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.register(PokeAgendaViewCell.self, forCellReuseIdentifier: PokeAgendaViewCell.indentifier)

        return tableView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let coreData = CoreDataPokemon()
        self.pokemonsCapturados = coreData.recuperarTodosPokemonsCapturados(capturado: true)
        self.pokemonsNaoCapturados = coreData.recuperarTodosPokemonsCapturados(capturado: false)
        
        setupView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Capturados"
        }else{
            return "Não Capturados"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return pokemonsCapturados.count
        }else{
            return pokemonsNaoCapturados.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemon: Pokemon
        if indexPath.section == 0 {
            pokemon = self.pokemonsCapturados[indexPath.row]
        }else{
            pokemon = self.pokemonsNaoCapturados[indexPath.row]
        }
        
        
        let celula = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: PokeAgendaViewCell.indentifier)
        celula.imageView?.image = UIImage(named: pokemon.nomeImagem!)
        celula.textLabel?.text = pokemon.nome
        
        return celula
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        view.addSubview(pokemonsTableView)
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pokemonsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            pokemonsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//extension PokedexViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 20
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: PokeAgendaViewCell.indentifier, for: indexPath)
//        
//        return cell
//    }
//}
