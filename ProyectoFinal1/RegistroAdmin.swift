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
    //TODO: Que cuando te mande a modificar aparezca tu fecha de nacimiento ya
    //TODO: Hacer que no le pueda cambiar el rol al admin 0
    //TODO: VAlidar EDAD
    
    @IBOutlet weak var vc: ViewController!
    @IBOutlet weak var vcMenu: MenuAdmin!
    
    var modificar:Bool = false
    var idDeUsuarioRecibido:Int = 0
    var idUsuarioAModificar:Int = 0
    var pantalla = ""
    var position:Int = 0
    let roles = ["Admin", "Cliente", "Compras", "Ventas"]
    var rolSeleccionado:String = "Cliente"
    
    @IBOutlet weak var lblTitulo: NSTextField!
    
    @IBOutlet weak var txtNombre: NSTextField!
    @IBOutlet weak var txtApellidoPaterno: NSTextField!
    @IBOutlet weak var txtApellidoMaterno: NSTextField!
    @IBOutlet weak var txtEmail: NSTextField!
    @IBOutlet weak var txtTelefono: NSTextField!
    @IBOutlet weak var txtGenero: NSTextField!
    @IBOutlet weak var txtPassword: NSTextField!
    @IBOutlet weak var txtConfirmarPassword: NSTextField!
    
    @IBOutlet weak var cmbRoles: NSPopUpButton!
    
    @IBOutlet weak var dtpFechaNacimiento: NSDatePicker!
    @IBOutlet weak var lblEdad: NSTextField!
    @IBOutlet weak var btnRegistrar: NSButton!
    
    @IBOutlet weak var lblCamposVacios: NSTextField!
    
    @objc dynamic var usuarioLog:[UsuarioModelo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if modificar{
            autorellenarCampos()
            lblTitulo.stringValue = "Modificar"
            btnRegistrar.title = "Modificar"
            cmbRoles.selectItem(at: obtenerIndiceRol())
        }else{
            btnRegistrar.title = "Registrar"
            lblTitulo.stringValue = "Registro"
            cmbRoles.selectItem(at: 1)
        }
        
        lblCamposVacios.isHidden = true;
        
        position = vc.usuarioLog.count
        
        cmbRoles.removeAllItems()
        cmbRoles.addItems(withTitles: roles)
        print("valor de bool modificar: \(String(describing: modificar))")
    }
    
    @IBAction func rolCambiado(_ sender: NSPopUpButton) {
        let indiceSeleccionado = sender.indexOfSelectedItem
            rolSeleccionado = roles[indiceSeleccionado]
            
        }
    
    @IBAction func modficarORegistrarUsuario(_ sender: NSButton) {
        if modificar == true {
            modificarUsuario()
        }
        else {
            registrarUsuario()
        }
    }
    
    
    func modificarUsuario(){
        if hacerValidaciones(){
            lblCamposVacios.isHidden = true
            
            let edad=calcularEdad()
            
            vc.usuarioLog[idUsuarioAModificar].nombre = txtNombre.stringValue
            vc.usuarioLog[idUsuarioAModificar].apellidoMaterno = txtApellidoMaterno.stringValue
            vc.usuarioLog[idUsuarioAModificar].apellidoPaterno = txtApellidoPaterno.stringValue
            vc.usuarioLog[idUsuarioAModificar].email = txtEmail.stringValue
            vc.usuarioLog[idUsuarioAModificar].telefono = txtTelefono.stringValue
            vc.usuarioLog[idUsuarioAModificar].genero = txtGenero.stringValue
            vc.usuarioLog[idUsuarioAModificar].edad = edad
            vc.usuarioLog[idUsuarioAModificar].contraseña = txtPassword.stringValue
            vc.usuarioLog[idUsuarioAModificar].confirmarContraseña = txtConfirmarPassword.stringValue
            vc.usuarioLog[idUsuarioAModificar].rol = rolSeleccionado
            
            vcMenu.txtNombreUsuario.stringValue = "Bienvenide " + vc.usuarioLog[idDeUsuarioRecibido].nombre
            
            dismiss(self)
        }

                
    }
    
    func autorellenarCampos(){
            
            lblCamposVacios.isHidden = true
                    
                    idDeUsuarioRecibido = vc.idUsuarioActual
                    
                        txtNombre.stringValue = vc.usuarioLog[idUsuarioAModificar].nombre
                        txtApellidoPaterno.stringValue=vc.usuarioLog[idUsuarioAModificar].apellidoPaterno
                        txtApellidoMaterno.stringValue = vc.usuarioLog[idUsuarioAModificar].apellidoMaterno
                        txtEmail.stringValue=vc.usuarioLog[idUsuarioAModificar].email
                        txtTelefono.stringValue = vc.usuarioLog[idUsuarioAModificar].telefono
                        txtGenero.stringValue=vc.usuarioLog[idUsuarioAModificar].genero
                        lblEdad.stringValue = "Edad: \(vc.usuarioLog[idUsuarioAModificar].edad)"
                        txtPassword.stringValue = vc.usuarioLog[idUsuarioAModificar].contraseña
                        txtConfirmarPassword.stringValue = vc.usuarioLog[idUsuarioAModificar].contraseña
        
        
                        cmbRoles.selectItem(at: obtenerIndiceRol())
    }
    
    func obtenerIndiceRol() -> Int{
        switch vc.usuarioLog[idUsuarioAModificar].rol {
        case "Admin": return 0
        case "Cliente": return 1
        case "Compras": return 2
        case "Ventas": return 3
        default:
            print("Algo salió muy mal (sacar índice rol)")
            return 1
        }
    }
    
    func registrarUsuario(){
        if hacerValidaciones(){
            lblCamposVacios.isHidden = true
            
            vc.usuarioLog.append(UsuarioModelo(position, txtNombre.stringValue, txtApellidoPaterno.stringValue, txtApellidoMaterno.stringValue, txtEmail.stringValue, txtTelefono.stringValue, txtGenero.stringValue,
                         calcularEdad(),                      txtPassword.stringValue, txtConfirmarPassword.stringValue, rolSeleccionado))
            
            print("Agregaste")
            
            dismiss(self)
        }
    }
    
    func calcularEdad() -> Int{
        let calendario = Calendar(identifier: .gregorian)
        
        let fechaNacimiento = dtpFechaNacimiento.dateValue
        let fechaActual = Date()
        
        let componentesFechaNacimiento = calendario.dateComponents([.year, .month, .day], from: fechaNacimiento)
        let componentesFechaActual = calendario.dateComponents([.year, .month, .day], from: fechaActual)

        var edad = componentesFechaActual.year! - componentesFechaNacimiento.year!

        // Comprobar si todavía no ha pasado su cumpleaños este año
        if (componentesFechaNacimiento.month! > componentesFechaActual.month!) || (componentesFechaNacimiento.month! == componentesFechaActual.month! && componentesFechaNacimiento.day! > componentesFechaActual.day!) {
          edad -= 1
        }
        
        lblEdad.stringValue = "Edad: \(edad)"
        return edad

    }
    
    func hacerValidaciones()->Bool{
        if validarCamposVacios(){
            if emailEsValido(){
                if numeroTelfonicoEsValido(){
                    if validarPasswordsIguales(){
                        return true
                    }else{
                        lblCamposVacios.stringValue = "Las contraseñas no coinciden"
                        lblCamposVacios.isHidden = false
                    }
                }else{
                    lblCamposVacios.stringValue = "Inserta un teléfono válido"
                    lblCamposVacios.isHidden = false
                }
            }else{
                lblCamposVacios.stringValue = "Inserta un email válido"
                lblCamposVacios.isHidden = false
            }
        }else{
            lblCamposVacios.stringValue = "Recuerda llenar todos los campos"
            lblCamposVacios.isHidden = false
        }
        return false
    }
    
    
    func validarCamposVacios()->Bool{
        if txtNombre.stringValue == "" ||
            txtApellidoPaterno.stringValue == "" ||
            txtApellidoMaterno.stringValue == "" ||
            txtEmail.stringValue == "" ||
            txtTelefono.stringValue == "" ||
            txtGenero.stringValue == "" ||
            txtPassword.stringValue == "" ||
            txtConfirmarPassword.stringValue == ""
            {
            return false
        }
        else if txtNombre.stringValue.trimmingCharacters(in: .whitespaces).isEmpty ||
                    txtApellidoPaterno.stringValue.trimmingCharacters(in: .whitespaces).isEmpty ||
                    txtApellidoMaterno.stringValue.trimmingCharacters(in: .whitespaces).isEmpty ||
                    txtGenero.stringValue.trimmingCharacters(in: .whitespaces).isEmpty ||
                    txtPassword.stringValue.trimmingCharacters(in: .whitespaces).isEmpty
        {
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
