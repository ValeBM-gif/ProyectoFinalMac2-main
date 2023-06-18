//
//  ModificarVenta.swift
//  ProyectoFinal1
//
//  Created by Valeria Baeza on 17/06/23.
//

import Cocoa

class ModificarVenta: NSViewController {

    @IBOutlet weak var txtCantidadModificar: NSTextField!
    
    @IBOutlet weak var lblIncorrecto: NSTextField!
        
    var cantidadProducto: Int=0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        lblIncorrecto.isHidden = true
        //NO TIENE NS IMAGEVIEW
        //vc.cambiarImagenYFondo(idUsuarioActual: vc.idUsuarioActual, imgAvatar: imgAvatar, view: self.view)
    }
        
    @IBAction func modificarVenta(_ sender: NSButton) {
        if validarCamposVacios(){
            if soloHayNumerosEnCantidad() && validarCantidadMayorCero(){
                lblIncorrecto.isHidden = true
                cantidadProducto = txtCantidadModificar.integerValue
                dismiss(self)
            }
        }else{
            lblIncorrecto.isHidden = false
            lblIncorrecto.stringValue = "*Introduce una cantidad*"
        }
        
        func soloHayNumerosEnCantidad() -> Bool{
            let numericCharacters = CharacterSet.decimalDigits.inverted
            return txtCantidadModificar.stringValue.rangeOfCharacter(from: numericCharacters) == nil
        }
        
        func validarCantidadMayorCero() -> Bool {
            var cantEsMayorCero = false
            if((Int(txtCantidadModificar.stringValue)!) > 0){
                cantEsMayorCero = true
            }
            else{
                cantEsMayorCero = false
                lblIncorrecto.stringValue = "Inserta una cantidad valida"
            }
            return cantEsMayorCero
        }
        
        func validarCamposVacios() -> Bool{
            if(txtCantidadModificar.stringValue == ""){
                return false
            }
            return true
        }
    }
}
