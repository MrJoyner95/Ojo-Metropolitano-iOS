//
//  MiCuentaViewController.swift
//  Ojo-Metropolitano-1.0
//
//  Created by Octavio Ernesto Romo Rodríguez on /39/17.
//  Copyright © 2017 Silicon Bear. All rights reserved.
//

import UIKit

class MiCuentaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for:.selected)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //++++++++++++++++++++++++ Cambia color de tab bar y mueve posicion al inicio ++++++++++++++++++++++++
    var PrimerCorrida = true;
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.tintColor = UIColor.red
        
        if(PrimerCorrida == true)
        {
            PrimerCorrida = false;
            self.tabBarController?.selectedIndex = 2;
        }
    }
    //------------------------ Cambia color de tab bar y mueve posicion al inicio ------------------------
    
    

}
