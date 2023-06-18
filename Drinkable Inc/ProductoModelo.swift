//
//  ProductoModelo.swift
//  Drinkable Inc
//
//  Created by Valeria Baeza on 07/05/23.
//

import Cocoa

class ProductoModelo: NSObject {
    @objc dynamic var id: Int
    @objc dynamic var nombre:String
    @objc dynamic var descripcion:String
    @objc dynamic var unidad:String
    @objc dynamic var precio:Double
    @objc dynamic var costo:Double
    @objc dynamic var categoria:String
    @objc dynamic var cantidad:Int
    @objc dynamic var idComprador:Int
    @objc dynamic var nombreComprador:String

    init(_ id: Int, _ nombre: String, _ descricpion: String, _ unidad: String, _ precio: Double, _ costo: Double, _ categoria: String, _ cantidad: Int, _ idComprador: Int, _ nombreComprador: String) {
        self.id = id
        self.nombre = nombre
        self.descripcion = descricpion
        self.unidad = unidad
        self.precio = precio
        self.costo = costo
        self.categoria = categoria
        self.cantidad = cantidad
        self.idComprador = idComprador
        self.nombreComprador = nombreComprador
    }
}
