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
    @objc dynamic var subtotalVenta:Bool
    @objc dynamic var ivaVenta:Bool
    @objc dynamic var totalVenta:Bool
    
    init(idVenta: Int, idVendedor: Int, idCliente: Int, idProducto: Int, cantidad: Int, precioProducto: Double, totalProducto: Double, subtotalVenta: Bool, ivaVenta: Bool, totalVenta: Bool) {
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
