//
//  PedidoModelo.swift
//  ProyectoFinal1
//
//  Created by Diego Juárez on 07/05/23.
//

import Cocoa

class PedidoModelo: NSObject {
    
    @objc dynamic var id: Int
    @objc dynamic var idProducto:String
    @objc dynamic var descripcionProducto:String
    @objc dynamic var cantidad:String
    @objc dynamic var precioProducto:String
    @objc dynamic var totalProducto:String
    @objc dynamic var totalPedido:Double
    
    init(_ id: Int,_ idProducto: String,_ descripcionProducto: String,_ cantidad: String,_ precioProducto: String,_ totalProducto: String,_ totalPedido: Double) {
        self.id = id
        self.idProducto = idProducto
        self.descripcionProducto = descripcionProducto
        self.cantidad = cantidad
        self.precioProducto = precioProducto
        self.totalProducto = totalProducto
        self.totalPedido = totalPedido
    }
    
}

