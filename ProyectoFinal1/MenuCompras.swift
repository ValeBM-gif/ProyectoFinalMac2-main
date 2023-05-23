//
//  MenuCompras.swift
//  ProyectoFinal1
//
//  Created by Valeria Baeza on 07/05/23.
//

import Cocoa

class MenuCompras: NSViewController {
    
    
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
        // Do view setup here.
        if vc.usuarioEsAdmin{
            btnAtras.isHidden = false
            btnCerrarSesion.isHidden = true
        }else{
            btnAtras.isHidden = true
            btnCerrarSesion.isHidden = false
        }
        
        lblIDIncorrecto.isHidden = true
        
        //let usuarioActual = vc.usuarioLog
        print("id de usuario actuaal ",vc.idUsuarioActual)
        idUsuarioActual = vc.idUsuarioActual
        
        for producto in vc.productoLog{
            print("productos", producto.nombre)
        }
        
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
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier=="irVcRegistroProducto"{
            (segue.destinationController as! RegistroProductos).vc = vc
            (segue.destinationController as! RegistroProductos).esRegistroProducto = irARegistro
            (segue.destinationController as! RegistroProductos).modifyPosition = idProductoABuscar

            
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
    
