//
//  MenuCompras.swift
//  ProyectoFinal1
//
//  Created by Valeria Baeza on 07/05/23.
//

import Cocoa

class MenuCompras: NSViewController {

    @IBOutlet weak var txtID: NSTextField!
    
    @IBOutlet weak var lblIDIncorrecto: NSTextField!
    
    var idProductoABuscar: Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        lblIDIncorrecto.isHidden = true
    }
    
    @IBAction func buscarProducto(_ sender: NSButton) {
        if txtID.stringValue != ""{
            if soloHayNumerosEnTxtID(){
                idProductoABuscar = txtID.integerValue
                lblIDIncorrecto.isHidden = true
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
    
    @IBAction func regresarAInicio(_ sender: NSButton) {
            dismiss(self)
    }
    
}
