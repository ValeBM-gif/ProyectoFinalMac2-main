//
//  RegistrarUsuario.swift.
//  ProyectoFinal1
//
//  Created by Valeria Baeza on 19/04/23.
//

import Cocoa

class RegistrarUsuario: NSViewController {
    
    //TODO: Validar que no haya usuarios repetidos
    //TODO: Validar contraseñas seguras
    //TODO: Que no se vea la contraseña en campos de contraseña

    @IBOutlet weak var vc: ViewController!
    
    @IBOutlet weak var txtNombre: NSTextField!
    @IBOutlet weak var txtApellidoPaterno: NSTextField!
    @IBOutlet weak var txtApellidoMaterno: NSTextField!
    @IBOutlet weak var txtEmail: NSTextField!
    @IBOutlet weak var txtTelefono: NSTextField!
    @IBOutlet weak var txtGenero: NSTextField!
    @IBOutlet weak var txtPassword: NSTextField!
    @IBOutlet weak var txtConfirmarPassword: NSTextField!
    
    @IBOutlet weak var btnRegistrar: NSButton!
    
    @IBOutlet weak var lblClienteExistente: NSTextField!
    @IBOutlet weak var lblCamposVacios: NSTextField!
    
    var position:Int = 0
    var vcMenu:String = "Menu"
    
    @objc dynamic var usuarioLog:[UsuarioModelo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCamposVacios.isHidden = true;
        
        position = vc.usuarioLog.count
        

        btnRegistrar.isEnabled = true
        
        lblClienteExistente.isHidden = true
        
        if(vcMenu=="Ventas"){
            lblClienteExistente.isHidden = false
        }
        
    }
    
    @IBAction func registrarUsuario(_ sender: NSButton) {
        
        if validarCamposVacios(){
            if validarPasswordsIguales(){
                if emailEsValido(){
                    if numeroTelfonicoEsValido(){
                        lblCamposVacios.isHidden = true
                        
                        vc.usuarioLog.append(UsuarioModelo(position, txtNombre.stringValue, txtApellidoPaterno.stringValue, txtApellidoMaterno.stringValue, txtEmail.stringValue, txtTelefono.stringValue, txtGenero.stringValue, txtPassword.stringValue, txtConfirmarPassword.stringValue, "Cliente"))
                        

                        print("Agregaste")
                        performSegue(withIdentifier: "irAMenuVentas", sender: self)
                    print("Agregaste Cliente")
                        

                        dismiss(self)
                        
                    }else{
                        lblCamposVacios.stringValue = "Inserta un teléfono válido"
                        lblCamposVacios.isHidden = false
                    }
                    
                }else{
                    lblCamposVacios.stringValue = "Inserta un email válido"
                    lblCamposVacios.isHidden = false
                }

            }else{
                lblCamposVacios.stringValue = "Las contraseñas no coinciden"
                lblCamposVacios.isHidden = false
            }
            
        }else{
            lblCamposVacios.stringValue = "Recuerda llenar todos los campos"
            lblCamposVacios.isHidden = false
        }
    }
    
    func validarCamposVacios()->Bool{
        if txtNombre.stringValue == "" ||
            txtApellidoPaterno.stringValue == "" ||
            txtApellidoMaterno.stringValue == "" ||
            txtEmail.stringValue == "" ||
            txtTelefono.stringValue == "" ||
            txtGenero.stringValue == "" ||
            txtPassword.stringValue == "" ||
            txtConfirmarPassword.stringValue == "" {
            return false
        }
        return true
    }
    
    func emailEsValido() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: txtEmail.stringValue)
    }
    
    func numeroTelfonicoEsValido() -> Bool {
        let phoneNumberRegex = "^\\d{10}$"
        let phoneNumberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        return phoneNumberPredicate.evaluate(with: txtTelefono.stringValue)
    }
    
    func validarPasswordsIguales()->Bool{
        if txtPassword.stringValue == txtConfirmarPassword.stringValue{
            return true
        }
        return false
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier=="irAMenuVentas"{
            (segue.destinationController as! MenuVentas).vc = self.vc
        }
    }
        
    @IBAction func cerrarViewController(_ sender: NSButton) {
        if(vcMenu=="Ventas"){
            performSegue(withIdentifier: "irAMenuVentas", sender: self)
        }
        dismiss(self)
    }

}

