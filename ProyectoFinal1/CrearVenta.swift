//
//  CrearVenta.swift
//  ProyectoFinal1
//
//  Created by Uriel Resendiz on 07/05/23.
//

import Cocoa

class CrearVenta: NSViewController {
    
    @IBOutlet var vcVentas: ViewController!
    @objc dynamic var ventasLog:[VentaModelo] = []
    var idUsuarioActual:Int!
   
    override func viewDidLoad() {
       
        ventasLog.append(VentaModelo(idVenta: 1, idVendedor: 1, idCliente: 1, idProducto: 2, cantidad: 1, precioProducto: 100, totalProducto: 200, subtotalVenta: 100, ivaVenta: 10, totalVenta: 300))
        
        super.viewDidLoad()
        
    }
}
