//
//  LoginViewController.swift
//  Ojo-Metropolitano-1.0
//
//  Created by Octavio Ernesto Romo Rodríguez on /39/17.
//  Copyright © 2017 Silicon Bear. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var textField_NombreUsuario: UITextField!
    @IBOutlet weak var textField_Contra: UITextField!
    @IBOutlet weak var button_IniciarSesion: UIButton!
    @IBOutlet weak var button_Registrarse: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //++++++++++++++++ Arreglos esteticos botones y textFields ++++++++++++++++
        textField_NombreUsuario.layer.cornerRadius = 15;
        textField_Contra.layer.cornerRadius = 15;
        button_IniciarSesion.layer.cornerRadius = 20;
        button_Registrarse.layer.cornerRadius = 20;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
