//
//  MenuAdmin.swift.
//  ProyectoFinal1.
//
//  Created by Diego Juárez on 25/04/23.
//

import Cocoa

class MenuAdmin: NSViewController {
    
    //TODO: admin puede ser todos los roles!!!
    
    @IBOutlet weak var vc: ViewController!
    
    @IBOutlet weak var txtNombreUsuario: NSTextField!
    @IBOutlet weak var txtID: NSTextField!
    @IBOutlet weak var lblIDIncorrecto: NSTextField!
    
    @IBOutlet weak var lblBajaCorrecta: NSTextField!
    
    var idUsuarioActual:Int!
    var idUsuarioAModificar:Int=0
    var idUsuarioAEliminar:Int=0
    var idCliente:Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MENU ADMIN: bool es admin? ",vc.usuarioEsAdmin)
        
        lblIDIncorrecto.isHidden = true
        lblBajaCorrecta.isHidden = true
        
        let usuarioActual = vc.usuarioLog
        idUsuarioActual = vc.idUsuarioActual
        
        txtNombreUsuario.stringValue = "Bienvenide " + usuarioActual[idUsuarioActual].nombre
    }
    
    @IBAction func irAMenuCompras(_ sender: NSButton) {
        performSegue(withIdentifier: "irMenuComprasAdmin", sender: self)
    }
    
    @IBAction func irAMenuVentas(_ sender: NSButton) {
        performSegue(withIdentifier: "irMenuVentasAdmin", sender: self)
    }
    
    @IBAction func irAMenuPedidos(_ sender: NSButton) {
        
        if txtID.stringValue != ""{
            if soloHayNumerosEnTxtID(){
                vc.idUsuarioActual = txtID.integerValue
                
                if (1==1) //checarExistenciaUsuario(id: idUsuarioAModificar)
                {
                    performSegue(withIdentifier: "irMenuPedidosAdmin", sender: self)
                    lblIDIncorrecto.isHidden = true
                    lblBajaCorrecta.isHidden = true
                    
                }else{
                    lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                    lblIDIncorrecto.isHidden = false
                    lblBajaCorrecta.isHidden = true
                }
            }else{
                lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                lblIDIncorrecto.isHidden = false
                lblBajaCorrecta.isHidden = true
            }
        }else{
            lblIDIncorrecto.stringValue = "*Inserta el ID del cliente*"
            lblIDIncorrecto.isHidden = false
            lblBajaCorrecta.isHidden = true
        }
    }
    
    @IBAction func irARegistro(_ sender: NSButton) {
        performSegue(withIdentifier: "irARegistrar", sender: self)
    }
    
    @IBAction func eliminarUsuario(_ sender: NSButton) {
        if txtID.stringValue != ""{
            if soloHayNumerosEnTxtID(){
                idUsuarioAEliminar = txtID.integerValue
                if idUsuarioAEliminar != 0 {
                    if idUsuarioActual != idUsuarioAEliminar{
                        if checarExistenciaUsuario(id: idUsuarioAEliminar){
                            vc.usuarioLog.remove(at: idUsuarioAEliminar)
                            lblBajaCorrecta.isHidden=false
                            lblIDIncorrecto.isHidden=true
                        }else{
                            lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                            lblIDIncorrecto.isHidden = false
                            lblBajaCorrecta.isHidden = true
                        }
                    }else{
                        lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                        lblIDIncorrecto.isHidden = false
                        lblBajaCorrecta.isHidden = true
                    }
                }else{
                    lblIDIncorrecto.stringValue = "*El admin no se puede eliminar*"
                    lblIDIncorrecto.isHidden = false
                    lblBajaCorrecta.isHidden = true
                }
            }else{
                lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                lblIDIncorrecto.isHidden = false
                lblBajaCorrecta.isHidden = true
            }
        }else{
            lblIDIncorrecto.stringValue = "*Inserta el ID que quieres eliminar*"
            lblIDIncorrecto.isHidden = false
            lblBajaCorrecta.isHidden = true
        }
        
    }
    
    @IBAction func irAModificar(_ sender: NSButton) {
        if txtID.stringValue != ""{
            if soloHayNumerosEnTxtID(){
                idUsuarioAModificar = txtID.integerValue
                
                if checarExistenciaUsuario(id: idUsuarioAModificar){
                    performSegue(withIdentifier: "irAModificar", sender: self)
                    lblIDIncorrecto.isHidden = true
                    lblBajaCorrecta.isHidden = true
                    
                }else{
                    lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                    lblIDIncorrecto.isHidden = false
                    lblBajaCorrecta.isHidden = true
                }
            }else{
                lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                lblIDIncorrecto.isHidden = false
                lblBajaCorrecta.isHidden = true
            }
        }else{
            lblIDIncorrecto.stringValue = "*Inserta el ID del usuario a modificar*"
            lblIDIncorrecto.isHidden = false
            lblBajaCorrecta.isHidden = true
        }
    }
    
    
    @IBAction func irAConsultar(_ sender: NSButton) {
        performSegue(withIdentifier: "irAConsultar", sender: self)
    }
    
    func checarExistenciaUsuario(id:Int) -> Bool{
        if (id==0){
            return false
        }
        for UsuarioModelo in vc.usuarioLog {
            if (UsuarioModelo.id == id) {
                return true
            }
        }
        return false
    }
    
    func soloHayNumerosEnTxtID() -> Bool{
        let numericCharacters = CharacterSet.decimalDigits.inverted
        return txtID.stringValue.rangeOfCharacter(from: numericCharacters) == nil
    }
    
    @IBAction func volverAInicio(_ sender: NSButton) {
        dismiss(self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        txtID.stringValue = ""
        if segue.identifier == "irAModificar" {
            
            (segue.destinationController as! RegistroAdmin).vc = self.vc
            
            (segue.destinationController as! RegistroAdmin).vcMenu = self
            
            let destinationVC = segue.destinationController as! RegistroAdmin;
            
            destinationVC.idDeUsuarioRecibido = idUsuarioActual
            destinationVC.idUsuarioAModificar = idUsuarioAModificar
            destinationVC.modificar=true
            
        }else if segue.identifier=="irARegistrar"{
            
            (segue.destinationController as! RegistroAdmin).vc = self.vc
            let destinationVC = segue.destinationController as! RegistroAdmin;
            destinationVC.modificar=false
            
        }else if segue.identifier=="irAConsultar"{
            (segue.destinationController as! ConsultarUsuario).usuarioLog = vc.usuarioLog
            (segue.destinationController as! ConsultarUsuario).vcTabla = self.vc
        }else if segue.identifier=="irMenuComprasAdmin"{
            (segue.destinationController as! MenuCompras).vc = vc
            
        }else if segue.identifier=="irMenuVentasAdmin"{
            (segue.destinationController as! MenuVentas).vc = vc
        }else if segue.identifier=="irMenuPedidosAdmin"{
            (segue.destinationController as! PedidosCliente).vcTablaPedidos = vc
            
            (segue.destinationController as! PedidosCliente).ventasLog = vc.ventasLog
            (segue.destinationController as! PedidosCliente).productosLog = vc.productoLog
        }
    }
}
