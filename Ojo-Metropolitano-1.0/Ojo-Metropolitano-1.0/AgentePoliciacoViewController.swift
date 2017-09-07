//
//  AgentePoliciacoViewController.swift
//  Ojo-Metropolitano-1.0
//
//  Created by Octavio Ernesto Romo Rodríguez on /39/17.
//  Copyright © 2017 Silicon Bear. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AgentePoliciacoViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var BotonLevantarDenuncia: UIButton!
    @IBOutlet weak var BotonMisDenuncias: UIButton!
    @IBOutlet weak var BotonSeguimientoDenuncia: UIButton!
    @IBOutlet weak var BotonCancelarDenuncia: UIButton!
    
    
    //++++++++++++++++++++++++++++++++ Ubicar usuario ++++++++++++++++++++++++++++++++
    
    var PosicionUsuario_CoordenadaX:Double = 0
    var PosicionUsuario_CoordenadaY:Double = 0
    
    let locationManager = CLLocationManager()
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("CAMBIO DE POSICION")
        
        let userLocation:CLLocationCoordinate2D = (manager.location?.coordinate)!
        print("Coordenada X = \(userLocation.latitude)")
        print("Coordenada Y = \(userLocation.longitude)")
        
        PosicionUsuario_CoordenadaX = userLocation.latitude
        PosicionUsuario_CoordenadaY = userLocation.longitude
    }
    
    //-------------------------------- Ubicar usuario --------------------------------
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Redondea botones de Denuncias:
        BotonLevantarDenuncia.layer.cornerRadius = 15
        BotonMisDenuncias.layer.cornerRadius = 15
        BotonSeguimientoDenuncia.layer.cornerRadius = 15
        BotonCancelarDenuncia.layer.cornerRadius = 15
        
        // Redondea esquinas de UIView:
        ViewDenuncias.roundCorners(corners: [.topRight, .bottomLeft], radius: 30)
        ViewBotonDePanico.roundCorners(corners: [.topRight, .bottomLeft], radius: 30)
        
        
        //++++++++++++++++++++++++++++++++ Ubicar usuario ++++++++++++++++++++++++++++++++
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //-------------------------------- Ubicar usuario --------------------------------
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var BotonDePanico: UIButton!
    
    
    @IBOutlet weak var ViewDenuncias: UIView!
    @IBOutlet weak var ViewBotonDePanico: UIView!
    
    
    
    @IBAction func mySegmentedControlIndexChanged(_ sender: Any) {
        
        switch mySegmentedControl.selectedSegmentIndex
        {
        case 0:
            /*
            print("Panico");
            Denuncias.isHidden = true;
            BotonDePanico.isHidden = false;
            */
            ViewBotonDePanico.isHidden = false;
            ViewDenuncias.isHidden = true;
        case 1:
            /*
            print("Denuncias");
            Denuncias.isHidden = false;
            BotonDePanico.isHidden = true;
            */
            ViewBotonDePanico.isHidden = true;
            ViewDenuncias.isHidden = false;
        default:
            break
        }
    }
    
    
    @IBAction func BotonDePanicoPresionado(_ sender: Any) {
        
        showAlert(titulo: "Alerta enviada", mensaje: "Se ha comunicado a las autoridades.", tiempo: 3.0)
        
        print("Posicion del usuario:")
        print(PosicionUsuario_CoordenadaX)
        print(PosicionUsuario_CoordenadaY)
        
        EnviarSolicitudAuxilio()
    }
    
    
    //++++++++++++++++++++++++++++++++ Mensaje PopUp ++++++++++++++++++++++++++++++++
    var alert:UIAlertController!
    
    func showAlert(titulo:String, mensaje:String, tiempo:Double)
    {
        self.alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertControllerStyle.alert)
        self.present(self.alert, animated: true, completion: nil)
        Timer.scheduledTimer(timeInterval: tiempo, target: self, selector: #selector(AgentePoliciacoViewController.dismissAlert), userInfo: nil, repeats: false)
    }
    
    func dismissAlert()
    {
        // Dismiss the alert from here
        self.alert.dismiss(animated: true, completion: nil)
    }
    //-------------------------------- Mensaje PopUp --------------------------------
    
    
    
    //++++++++++++++++++++++++++++++++ Enviar alerta ++++++++++++++++++++++++++++++++
    func EnviarSolicitudAuxilio()
    {
        let PosUsuarioCoordenadaX:String = String(format:"%f", PosicionUsuario_CoordenadaX)
        let PosUsuarioCoordenadaY:String = String(format:"%f", PosicionUsuario_CoordenadaY)
        
        
        // Formando la url:
        //let script = "http://siliconbear.mx/centinela/SOLPAT.php?"                                      //URL GLOBAL
        let script = "http://192.168.1.188/centinela/SOLPAT.php?"                                         //URL LOCAL
        let idUsu  = "solicitante=" + Usuario_id
        let coordX = "&coordx=" + PosUsuarioCoordenadaX
        let coordY = "&coordy=" + PosUsuarioCoordenadaY
        let urlString = script  + idUsu + coordX + coordY
        print(urlString)
        
    
        // Peticion de url:
        let url = URL(string: urlString)
    
        let taskINISES = URLSession.shared.dataTask(with: url!) { (data, response, error) in
        
            if(error != nil)
            {
                
                // Error al conectarse:
                print("Error al enviar la alerta")
            
                /*
                let alert = UIAlertController(title: "¡Corre por tu vida!", message: "No se ha podido enviar la alerta. Por favor, revise su conexión a internet.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Entendido", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                */
                
                
                //self.showAlert(titulo: "¡Corre por tu vida!", mensaje: "No se ha podido enviar la alerta", tiempo: 3)
            }
            else
            {
                print("ALERTA ENVIADA")
                //self.showAlert(titulo: "Alerta enviada", mensaje: "Se ha dado aviso a las autoridades", tiempo: 3)
            }
        
        }//task
    
        //Ejecuta peticion de url:
        taskINISES.resume()
    }
    //-------------------------------- Enviar alerta --------------------------------
    
    
    
    
    
    
    
    
    
    

}



//++++++++++++++++++++++++++++++++ Redondea esquinas de UIView ++++++++++++++++++++++++++++++++

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

//-------------------------------- Redondea esquinas de UIView --------------------------------




