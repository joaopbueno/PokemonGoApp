//
//  CoreDataPokemon.swift
//  PokemonGoApp
//
//  Created by João Bueno on 25/10/24.
//


import UIKit
import CoreData

class CoreDataPokemon {
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        return context!
    }

    
    func adicionarTodosPokemons() {
        let context = self.getContext()
        
        self.criarPokemon(nome: "Mew", nomeImagem: "mew", capturado: false)
        self.criarPokemon(nome: "Pikachu", nomeImagem: "pikachu", capturado: true)
        self.criarPokemon(nome: "Charmander", nomeImagem: "charmander", capturado: false)
        self.criarPokemon(nome: "Squirtle", nomeImagem: "squirtle", capturado: false)
        self.criarPokemon(nome: "Bulbasaur", nomeImagem: "bulbasaur", capturado: false)
        self.criarPokemon(nome: "Eevee", nomeImagem: "eevee", capturado: false)
        
        do {
            try context.save()
        } catch {
            print("Erro ao salvar context: \(error)")
        }
    }
    func criarPokemon(nome: String, nomeImagem: String, capturado: Bool) {
        let context = self.getContext()
        let pokemon = Pokemon(context: context)
        pokemon.nome = nome
        pokemon.nomeImagem = nomeImagem
        pokemon.capturado = capturado
    }
    
    
    func recuperarTodosOsPokemons() -> [Pokemon]{
        let context = self.getContext()
        
        do{
            let pokemons = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
            
            if pokemons.count == 0 {
                self.adicionarTodosPokemons()
                return self.recuperarTodosOsPokemons()
            }
            
            return pokemons
        }catch {
            
        }
        return []
    }
}
