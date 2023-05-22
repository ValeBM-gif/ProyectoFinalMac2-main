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
    @objc dynamic var productoLog:[ProductoModelo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cerrarViewController(_ sender: NSButton) {
        dismiss(self)
    }
    
}
