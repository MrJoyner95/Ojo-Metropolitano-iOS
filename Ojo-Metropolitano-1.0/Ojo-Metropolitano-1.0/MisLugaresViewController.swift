//
//  MisLugaresViewController.swift
//  Ojo-Metropolitano-1.0
//
//  Created by Octavio Ernesto Romo Rodríguez on /39/17.
//  Copyright © 2017 Silicon Bear. All rights reserved.
//

import UIKit
import MapKit

//******** LAS ANOTACIONES EN EL MAPA NO SE CARGAN AL ABRIR EL VIEW, HASTA LA SEGUNDA VEZ QUE SE MUESTRA

class MisLugaresViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //**************** Variables Locales ****************
    struct LugarMarcado {
        var id_lugar: String
        var estado_lugar: String
        var nombre_lugar: String
        var coordx_lugar: String
        var coordy_lugar: String
    }
    
    var MisLugaresMarcados: [LugarMarcado] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Mis funciones:
        ObtenerMisLugares()
        InicializarMapa()
        //CargarMisLugaresMarcados_Mapa()
        
        print("INICIA TIEMPO")
        delayWithSeconds(3) {
            print("TERMINA TIEMPO")
            
            self.CargarMisLugaresMarcados_Mapa()
            
            // Agrega elemento vacío al array para tener el botón de agregar:
            self.MisLugaresMarcados.append(LugarMarcado(id_lugar: " ", estado_lugar: " ", nombre_lugar: " ", coordx_lugar: " ", coordy_lugar: " "))
            
            self.myCollectionView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //print(MisLugaresMarcados.count)
        //CargarMisLugaresMarcados_Mapa()
        
        
        
    }
    
    /*
    override func viewDidAppear(_ animated: Bool) {
        // Se ejecuta CADA VEZ que aparezca el viewController
    }
    */
    
    

    
    func ObtenerMisLugares()
    {
        // Variables locales:
        var respuestaServidor: String = ""
        var lugarDevuelto: String = ""

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
                
                self.MisLugaresMarcados.removeAll() // Reinicia lista de mis lugares
                
                let respuestaServidor_Separada = respuestaServidor.components(separatedBy: "|")
                
                for parteRespuesta in respuestaServidor_Separada
                {
                    //print("ENTRO A FOR")
                    
                    lugarDevuelto = parteRespuesta
                    //print(lugarDevuelto)
                    
                    if(lugarDevuelto.characters.count > 10)
                    {
                        var parteLugar = lugarDevuelto.components(separatedBy: "~")
                        
                        // Quitando espacios de id y coordenadas:          Es una extension en LoginView
                        parteLugar[0] = parteLugar[0].removingWhitespaces()
                        parteLugar[3] = parteLugar[3].removingWhitespaces()
                        parteLugar[4] = parteLugar[4].removingWhitespaces()
                        
                    
                        self.MisLugaresMarcados.append(LugarMarcado(id_lugar: parteLugar[0], estado_lugar: parteLugar[1], nombre_lugar: parteLugar[2], coordx_lugar: parteLugar[3], coordy_lugar: parteLugar[4]))
                    }
                        
                }
                
                if(self.MisLugaresMarcados.count > 0)
                {
                    self.MisLugaresMarcados.removeFirst() // Para quitar primera parte de la respuesta
                    
                    print("Total de lugares:")
                    print(self.MisLugaresMarcados.count)
                }
                else
                {
                    print("NO SE OBTUVIERON LUGARES")
                }
                
                for lugar in self.MisLugaresMarcados
                {
                    print("id_lugar     = " + lugar.id_lugar)
                    print("estado_lugar = " + lugar.estado_lugar)
                    print("nombre_lugar = " + lugar.nombre_lugar)
                    print("coordx_lugar = " + lugar.coordx_lugar)
                    print("coordy_lugar = " + lugar.coordy_lugar)
                }
                
                
                
            }
                
        }//task
            
        //Ejecuta peticion de url:
        taskINISES.resume()
        
        
        
    }//funcion ObtenerMisLugares()
    
    @IBOutlet weak var labelLugarSeleccionado: UILabel!
    
    @IBAction func buttonEliminar(_ sender: Any) {
        
        EliminarLugar()
        
        MisLugaresMarcados.remove(at: IndiceLugarSeleccionado)
        myCollectionView.reloadData()
        labelLugarSeleccionado.isHidden = true
        buttonEliminarOutlet.isHidden = true
    }
    
    @IBOutlet weak var buttonEliminarOutlet: UIButton!
    var IndiceLugarSeleccionado = 0
    
    func EliminarLugar()
    {
        
        
        print("Eliminando elemento:")
        print(IndiceLugarSeleccionado)
        
        print("id_lugar     = " + MisLugaresMarcados[IndiceLugarSeleccionado].id_lugar)
        print("estado_lugar = " + MisLugaresMarcados[IndiceLugarSeleccionado].estado_lugar)
        print("nombre_lugar = " + MisLugaresMarcados[IndiceLugarSeleccionado].nombre_lugar)
        print("coordx_lugar = " + MisLugaresMarcados[IndiceLugarSeleccionado].coordx_lugar)
        print("coordy_lugar = " + MisLugaresMarcados[IndiceLugarSeleccionado].coordy_lugar)
        
        
        // Formando la url:
        //let script = "http://siliconbear.mx/flumina/ELILUG.php?"                                      //URL GLOBAL
        let script = "http://192.168.1.188/flumina/ELILUG.php?"                                         //URL LOCAL
        let nomusu = "nomusu="  + Usuario_nombreUsuario
        let cont   = "&contra=" + Usuario_contrasena
        let cel    = "&cel="    + Usuario_celular
        let idLug  = "&idlug="  + MisLugaresMarcados[IndiceLugarSeleccionado].id_lugar
        let urlString = script  + nomusu + cont + cel + idLug
        print(urlString)
        
        
        
        // Peticion de url:
        let url = URL(string: urlString)
        
        let taskINISES = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if(error != nil)
            {
                // Error al conectarse:
                print("Error al eliminar")
                
                //******************************** AGREGAR VARIABLE INDICANDO FALLO? AQUI ********************************
                
                let alert = UIAlertController(title: "¡Qué pena!, hubo un error...", message: "No se ha podido eliminar el lugar. Por favor, verifique su conexión a internet e intente de nuevo.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Entendido", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                print("LUGAR ELIMINADO")
            }
            
        }//task
        
        //Ejecuta peticion de url:
        taskINISES.resume()
        
        
    }
    
    
    //++++++++++++++++++++++++++++++++ Código de CollectionView ++++++++++++++++++++++++++++++++
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MisLugaresMarcados.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.CellImage.image = UIImage.init(named: "MisLugares_iconoLugarCasa")
        cell.CellLabel.text = MisLugaresMarcados[indexPath.row].nombre_lugar
        
        // Para el boton de agregar:
        if(indexPath.row == MisLugaresMarcados.count - 1)
        {
            cell.CellImage.image = UIImage.init(named: "MisLugares_iconoAgregarLugar")
            cell.CellLabel.text = "Agregar lugar"
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Index Seleccionado:")
        print(indexPath)
        
        print(MisLugaresMarcados[indexPath.row].nombre_lugar)
        
        
        
        if(indexPath.row == MisLugaresMarcados.count - 1)
        {
            print("AGREGAR LUGAR")
            
            buttonEliminarOutlet.isHidden = true
            labelLugarSeleccionado.isHidden = true
        }
        else
        {
            MoverMapa(longitud: Double(MisLugaresMarcados[indexPath.row].coordx_lugar)!, latitud: Double(MisLugaresMarcados[indexPath.row].coordy_lugar)!)
            
            buttonEliminarOutlet.isHidden = false
            IndiceLugarSeleccionado = indexPath.row
            
            labelLugarSeleccionado.isHidden = false
            labelLugarSeleccionado.text = MisLugaresMarcados[IndiceLugarSeleccionado].nombre_lugar
        }
        
        //let cell:UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        //cell.layer.cornerRadius = 50
        //cell.backgroundColor = UIColor.red
    }
    
    
    /*
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell:UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        cell.layer.cornerRadius = 50
        cell.backgroundColor = UIColor.red
    }
    */
    
   
    //-------------------------------- Código de CollectionView --------------------------------
    
    
    
    
    //++++++++++++++++++++++++++++++++ Código de MapKit ++++++++++++++++++++++++++++++++
    
    @IBOutlet weak var MyMap: MKMapView!
    
    func InicializarMapa()
    {
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)                                  // Zoom del mapa
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(20.677134, -103.346941)    // Localizacion
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        MyMap.setRegion(region, animated: true)
    }
    
    
    func CargarMisLugaresMarcados_Mapa()
    {
        // Quita todas las anotaciones
        let allAnnotations = self.MyMap.annotations
        self.MyMap.removeAnnotations(allAnnotations)
        
        for lugar in MisLugaresMarcados
        {
            //print("Cargando lugar = " + lugar.id_lugar)
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2DMake(Double(lugar.coordx_lugar)!, Double(lugar.coordy_lugar)!)
            annotation.title = lugar.nombre_lugar
            annotation.subtitle = lugar.id_lugar
            MyMap.addAnnotation(annotation)
        }
    }
    
    
    func MoverMapa(longitud:Double, latitud:Double)
    {
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)                                // Zoom del mapa
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(longitud, latitud)    // Localizacion
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        MyMap.setRegion(region, animated: true)
    }
    
    //-------------------------------- Código de MapKit --------------------------------
    
    
    
    //++++++++++++++++++++++++++++++++ Funcion para retrasar segundos ++++++++++++++++++++++++++++++++
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    //-------------------------------- Funcion para retrasar segundos --------------------------------
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
