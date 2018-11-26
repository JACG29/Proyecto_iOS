//
//  TableViewController.swift
//  Proyecto_final_Chavez
//
//  Created by Karen on 11/25/18.
//  Copyright © 2018 Antonio. All rights reserved.
//

import UIKit
var pelicula: Pelicula?
class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tabla: UITableView!
    
    var peliculas = [Pelicula]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabla.dataSource = self
        tabla.delegate = self
        
        let urlString = "https://glassproject.com.mx/cucea2017/getPeliculas.php"
        
        let url = URL(string: urlString)
        
        let peticion = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //verificar si existe algun error
            if(error != nil){
                print("Error : \(String(describing: error))")
            } else {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String : AnyObject]]
                    print(json)
                    
                    //Llenado del contenedor local
                    
                    for peli in json{
                        let id = peli["id"] as! String
                        let nombre = peli["nombre"] as! String
                        let genero = peli["genero"] as! String
                        
                        let sinopsis = peli["sinopsis"] as! String
                        let ruta_imagen = peli["ruta_imagen"] as! String
                        
                        //Agregar la info al arreglo
                        self.peliculas.append(Pelicula(id: id, nombre: nombre, genero: genero, sinopsis: sinopsis, ruta_imagen: ruta_imagen))
                    }
                    
                    //refrescar la tabla
                    OperationQueue.main.addOperation {
                        self.tabla.reloadData()
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
        }
        
        peticion.resume()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peliculas.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda_pelicula")
        // 7 despues de construir la celda se coloca la informacion correspondiente a la fila que se esta mostrando
        celda?.textLabel?.text = peliculas[indexPath.row].nombre
        
        let session = URLSession(configuration: .default)
        
        let URLImagen = URL(string: peliculas[indexPath.row].ruta_imagen)!
        
        let downloadPicTask = session.dataTask(with: URLImagen){(data, response, error) in
            if let e = error{
                print("Error")
            }
            else{
                if let res = response as? HTTPURLResponse{
                    if let imageData = data{
                        let image = UIImage(data: imageData)
                        celda?.imageView?.image = image
                    }
                }
            }
        }
        
        downloadPicTask.resume()
        return celda!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pelicula = self.peliculas[indexPath.row]
        performSegue(withIdentifier: "detalle", sender: self)
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class Pelicula{
    var id: String
    var nombre: String
    var genero: String
    var sinopsis: String
    var ruta_imagen: String
    
    init(id: String, nombre: String, genero: String, sinopsis: String, ruta_imagen: String){
        self.id = id
        self.nombre = nombre
        self.genero = genero
        self.sinopsis = sinopsis
        self.ruta_imagen = ruta_imagen
    }
    
}
