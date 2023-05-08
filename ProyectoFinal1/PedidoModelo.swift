//
//  PedidoModelo.swift
//  ProyectoFinal1
//
//  Created by Diego Juárez on 07/05/23.
//

import Cocoa

class PedidoModelo: NSObject {
    
    @objc dynamic var id: Int
    @objc dynamic var idProducto:Int
    @objc dynamic var cantidad:Int
    @objc dynamic var precioProducto:Double
    @objc dynamic var totalProducto:Double
    @objc dynamic var totalPedido:Double
    @objc dynamic var entregado:Bool
    
    init(_ id: Int,_ idProducto: Int,_ cantidad: Int,_ precioProducto: Double,_ totalProducto: Double,_ totalPedido: Double,_ entregado: Bool) {
        self.id = id
        self.idProducto = idProducto
        self.cantidad = cantidad
        self.precioProducto = precioProducto
        self.totalProducto = totalProducto
        self.totalPedido = totalPedido
        self.entregado = entregado
    }
    
}

