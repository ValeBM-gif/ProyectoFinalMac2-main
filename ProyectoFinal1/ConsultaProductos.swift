//
//  ConsultaProductos.swift
//  ProyectoFinal1
//
//  Created by Valeria Baeza on 21/05/23.
//

import Cocoa

class ConsultaProductos: NSViewController {
    
    @IBOutlet weak var imgAvatar: NSImageView!
    
    @IBOutlet weak var tablaProductos: NSTableView!
    @IBOutlet var vcTabla: ViewController!
    
    //productos tiene los valores del productosLog del ViewController de MenuCompras
    @objc dynamic var productos:[ProductoModelo] = []
    
    //productoLog es el temporal
    @objc dynamic var productoLog:[ProductoModelo] = []
    @IBOutlet weak var lblError: NSTextField!
    
    override func viewDidLoad() {
        obtenerProductos()
        super.viewDidLoad()
        lblError.isHidden = true
        
        vcTabla.cambiarImagenYFondo(idUsuarioActual: vcTabla.idUsuarioActual, imgAvatar: imgAvatar, view: self.view)
    }
    

    
    func obtenerProductos(){
        for i in 1..<productos.count{
            productoLog.append(productos[i])
            print(productos[i].id)
        }
    }
    
    
    @IBAction func eliminarProducto(_ sender: NSButton) {
        let selectedRow = tablaProductos.selectedRow
        
        if selectedRow >= 0 {
            
            print("valor de selected row ",selectedRow)
            print("producto a eliminar",productos[selectedRow+1].nombre)
            
            productos.remove(at: calcularIdDeProductoDeRowSeleccionada(i: selectedRow+1))
            
            print("productoLog a eliminar",productoLog[selectedRow].nombre)
            productoLog.remove(at: calcularIdDeProductoDeRowSeleccionada(i: selectedRow+1)-1)
       
            tablaProductos.reloadData()
            
            lblError.isHidden = true;
            
        }else{
            lblError.isHidden=false;
            return
        }
    
    }
    
    func calcularIdDeProductoDeRowSeleccionada(i:Int)->Int{
        var idProductoSeleccionado:Int = 0
        idProductoSeleccionado = productos[i].id
        return idProductoSeleccionado
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
