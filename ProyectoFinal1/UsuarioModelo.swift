//
//  UsuarioModelo.swift
//  ProyectoFinal1
//
//  Created by Valeria Baeza on 19/04/23.
//

import Cocoa

class UsuarioModelo: NSObject {
    
    @objc dynamic var id: Int
    @objc dynamic var nombre:String
    @objc dynamic var apellidoPaterno:String
    @objc dynamic var apellidoMaterno:String
    @objc dynamic var email:String
    @objc dynamic var telefono:String
    @objc dynamic var genero:String
    @objc dynamic var edad:Int
    @objc dynamic var contraseña:String
    @objc dynamic var confirmarContraseña:String
    @objc dynamic var rol:String
    @objc dynamic var fechaNacimiento: Date
    @objc dynamic var colorFondo: String
    @objc dynamic var imgFondo: String
    
    
    
    init(_ id: Int,_ nombre: String,_ apellidoPaterno: String,_ apellidoMaterno: String,_ email: String,_ telefono: String,_ genero: String,_ edad:Int,_ contraseña: String,_ confirmarContraseña: String,_ rol: String,_ fechaNacimiento: Date,_ colorFondo: String,_ imgFondo: String ) {
        self.id = id
        self.nombre = nombre
        self.apellidoPaterno = apellidoPaterno
        self.apellidoMaterno = apellidoMaterno
        self.email = email
        self.telefono = telefono
        self.genero = genero
        self.edad = edad
        self.contraseña = contraseña
        self.confirmarContraseña = confirmarContraseña
        self.rol = rol
        self.fechaNacimiento = fechaNacimiento
        self.colorFondo = colorFondo
        self.imgFondo = imgFondo
    }
    
}
