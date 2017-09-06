//
//  MisLugaresViewController.swift
//  Ojo-Metropolitano-1.0
//
//  Created by Octavio Ernesto Romo Rodríguez on /39/17.
//  Copyright © 2017 Silicon Bear. All rights reserved.
//

import UIKit

class MisLugaresViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ObtenerMisLugares()
        print("CARGO")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    override func viewDidAppear(_ animated: Bool) {
        // Se ejecuta CADA VEZ que aparezca el viewController
    }
    */
    
    //**************** Variables Locales ****************
    struct LugarMarcado {
        var id_lugar: String
        var estado_lugar: String
        var nombre_lugar: String
        var coordx_lugar: String
        var coordy_lugar: String
    }
    
    var MisLugaresMarcados: [LugarMarcado] = []

    
    func ObtenerMisLugares()
    {
        // Variables locales:
        var respuestaServidor: String = ""
        var lugarDevuelto: String = ""
        
        
        
        //contacts.append(Person(name: "Jack", surname: "Johnson", phone: 2, isCustomer: false))
        

        // Formando la url:
        //let scriurlStringpt = "http://siliconbear.mx/flumina/MOSLUG.php?propi=" + Usuario_id                    //URL GLOBAL
        let urlString = "http://192.168.1.188/flumina/MOSLUG.php?propi=" + Usuario_id                            //URL LOCAL
        print(urlString)
        
        // Peticion de url:
        let url = URL(string: urlString)
        
        let taskINISES = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                
            if(error != nil)
            {
                // Error al conectarse:
                print("Error al conectarse al servidor")
                    
                //******************************** AGREGAR VARIABLE INDICANDO FALLO? AQUI ********************************
                
                let alert = UIAlertController(title: "Error de conexión con el servidor", message: "No se ha podido conectar con el servidor. Por favor, verifique su conexión a internet e intente de nuevo.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Entendido", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                print("******** DATOS OBTENIDOS ******")
                let htmlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                respuestaServidor = htmlContent! as String;
                
                let respuestaServidor_Separada = respuestaServidor.components(separatedBy: "|")
                
                for parteRespuesta in respuestaServidor_Separada
                {
                    print("ENTRO A FOR")
                    
                    lugarDevuelto = parteRespuesta
                    print(lugarDevuelto)
                    
                    if(lugarDevuelto.characters.count > 10)
                    {
                        let parteLugar = lugarDevuelto.components(separatedBy: "~")
                    
                        self.MisLugaresMarcados.append(LugarMarcado(id_lugar: parteLugar[0], estado_lugar: parteLugar[1], nombre_lugar: parteLugar[2], coordx_lugar: parteLugar[3], coordy_lugar: parteLugar[4]))
                    }
                        
                }
                
                self.MisLugaresMarcados.removeFirst()
                
                for lugar in self.MisLugaresMarcados
                {
                    print("id_lugar     = " + lugar.id_lugar)
                    print("estado_lugar = " + lugar.estado_lugar)
                    print("nombre_lugar = " + lugar.nombre_lugar)
                    print("coordx_lugar = " + lugar.coordx_lugar)
                    print("coordy_lugar = " + lugar.coordy_lugar)
                }
                
                //contacts.append(Person(name: "Jack", surname: "Johnson", phone: 2, isCustomer: false))
                
                /*
                // Separa datos del usuario:
                let datosUsuarioArray = datosUsuario.components(separatedBy: " ~ ")
                        
                // Asigna datos del usuario a variables globales:
                Usuario_nombreUsuario = nombreUsuario;
                Usuario_contrasena    = contra;
                Usuario_id            = datosUsuarioArray[0]
                Usuario_correo        = datosUsuarioArray[1]
                Usuario_nombres       = datosUsuarioArray[2]
                Usuario_apellidoP     = datosUsuarioArray[3]
                Usuario_apellidoM     = datosUsuarioArray[4]
                        
                        
                print("Nombre de usuario: " + Usuario_nombreUsuario)
                print("Contraseña:        " + Usuario_contrasena)
                print("ID:                " + Usuario_id)
                print("Correo:            " + Usuario_correo)
                print("Nombres:           " + Usuario_nombres)
                print("Apellido paterno:  " + Usuario_apellidoP)
                print("Apellido materno:  " + Usuario_apellidoM)
                */
                
            }
                
        }//task
            
        //Ejecuta peticion de url:
        taskINISES.resume()
        
    }//funcion
        
        
        
        
        
        
    

}
