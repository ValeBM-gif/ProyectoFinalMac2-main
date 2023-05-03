//
//  MenuAdmin.swift.
//  ProyectoFinal1.
//
//  Created by Diego Juárez on 25/04/23.
//

import Cocoa

class MenuAdmin: NSViewController {
    

    @IBOutlet weak var vc: ViewController!

    @IBOutlet weak var txtNombreUsuario: NSTextField!
    @IBOutlet weak var txtID: NSTextField!
    @IBOutlet weak var lblIDIncorrecto: NSTextField!
    
    @IBOutlet weak var lblBajaCorrecta: NSTextField!
    
    var idUsuarioActual:Int!
    var idUsuarioAModificar:Int=0
    var idUsuarioAEliminar:Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblIDIncorrecto.isHidden = true
        lblBajaCorrecta.isHidden = true

        let usuarioActual = vc.usuarioLog
        idUsuarioActual = vc.idUsuarioActual
        print("num de usuarios",vc.usuarioLog.count)
        
        txtNombreUsuario.stringValue = "Bienvenide " + usuarioActual[idUsuarioActual].nombre
    }
    
    @IBAction func eliminarUsuario(_ sender: NSButton) {
        if soloHayNumerosEnTxtID(){
            lblIDIncorrecto.isHidden = true
            lblBajaCorrecta.isHidden = false
            idUsuarioAEliminar = txtID.integerValue
            if(idUsuarioAEliminar==0){
                lblIDIncorrecto.stringValue = "*El admin no se puede eliminar*"
                let tal = soloHayNumerosEnTxtID()
            }else{
                lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                if(idUsuarioActual==idUsuarioAEliminar){
                    print("AHORITA NO SE PUEDE ELIMINAR A UNO MISME")
                    lblIDIncorrecto.isHidden = false
                    lblBajaCorrecta.isHidden = true
                }else if checarExistenciaUsuario(id: idUsuarioAEliminar){
                    vc.usuarioLog.remove(at: idUsuarioAEliminar)
                    lblBajaCorrecta.isHidden=false
                    lblIDIncorrecto.isHidden=true
                }else{
                    lblBajaCorrecta.isHidden=true
                    lblIDIncorrecto.isHidden=false
                }
            }
        }else{
            lblBajaCorrecta.isHidden = true
            lblIDIncorrecto.isHidden = false
            
        }
        
    }
    
    @IBAction func irModificar(_ sender: NSButton) {
        if soloHayNumerosEnTxtID(){
            lblIDIncorrecto.isHidden = true
            if txtID.stringValue != ""{
                lblIDIncorrecto.isHidden = true
                idUsuarioAModificar = txtID.integerValue
               
                if verificarSiUsuarioLogVacio(){
                    print("PRINT QUE NO ES DE VALE "+vc.usuarioLog[idUsuarioAModificar].nombre)
                    print("si hay usuarios y si es id válido")
                    performSegue(withIdentifier: "irAModificar", sender: self)
                }
            }else{
                lblIDIncorrecto.isHidden = false
            }
        }else{
            lblBajaCorrecta.isHidden = true
            lblIDIncorrecto.isHidden = false
        }
        
    }
    
    
    @IBAction func irConsultar(_ sender: NSButton) {
        
        performSegue(withIdentifier: "irAConsultar", sender: self)
    }
    
    
    
    
    func verificarSiUsuarioLogVacio() -> Bool{
        if !vc.usuarioLog.isEmpty{
            return checarExistenciaUsuario(id: idUsuarioAModificar)
        }
        return false;
    }
    
    func checarExistenciaUsuario(id:Int) -> Bool{
        for UsuarioModelo in vc.usuarioLog {
            if (UsuarioModelo.id == id) {
                print("entra a forrrrrrrr")
                lblIDIncorrecto.isHidden = true
                
                return true
                
            }
        }
        lblIDIncorrecto.isHidden = false
        return false
    }
    
    func soloHayNumerosEnTxtID() -> Bool{
        let numericCharacters = CharacterSet.decimalDigits.inverted
        return txtID.stringValue.rangeOfCharacter(from: numericCharacters) == nil
    }
        
    @IBAction func irARegistro(_ sender: NSButton) {
        performSegue(withIdentifier: "iniciarSesionCorrecto", sender: self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "irAModificar" {
                
                (segue.destinationController as! ModificarUsuario).vc = self.vc
                
                (segue.destinationController as! ModificarUsuario).vcMenu = self
                
                let destinationVC = segue.destinationController as! ModificarUsuario;

                destinationVC.idDeUsuarioRecibido = idUsuarioActual
                destinationVC.idUsuarioAModificar = idUsuarioAModificar
                print("valor id en menu: ",vc.usuarioLog[idUsuarioAModificar].id)
            }else if segue.identifier=="irARegistrar"{
            (segue.destinationController as! RegistrarUsuario).vc = self.vc
            }else if segue.identifier=="irAConsultar"{
                (segue.destinationController as! ConsultarUsuario).usuarioLog = vc.usuarioLog
                (segue.destinationController as! ConsultarUsuario).vcTabla = self.vc
            }
    }
    
        
    
    }
    

