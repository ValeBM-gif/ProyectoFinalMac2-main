//
//  ProductoModelo.swift
//  ProyectoFinal1
//
//  Created by Valeria Baeza on 07/05/23.
//

import Cocoa

class ProductoModelo: NSObject {
    @objc dynamic var id: Int
    @objc dynamic var nombre:String
    @objc dynamic var descricpion:String
    @objc dynamic var unidad:String
    @objc dynamic var precio:Double
    @objc dynamic var costo:Double
    @objc dynamic var categoria:String
    @objc dynamic var cantidad:Int
    
    init(_ id: Int,_ nombre: String,_ descripcion: String,_ unidad: String,_ precio: Double,_ costo: Double,_ categoria: String,_ cantidad: Int) {
        self.id = id
        self.nombre = nombre
        self.descricpion = descripcion
        self.unidad = unidad
        self.precio = precio
        self.costo = costo
        self.categoria = categoria
        self.cantidad = cantidad
    }
}
