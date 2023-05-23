//
//  ConsultaProductos.swift
//  ProyectoFinal1
//
//  Created by Valeria Baeza on 21/05/23.
//

import Cocoa

class ConsultaProductos: NSViewController {
    

    @IBOutlet weak var tablaProductos: NSTableView!
    @IBOutlet var vcTabla: ViewController!
    @objc dynamic var productos:[ProductoModelo] = []
    @objc dynamic var productoLog:[ProductoModelo] = []
    @IBOutlet weak var lblError: NSTextField!
    
    override func viewDidLoad() {
        obtenerProductos()
        super.viewDidLoad()
        lblError.isHidden = true
    }
    
    func obtenerProductos(){
        for i in 1..<productos.count{
            productoLog.append(productos[i])
        }
    }
    
    
    @IBAction func eliminarProducto(_ sender: NSButton) {
       
            let selectedRow = tablaProductos.selectedRow
        
        if selectedRow >= 0 {
            
            productos.remove(at: selectedRow+1)
            productoLog.remove(at: selectedRow)
       
            tablaProductos.reloadData()
            
            lblError.isHidden = true;
            
            }
        else{
            lblError.isHidden=false;
            return
        }
    

    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier=="regresarAMenuCompras"{
            (segue.destinationController as! MenuCompras).vc = vcTabla
            (segue.destinationController as! MenuCompras).vc.productoLog = productos
            
        }
    }
    
    @IBAction func cerrarViewController(_ sender: NSButton) {
        performSegue(withIdentifier: "regresarAMenuCompras", sender: self)
        dismiss(self)
    }
    
}
