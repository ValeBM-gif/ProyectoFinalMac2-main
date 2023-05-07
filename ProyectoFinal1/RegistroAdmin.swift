//
//  RegistroAdmin.swift
//  ProyectoFinal1
//
//  Created by Valeria Baeza on 06/05/23.
//

import Cocoa

class RegistroAdmin: NSViewController {

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
    @IBOutlet weak var txtRol: NSTextField!
    
    @IBOutlet weak var btnRegistrar: NSButton!
    
    @IBOutlet weak var lblCamposVacios: NSTextField!
    
    var position:Int = 0
    @objc dynamic var usuarioLog:[UsuarioModelo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCamposVacios.isHidden = true;
        
        position = vc.usuarioLog.count
        
        for usuario in usuarioLog{
            print(usuario.nombre)
        }
        
        btnRegistrar.isEnabled = true
        
    }
    
    @IBAction func registrarUsuario(_ sender: NSButton) {
        
        if validarCamposVacios(){
            if validarPasswordsIguales(){
                if emailEsValido(){
                    if numeroTelfonicoEsValido(){
                        lblCamposVacios.isHidden = true
                        
                        vc.usuarioLog.append(UsuarioModelo(position, txtNombre.stringValue, txtApellidoPaterno.stringValue, txtApellidoMaterno.stringValue, txtEmail.stringValue, txtTelefono.stringValue, txtGenero.stringValue, txtPassword.stringValue, txtConfirmarPassword.stringValue, txtRol.stringValue))
                        
                        print("Agregaste")
                        
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
    
    @IBAction func cerrarViewController(_ sender: NSButton) {
        dismiss(self)
    }
    
}
