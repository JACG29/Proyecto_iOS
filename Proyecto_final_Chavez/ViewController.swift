//
//  ViewController.swift
//  Proyecto_final_Chavez
//
//  Created by Karen on 11/24/18.
//  Copyright © 2018 Antonio. All rights reserved.
//

import UIKit
var usuarios:[Usuario] = []
var usuindex = 0
class ViewController: UIViewController {
    @IBOutlet weak var txtUsu: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func iniciarsesion(_ sender: Any) {
        var noencontrado = false;
    
        for usu in usuarios{
            if (usu.usuario == txtUsu.text) && (usu.password == txtPass.text ){
                let alerta=UIAlertController(title: "Bienvenido " + usu.usuario, message: "Acceso correcto", preferredStyle: UIAlertControllerStyle.alert)
                alerta.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: {(action) in self.performSegue(withIdentifier: "menu", sender: self)}))
                present(alerta, animated: true, completion: nil)
            }
            else{
                usuindex = usuindex + 1
            }
            
        }
        noencontrado = true;
        
        if((txtUsu.text?.isEmpty)! || (txtPass.text?.isEmpty)!){
            let alerta=UIAlertController(title: "Error", message: "Ingrese usuario y/o password", preferredStyle: UIAlertControllerStyle.alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alerta, animated: true, completion: nil)
        }
        
        if(noencontrado == true){
            let alerta=UIAlertController(title: "Error", message: "Usuario incorrecto", preferredStyle: UIAlertControllerStyle.alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alerta, animated: true, completion: nil)
        }
        
}
    @IBAction func registrar(_ sender: Any) {
        self.performSegue(withIdentifier: "registro", sender: self)
    }
    
    
    
}

class Usuario{
    
    var usuario = String()
    var password = String()
    var sexo = String()
    var edad = Int32()
    var imagen = UIImage()
    
    init(usuario: String, password: String,sexo: String,edad: Int32, imagen: UIImage) {
        self.usuario = usuario
        self.password = password
        self.sexo = sexo
        self.edad = edad
        self.imagen = imagen
    }
}
