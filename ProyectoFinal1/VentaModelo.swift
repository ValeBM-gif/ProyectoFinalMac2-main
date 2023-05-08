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
    @objc dynamic var idCliente:Int
    @objc dynamic var idProducto:Int
    @objc dynamic var cantidad:Int
    @objc dynamic var precioProducto:Double
    @objc dynamic var totalProducto:Double
    @objc dynamic var subtotalVenta:Double
    @objc dynamic var ivaVenta:Double
    @objc dynamic var totalVenta:Double
    
    init(idVenta: Int, idVendedor: Int, idCliente: Int, idProducto: Int, cantidad: Int, precioProducto: Double, totalProducto: Double, subtotalVenta: Double, ivaVenta: Double, totalVenta: Double) {
        self.idVenta = idVenta
        self.idVendedor = idVendedor
        self.idCliente = idCliente
        self.idProducto = idProducto
        self.cantidad = cantidad
        self.precioProducto = precioProducto
        self.totalProducto = totalProducto
        self.subtotalVenta = subtotalVenta
        self.ivaVenta = ivaVenta
        self.totalVenta = totalVenta
    }
}
