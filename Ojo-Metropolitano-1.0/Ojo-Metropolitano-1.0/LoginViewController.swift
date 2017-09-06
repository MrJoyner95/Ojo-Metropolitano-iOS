//
//  LoginViewController.swift
//  Ojo-Metropolitano-1.0
//
//  Created by Octavio Ernesto Romo Rodríguez on /39/17.
//  Copyright © 2017 Silicon Bear. All rights reserved.
//


// NOTAS:
// Hace falta detener el segue cuando no se pueda conectar al servidor y cuando no se loguee correctamente


import UIKit

//++++++++++++++++ Variables Globales del Usuario ++++++++++++++++
var Usuario_nombreUsuario = ""
var Usuario_contrasena = ""
var Usuario_id = ""
var Usuario_correo = ""
var Usuario_nombres = ""
var Usuario_apellidoP = ""
var Usuario_apellidoM = ""


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

    
    var nombreDeUsuario:String = ""
    var contrasena:String = ""
    
    
    @IBAction func Boton_IniciarSesion(_ sender: Any)
    {
        nombreDeUsuario = textField_NombreUsuario.text!
        contrasena = textField_Contra.text!
        
        IniciarSesion(nombreUsuario: nombreDeUsuario, contra: contrasena)
    }
    
    
    func IniciarSesion(nombreUsuario:String, contra:String)
    {
        // Variables locales:
        var respuestaServidor:String = ""
        var datosUsuario = ""
        
        // Formando la url:
        //let script = "http://siliconbear.mx/flumina/INISES.php?"                    //URL GLOBAL
        let script = "http://192.168.1.188/flumina/INISES.php?"                               //URL LOCAL
        let nomusu = "nomusu=" + nombreUsuario
        let cont   = "&contra=" + contra
        let ubica  = "&ubiact=20.6646888,-103.3314888"
        let urlString = script + nomusu + cont + ubica
        print(urlString)
        
        // Peticion de url:
        let url = URL(string: urlString)
        
        if(textField_NombreUsuario.text?.characters.count == 0 || textField_Contra.text?.characters.count == 0)
        {
            // create the alert
            let alert = UIAlertController(title: "Campos vacíos", message: "Por favor, ingrese nombre de usuario y contraseña.", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "Entendido", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            //************************************ DEBE ESPERAR A QUE SE COMPLETE LA TAREA Y DECIDIR SI MUESTRA LA PAGINA DE INICIO O NO ************
            
            let taskINISES = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                
                if(error != nil)
                {
                    // Error al conectarse:
                    print("Error al conectarse al servidor")
                    
                    //******************************** DETENER SEGUE AQUI ********************************
                    
                    let alert = UIAlertController(title: "Error de conexión con el servidor", message: "No se ha podido conectar con el servidor. Por favor, verifique su conexión a internet e intente de nuevo.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Entendido", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    print("******** DATOS OBTENIDOS ******")
                    let htmlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    respuestaServidor = htmlContent! as String;
                
                    // Verifica tamaño del string:
                    if(respuestaServidor.characters.count > 10)
                    {
                        //print("respuesta del servidor:" + respuestaServidor)
                        // Separa string de respuesta:
                        let respuestaServidor_Separada = respuestaServidor.components(separatedBy: "|")
                    
                        for parteRespuesta in respuestaServidor_Separada
                        {
                    
                            if(parteRespuesta.characters.count > 10)
                            {
                                datosUsuario = parteRespuesta
                                print(datosUsuario)
                            }
                        }
                    
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
                        
                        
                        // Quitando espacios de variables importantes:          Es una extension hasta abajo
                        Usuario_id = Usuario_id.removingWhitespaces()
                        Usuario_correo = Usuario_correo.removingWhitespaces()
                        
                        
                        print("Nombre de usuario: " + Usuario_nombreUsuario)
                        print("Contraseña:        " + Usuario_contrasena)
                        print("ID:                " + Usuario_id)
                        print("Correo:            " + Usuario_correo)
                        print("Nombres:           " + Usuario_nombres)
                        print("Apellido paterno:  " + Usuario_apellidoP)
                        print("Apellido materno:  " + Usuario_apellidoM)
                    
                        //******************************** EJECUTAR SEGUE AQUI ********************************
                        // Ejecuta Segue
                        /////////////self.performSegue(withIdentifier: "Segue_Login-Inicio", sender: self)
                    }
                    else
                    {
                        // Error de autenticacion:
                        print("ERROR DE AUTENTICACION")
                        
                        //******************************** DETENER SEGUE AQUI ********************************
                        
                        let alert = UIAlertController(title: "Error de autenticación", message: "El nombre de usuario y contraseña incorrectos. Por favor, verifíquelos.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Entendido", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                
                }
            
            }
            
            //Ejecuta peticion de url:
            taskINISES.resume()
        }
    }
    
    

    /*
    func QuitarEspaciosPRUEBA()
    {
        var stringLIMPIO: String = "hola A todos"
        stringLIMPIO = stringLIMPIO.removingWhitespaces()
        print("QuitarEspaciosPRUEBA() = " + stringLIMPIO)
    }
    */
    
    
    
    


}





extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}


