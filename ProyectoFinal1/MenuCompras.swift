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
    
    @IBOutlet weak var lblIDIncorrecto: NSTextField!
    
    var idUsuarioActual:Int!
    var idProductoABuscar: Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        lblIDIncorrecto.isHidden = true
        
        let usuarioActual = vc.usuarioLog
        idUsuarioActual = vc.idUsuarioActual
    }
    
    @objc dynamic var productoLog: [ProductoModelo] = []
    
    @IBAction func buscarProducto(_ sender: NSButton) {
        if txtID.stringValue != ""{
            if soloHayNumerosEnTxtID(){
                idProductoABuscar = txtID.integerValue
                lblIDIncorrecto.isHidden = true
                if checarExistenciaProducto(id: idProductoABuscar){
                    performSegue(withIdentifier: "irVcModificarProducto", sender: self)
                }else{
                    performSegue(withIdentifier: "irVcRegistroProducto", sender: self)
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
        for ProductoModelo in productoLog {
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
            (segue.destinationController as! RegistroProductos).vc = self
            
        }else if segue.identifier=="irVcModificarProducto"{
            (segue.destinationController as! ModificarProducto).vcMenu = self
            (segue.destinationController as! ModificarProducto).vc = self.vc
            
            let destinationVC = segue.destinationController as! ModificarProducto;
            
            destinationVC.idUsuarioRecibido = idUsuarioActual
            destinationVC.idProductoAModificar = idProductoABuscar
        }
    }
    
}
