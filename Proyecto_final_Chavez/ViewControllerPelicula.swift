//
//  ViewControllerPelicula.swift
//  Proyecto_final_Chavez
//
//  Created by Karen on 11/25/18.
//  Copyright © 2018 Antonio. All rights reserved.
//

import UIKit

class ViewControllerPelicula: UIViewController {

    @IBOutlet weak var lblTitulo: UILabel!
    
    @IBOutlet weak var lblGenero: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblSinopsis: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitulo.text = pelicula?.nombre
        lblGenero.text = pelicula?.genero
        lblSinopsis.text = pelicula?.sinopsis
        
        let session = URLSession(configuration: .default)
        
        let URLImagen = URL(string: (pelicula?.ruta_imagen)!)
        
        let downloadPicTask = session.dataTask(with: URLImagen!){(data, response, error) in
            if let e = error{
                print("Error")
            }
            else{
                if let res = response as? HTTPURLResponse{
                    if let imageData = data{
                        let image = UIImage(data: imageData)
                        self.imgView.image = image
                    }
                }
            }
        }
        
        downloadPicTask.resume()
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


