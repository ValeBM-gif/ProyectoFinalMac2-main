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
    //TODO: Validar que sea un rol válido

    
    @IBOutlet weak var vc: ViewController!
    @IBOutlet weak var vcMenu: MenuAdmin!
    
    var modificar:Bool?
    var idDeUsuarioRecibido:Int = 0
    var idUsuarioAModificar:Int = 0
    
    @IBOutlet weak var txtNombre: NSTextField!
    @IBOutlet weak var lblTitulo: NSTextField!
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
        cambiarTitulo()
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
    
    func cambiarTitulo(){
        if modificar == true{
            lblTitulo.stringValue = "Modificar"
        }
        else{
            lblTitulo.stringValue = "Registro"
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
            txtConfirmarPassword.stringValue == "" ||
            txtRol.stringValue == ""{
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
    
    
    
    
    // aquí empieza modificar


    
    class ModificarUsuario: NSViewController {
        
        //TODO: validar Rol
        //TODO: si el admin 0 quiere cambiar de rol que no se pueda
        //TODO: validar que no haya email repetidos

        @IBOutlet weak var vc: ViewController!
        @IBOutlet weak var vcMenu: MenuAdmin!
        
        @IBOutlet weak var txtNombre: NSTextField!
        @IBOutlet weak var txtApellidoPaterno: NSTextField!
        @IBOutlet weak var txtApellidoMaterno: NSTextField!
        @IBOutlet weak var txtEmail: NSTextField!
        @IBOutlet weak var txtTelefono: NSTextField!
        @IBOutlet weak var txtGenero: NSTextField!
        @IBOutlet weak var txtRol: NSTextField!
        
        @IBOutlet weak var lblCamposVacios: NSTextField!
        
        @IBOutlet weak var btnActualizar: NSButton!
        
        var idDeUsuarioRecibido:Int = 0
        var idUsuarioAModificar:Int = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            lblCamposVacios.isHidden = true
            
            print("id usuario a modificar",idUsuarioAModificar)
            
            idDeUsuarioRecibido = vc.idUsuarioActual
            
            print("nombre usuario a modificar:",vc.usuarioLog[idUsuarioAModificar].nombre)
            
                txtNombre.stringValue = vc.usuarioLog[idUsuarioAModificar].nombre
                txtApellidoPaterno.stringValue=vc.usuarioLog[idUsuarioAModificar].apellidoPaterno
                txtApellidoMaterno.stringValue = vc.usuarioLog[idUsuarioAModificar].apellidoMaterno
                txtEmail.stringValue=vc.usuarioLog[idUsuarioAModificar].email
                txtTelefono.stringValue = vc.usuarioLog[idUsuarioAModificar].telefono
                txtGenero.stringValue=vc.usuarioLog[idUsuarioAModificar].genero
                txtRol.stringValue = vc.usuarioLog[idUsuarioAModificar].rol
        }
        
        @IBAction func actualizarUsuario(_ sender: NSButton) {
            
            if noHayCamposVacios(){
                if emailEsValido(){
                    if numeroTelfonicoEsValido(){
                        lblCamposVacios.isHidden = true
                        
                        vc.usuarioLog[idUsuarioAModificar].nombre = txtNombre.stringValue
                        vc.usuarioLog[idUsuarioAModificar].apellidoMaterno = txtApellidoMaterno.stringValue
                        vc.usuarioLog[idUsuarioAModificar].apellidoPaterno = txtApellidoPaterno.stringValue
                        vc.usuarioLog[idUsuarioAModificar].email = txtEmail.stringValue
                        vc.usuarioLog[idUsuarioAModificar].telefono = txtTelefono.stringValue
                        vc.usuarioLog[idUsuarioAModificar].genero = txtGenero.stringValue
                        vc.usuarioLog[idUsuarioAModificar].rol = txtRol.stringValue
                        dismiss(self)
                    }else{
                        lblCamposVacios.stringValue = "*Inserta un teléfono válido*"
                        lblCamposVacios.isHidden = false
                    }
                }else{
                    lblCamposVacios.stringValue = "*Inserta un email válido*"
                    lblCamposVacios.isHidden = false
                }
                
                
            }else{
                lblCamposVacios.stringValue = "*No dejes campos vacíos*"
                lblCamposVacios.isHidden = false
            }
            
            vcMenu.txtNombreUsuario.stringValue = "Bienvenide " + vc.usuarioLog[idDeUsuarioRecibido].nombre
            
            
        }
        
        func noHayCamposVacios()->Bool{
            if txtNombre.stringValue == "" ||
                txtApellidoPaterno.stringValue == "" ||
                txtApellidoMaterno.stringValue == "" ||
                txtEmail.stringValue == "" ||
                txtTelefono.stringValue == "" ||
                txtGenero.stringValue == "" ||
                txtRol.stringValue == "" {
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

        
        @IBAction func cerrarViewController(_ sender: NSButton) {
            dismiss(self)
        }
        
    }

    
}
