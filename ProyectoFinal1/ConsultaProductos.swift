//
//  ConsultaProductos.swift
//  ProyectoFinal1
//
//  Created by Valeria Baeza on 21/05/23.
//

import Cocoa

class ConsultaProductos: NSViewController {
    
    //TODO: muestre productos
    //TODO: elimine productos

    @IBOutlet var vcTabla: ViewController!
    @objc dynamic var productos:[ProductoModelo] = []
    @objc dynamic var productoLog:[ProductoModelo] = []
    
    override func viewDidLoad() {
        obtenerProductos()
        super.viewDidLoad()

    }
    
    func obtenerProductos(){
        for i in 1..<productos.count{
            productoLog.append(productos[i])
        }
    }
    @IBAction func cerrarViewController(_ sender: NSButton) {
        dismiss(self)
    }
    
}
