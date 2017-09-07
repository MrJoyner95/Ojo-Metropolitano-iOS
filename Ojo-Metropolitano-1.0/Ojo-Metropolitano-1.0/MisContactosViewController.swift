//
//  MisContactosViewController.swift
//  Ojo-Metropolitano-1.0
//
//  Created by Octavio Ernesto Romo Rodríguez on /39/17.
//  Copyright © 2017 Silicon Bear. All rights reserved.
//

import UIKit

class MisContactosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var usuarios = ["Delta", "Joyner", "Jesus", "katy"]
    var nombre = ["Bacilio González López", "Octavio Ernesto Romo Rodríguez", "Jesús Reynaga Rodríguez", "Karen Alin Galarza Jiménez"]
    var parentesco = ["Amigo", "Primo", "Vecino", "Amiga"]
    var perfil = [UIImage(named: "rostro1"),UIImage(named: "rostro2"),UIImage(named: "rostro3"),UIImage(named: "rostro4")]
    
    var arrayGroups = [UIImage(named: "grupo1"),UIImage(named: "grupo2"),UIImage(named: "grupo3"),UIImage(named: "grupo4"),UIImage(named: "grupo5")]
    var nomGrupo = ["Casa","Trabajo","Escuela","GYM","Otros"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GrupsCollection", for: indexPath) as! GrupsCollectionViewCell
        
        cell.imgImagen.image = arrayGroups[indexPath.row]
        cell.etiqueta.text = nomGrupo[indexPath.row]
        
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        cell.imagen.image = perfil[indexPath.row]
        cell.usuario.text = usuarios[indexPath.row]
        cell.nombre.text = nombre[indexPath.row]
        cell.parentesco.text = parentesco[indexPath.row]
        
        return cell
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
