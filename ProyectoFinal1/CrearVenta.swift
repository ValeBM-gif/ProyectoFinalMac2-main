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
    @IBOutlet weak var btnAgregarVenta: NSButton!
    
    //TO DO: Funcionalidad de agregar venta a partir de un botón
    //TO DO: NO SE PUEDE REPETIR ID DE VENTA
    //TO DO: CONECTAR VENTAS A PEDIDOS PARA QUE EL CLIENTE TENGA ACCESO
   
    override func viewDidLoad() {
       
        ventasLog.append(VentaModelo(idVenta: 1, idVendedor: 1, idCliente: 1, idProducto: 2, cantidad: 1, precioProducto: 100, totalProducto: 0, subtotalVenta: 0, ivaVenta: 10, totalVenta: 0))
        
        super.viewDidLoad()
        
    }
    
    @IBAction func agregarVenta(_ sender: NSButton) {
        ventasLog.append(VentaModelo(idVenta: 10, idVendedor: 1, idCliente: 1, idProducto: 2, cantidad: 1, precioProducto: 100, totalProducto: 0, subtotalVenta: 0, ivaVenta: 10, totalVenta: 0))
    }
    
    func calcularTotalProducto(){
        //cantidad*precioProducto
    }
    
    func calcularTotalVenta(){
      //Se compara el id de venta actual para encontrar todos los productos de la venta, se suman todos los totalesProductos y se obtiene totalVenta
    }
    
    func calcularSubtotalVenta(){
        //  totalVenta/1.16
    }
    
    
}
