//
//  PokedexViewController.swift
//  PokemonGo
//
//  Created by Maria Cutipa on 17/06/24.
//

import UIKit

class PokedexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var pokemonsAtrapados:[Pokemon] = []
    var pokemonsNoAtrapados:[Pokemon] = []
    
    @IBAction func mapTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        pokemonsAtrapados = obtenerPokemonsAtrapados()
        pokemonsNoAtrapados = obtenerPokemonsNoAtrapados()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemon: Pokemon
        if indexPath.section == 0 {
            pokemon = pokemonsAtrapados[indexPath.row]
        } else {
            pokemon = pokemonsNoAtrapados[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellA", for: indexPath)
        
        cell.textLabel?.text = pokemon.nombre
        cell.imageView?.image = UIImage(named: pokemon.imagenNombre!)
        let cantidadString = "\(pokemon.cantidad)"
        cell.detailTextLabel?.text = cantidadString
        return cell
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return pokemonsAtrapados.count
        }else{
            return pokemonsNoAtrapados.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Atrapados"
        }else{
            return "No Atrapados"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemon: Pokemon
            if indexPath.section == 0 {
                pokemon = pokemonsAtrapados[indexPath.row]
                pokemonsAtrapados.remove(at: indexPath.row)
            } else {
                pokemon = pokemonsNoAtrapados[indexPath.row]
                pokemonsNoAtrapados.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            pokemon.atrapado = false
            (UIApplication.shared.delegate as! AppDelegate).saveContext()  
        }
    }

    
}
