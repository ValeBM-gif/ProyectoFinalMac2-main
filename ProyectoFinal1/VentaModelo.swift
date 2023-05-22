//
//  VentaModelo.swift
//  ProyectoFinal1
//
//  Created by Uriel Resendiz on 07/05/23.
//

import Cocoa

class VentaModelo: NSObject {
    
    @objc dynamic var idVenta:Int
    @objc dynamic var idVendedor:Int
    @objc dynamic var nombreVendedor:String
    @objc dynamic var idCliente:Int
    @objc dynamic var nombreCliente:String
    @objc dynamic var idProducto:Int
    @objc dynamic var nombreProducto:String
    @objc dynamic var cantidad:Int
    @objc dynamic var precioProducto:Double
    @objc dynamic var totalProducto:Double
    @objc dynamic var subtotalVenta:Double
    @objc dynamic var ivaVenta:Double
    @objc dynamic var totalVenta:Double
    
    init(idVenta: Int, idVendedor: Int, nombreVendedor: String, idCliente: Int, nombreCliente: String, idProducto: Int, nombreProducto: String, cantidad: Int, precioProducto: Double, totalProducto: Double, subtotalVenta: Double, ivaVenta: Double, totalVenta: Double) {
        self.idVenta = idVenta
        self.idVendedor = idVendedor
        self.nombreVendedor = nombreVendedor
        self.idCliente = idCliente
        self.nombreCliente = nombreCliente
        self.idProducto = idProducto
        self.nombreProducto = nombreProducto
        self.cantidad = cantidad
        self.precioProducto = precioProducto
        self.totalProducto = totalProducto
        self.subtotalVenta = subtotalVenta
        self.ivaVenta = ivaVenta
        self.totalVenta = totalVenta
    }
}
