//
//  ViewControllerPerfil.swift
//  Proyecto_final_Chavez
//
//  Created by Karen on 11/25/18.
//  Copyright © 2018 Antonio. All rights reserved.
//

import UIKit

class ViewControllerPerfil: UIViewController {
    
    var usuario: Usuario?
    
    
    @IBOutlet weak var imgView: UIImageView!
    var img: UIImage!
    var imagePick = UIImagePickerController()
    
    @IBOutlet weak var txtUsu: UITextField!
    
    @IBOutlet weak var txtPass: UITextField!
    
    @IBOutlet weak var swtSexo: UISegmentedControl!
    
    @IBOutlet weak var lblEdad: UILabel!
    
    @IBOutlet weak var stpEdad: UIStepper!
    @IBAction func cambiarEdad(_ sender: UIStepper) {
        lblEdad.text = Int(sender.value).description
    }
    
    @IBAction func cambiarImagen(_ sender: Any) {
        imagePick.sourceType = .photoLibrary
        imagePick.allowsEditing = true
        imagePick.delegate = self
        present(imagePick, animated: true, completion: nil)
    }
    
    @IBAction func Actualizar(_ sender: Any) {
        var edad = Int(lblEdad.text!)!
        if(txtUsu.text?.isEmpty)!{
            let alerta=UIAlertController(title: "Error", message: "Ingrese usuario", preferredStyle: UIAlertControllerStyle.alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alerta, animated: true, completion: nil)
        }
        else if(txtPass.text?.isEmpty)!{
            let alerta=UIAlertController(title: "Error", message: "Ingrese password", preferredStyle: UIAlertControllerStyle.alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alerta, animated: true, completion: nil)
        }
        else if(edad < 0){
            let alerta=UIAlertController(title: "Error", message: "Edad no valida", preferredStyle: UIAlertControllerStyle.alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alerta, animated: true, completion: nil)
        }
        else{
            var sexo = "";
            if(swtSexo.selectedSegmentIndex == 0 ){
                sexo = "Masculino"
            }
            else{
                sexo = "Femenino"
            }
            
            usuarios[usuindex] = (Usuario(usuario:txtUsu.text!, password:txtPass.text! , sexo:sexo, edad:Int32(edad), imagen: self.img))
            let alerta=UIAlertController(title: "Datos actualizados", message: "Datos guardados correctamente", preferredStyle: UIAlertControllerStyle.alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alerta, animated: true, completion: nil)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        usuario = usuarios[usuindex]
        
        txtUsu.text = usuario?.usuario
        txtPass.text = usuario?.password
        lblEdad.text = usuario?.edad.description
        
        stpEdad.value = Double((usuario?.edad)!)
        
        if(usuario?.sexo == "Masculino"){
            swtSexo.selectedSegmentIndex = 0
        }
        else{
            swtSexo.selectedSegmentIndex = 1
        }
        
        imgView.image = usuario?.imagen
        img = usuario?.imagen
        
        // Do any additional setup after loading the view.
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
extension ViewControllerPerfil: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imgView.image = image
            img = image
        }
        dismiss(animated: true, completion: nil)
    }
}
