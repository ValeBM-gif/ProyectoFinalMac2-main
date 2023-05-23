//
//  MenuCompras.swift
//  ProyectoFinal1
//
//  Created by Valeria Baeza on 07/05/23.
//

import Cocoa

class MenuCompras: NSViewController {
    
    //TODO: quiatr código excedente de prepare

    
    
    @IBOutlet weak var vc: ViewController!

    @IBOutlet weak var txtID: NSTextField!
    
    @IBOutlet weak var lblIDIncorrecto: NSTextField!
    
    var idUsuarioActual:Int!
    var idProductoABuscar: Int=0
    var irARegistro:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        lblIDIncorrecto.isHidden = true
        
        //let usuarioActual = vc.usuarioLog
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
    
    @IBAction func regresarAInicio(_ sender: NSButton) {
            dismiss(self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier=="irVcRegistroProducto"{
            (segue.destinationController as! RegistroProductos).vc = vc
            (segue.destinationController as! RegistroProductos).esRegistroProducto = irARegistro
            (segue.destinationController as! RegistroProductos).modifyPosition = idProductoABuscar - 1

            
        }else if segue.identifier=="irConsultarProductos"{
            (segue.destinationController as! ConsultaProductos).productoLog = vc.productoLog
            (segue.destinationController as! ConsultaProductos).vcTabla = vc
        }
    }
    
    @IBAction func consultarProducto(_ sender: NSButton) {
        performSegue(withIdentifier: "irConsultarProductos", sender: self)
    }
}
    
