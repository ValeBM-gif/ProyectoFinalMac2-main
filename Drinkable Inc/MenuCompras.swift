//
//  MenuCompras.swift
//  Drinkable Inc
//
//  Created by Valeria Baeza on 07/05/23.
//

import Cocoa

class MenuCompras: NSViewController {
    
    @IBOutlet weak var imgAvatar: NSImageView!
    
    @IBOutlet weak var vc: ViewController!

    @IBOutlet weak var txtID: NSTextField!
    @IBOutlet weak var btnAtras: NSButton!
    @IBOutlet weak var lblIDIncorrecto: NSTextField!
    @IBOutlet weak var btnCerrarSesion: NSButton!
    
    var idUsuarioActual:Int!
    var idProductoABuscar: Int=0
    var irARegistro:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if vc.usuarioEsAdmin{
            btnAtras.isHidden = false
            btnCerrarSesion.isHidden = true
        }else{
            btnAtras.isHidden = true
            btnCerrarSesion.isHidden = false
        }
        
        vc.cambiarImagenYFondo(idUsuarioActual: vc.idUsuarioActual, imgAvatar: imgAvatar, view: self.view)
       
        lblIDIncorrecto.isHidden = true
                
        idUsuarioActual = vc.idUsuarioActual
        
    }
    
    @IBAction func buscarProducto(_ sender: NSButton) {
        if txtID.stringValue != ""{
            if soloHayNumerosEnTxtID(){
                idProductoABuscar = txtID.integerValue
                lblIDIncorrecto.isHidden = true
                if validarNoUsarCero(id: idProductoABuscar){
                    if checarExistenciaProducto(id: idProductoABuscar){
                        irARegistro = false
                    }else{
                        irARegistro = true
                    }
                    
                    performSegue(withIdentifier: "irVcRegistroProducto", sender: self)
                }else{
                    lblIDIncorrecto.isHidden = false
                }
            }else{
                lblIDIncorrecto.isHidden = false
            }
        }else{
            lblIDIncorrecto.isHidden = false
        }
    }
    
    func soloHayNumerosEnTxtID() -> Bool{
        let numericCharacters = CharacterSet.decimalDigits.inverted
        return txtID.stringValue.rangeOfCharacter(from: numericCharacters) == nil
    }
    
    func checarExistenciaProducto(id:Int) -> Bool{
        for ProductoModelo in vc.productoLog {
            if (ProductoModelo.id == id) {
                return true
            }
        }
        return false
    }
    
    func validarNoUsarCero(id:Int)->Bool{
        if id == 0{
            return false
        }
        return true
    }
    
    @IBAction func regresarAInicio(_ sender: NSButton) {
            dismiss(self)
    }
    
    func encontrarProductoPorId() -> ProductoModelo {
        var productoEncontrado = ProductoModelo(0, "", "", "", 0, 0, "", 0, 0, "")
        for producto in vc.productoLog{
            if txtID.integerValue == producto.id{
                productoEncontrado = producto
            }
        }
        return productoEncontrado
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier=="irVcRegistroProducto"{
            (segue.destinationController as! RegistroProductos).vc = vc
            (segue.destinationController as! RegistroProductos).esRegistroProducto = irARegistro
            (segue.destinationController as! RegistroProductos).modifyObject = encontrarProductoPorId()
            
        }else if segue.identifier=="irConsultarProductos"{
            (segue.destinationController as! ConsultaProductos).productos = vc.productoLog
            (segue.destinationController as! ConsultaProductos).vcTabla = vc
        }
    }
    
    @IBAction func consultarProducto(_ sender: NSButton) {
        performSegue(withIdentifier: "irConsultarProductos", sender: self)
        dismiss(self)
    }
    
    
    @IBAction func CerrarVc(_ sender: NSButton) {
        dismiss(self)
    }
}
    
