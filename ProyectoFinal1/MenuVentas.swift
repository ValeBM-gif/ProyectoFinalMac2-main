//
//  MenuVentas.swift
//  ProyectoFinal1
//
//  Created by Uriel Resendiz on 07/05/23.
//

import Cocoa

class MenuVentas: NSViewController {
    
    @IBOutlet weak var vc: ViewController!
    
    @IBOutlet weak var txtID: NSTextField!
    @IBOutlet weak var btnBuscar: NSButton!
    @IBOutlet weak var btnCerrarSesion: NSButton!
    @IBOutlet weak var lblIDIncorrecto: NSTextField!
    
    var idClienteABuscar: Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblIDIncorrecto.isHidden = true
    }
    
    @IBAction func buscarCliente(_ sender: NSButton){
        if txtID.stringValue != ""{
            if soloHayNumerosEnTxtID(){
                idClienteABuscar = txtID.integerValue
                lblIDIncorrecto.isHidden = true
                if checarExistenciaCliente(id: idClienteABuscar){
                    performSegue(withIdentifier: "irVentas", sender: self)
                }else{
                    performSegue(withIdentifier: "irVcRegistroVentas", sender: self)
                    dismiss(self)
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
    
    func checarExistenciaCliente(id:Int) -> Bool{
        for UsuarioModelo in vc.usuarioLog{
            if(UsuarioModelo.id == id){
                return true
            }
        }
        return false
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "irVcRegistroVentas" {
            let destinoVc = segue.destinationController as! RegistrarUsuario
            destinoVc.vcMenu = "Ventas"
            destinoVc.vc = vc
           
        }
    }
}
