//
//  RegistroAdmin.swift
//  ProyectoFinal1
//
//  Created by Valeria Baeza on 06/05/23.
//

import Cocoa

class RegistroAdmin: NSViewController {

    //TODO: Validar contraseñas seguras
    //TODO: Que al cambiar fondo/imagen de uno mismo cambie al cerrar ventana o no te deje cambiar tus propios cosis

    @IBOutlet weak var vc: ViewController!
    @IBOutlet weak var vcMenu: MenuAdmin!
    
    var modificar:Bool = false
    var idDeUsuarioRecibido:Int = 0
    var idUsuarioAModificar:Int = 0
    var pantalla = ""
    var position:Int = 0
    let roles = ["Admin", "Cliente", "Compras", "Ventas"]
    var rolSeleccionado:String = "Cliente"
    let colores = ["Rosa", "Morado", "Amarillo", "Verde", "Azul", "Sin color"]
    var colorSeleccionado: String = "Rosa"
    let imagenesFondo = ["trina", "andre", "cat", "robbie", "beck", "jade", "tori", "Sin avatar"]
    var imgSeleccionada: String = "trina"
    
    var emailTemporal:String = ""
    var edad:Int = 0
    
    @objc dynamic var usuarioLog:[UsuarioModelo] = []
    
    @IBOutlet weak var lblTitulo: NSTextField!
    
    @IBOutlet weak var txtNombre: NSTextField!
    @IBOutlet weak var txtApellidoPaterno: NSTextField!
    @IBOutlet weak var txtApellidoMaterno: NSTextField!
    @IBOutlet weak var txtEmail: NSTextField!
    @IBOutlet weak var txtTelefono: NSTextField!
    @IBOutlet weak var txtGenero: NSTextField!
    
    @IBOutlet weak var dtpFechaNacimiento: NSDatePicker!
    @IBOutlet weak var lblEdad: NSTextField!
    
    @IBOutlet weak var txtPassword: NSTextField!
    @IBOutlet weak var txtConfirmarPassword: NSTextField!
    
    @IBOutlet weak var cmbRoles: NSPopUpButton!
    @IBOutlet weak var lblRolAdmin: NSTextField!
    
    @IBOutlet weak var cmbColorFondo: NSPopUpButton!
    @IBOutlet weak var cmbImagenFondo: NSPopUpButton!
    
    @IBOutlet weak var lblCamposVacios: NSTextField!
    
    @IBOutlet weak var btnRegistrar: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cmbRoles.removeAllItems()
        cmbRoles.addItems(withTitles: roles)
        
        cmbColorFondo.removeAllItems()
        cmbColorFondo.addItems(withTitles: colores)
        
        cmbImagenFondo.removeAllItems()
        cmbImagenFondo.addItems(withTitles: imagenesFondo)
        
        if modificar{
            autorellenarCampos()
            lblTitulo.stringValue = "Modificar"
            btnRegistrar.title = "Modificar"
            
            cmbRoles.selectItem(at: obtenerIndiceRol(id:idUsuarioAModificar))
            cmbColorFondo.selectItem(at: obtenerIndiceColor(id:idUsuarioAModificar))
            cmbImagenFondo.selectItem(at: obtenerIndiceImagen(id:idUsuarioAModificar))
            
            permitirCambioRol(usuarioLoggeado: vc.idUsuarioActual)
        }else{
            btnRegistrar.title = "Registrar"
            lblTitulo.stringValue = "Registro"
            
            cmbRoles.selectItem(at: 1)
            cmbColorFondo.selectItem(at:0)
            cmbImagenFondo.selectItem(at:0)
            
            lblRolAdmin.isHidden=true
        }
        
        lblCamposVacios.isHidden = true;
        
        position = vc.usuarioLog.count
        
        print("valor de bool modificar: \(String(describing: modificar))")
    }
    
    @IBAction func rolCambiado(_ sender: NSPopUpButton) {
        let indiceSeleccionado = sender.indexOfSelectedItem
            rolSeleccionado = roles[indiceSeleccionado]
            
        }
    
    @IBAction func colorCambiado(_ sender: NSPopUpButton) {
        let indiceSeleccionado = sender.indexOfSelectedItem
            colorSeleccionado = colores[indiceSeleccionado]
        }
    
    @IBAction func imgCambiado(_ sender: NSPopUpButton) {
        let indiceSeleccionado = sender.indexOfSelectedItem
            imgSeleccionada = imagenesFondo[indiceSeleccionado]
            
        }
    
    @IBAction func modficarORegistrarUsuario(_ sender: NSButton) {
        print("entra a ibaction?????????")
        if modificar == true {
            modificarUsuario()
        }
        else {
            print("entra a else de registrar usuario")
            registrarUsuario()
        }
    }
    
    
    func modificarUsuario(){
        print("entra a modificar usuario :p")
        calcularEdad()
        if hacerValidaciones(){
            print("entra a modificar usuario hacer validaciones correctas:p")
            lblCamposVacios.isHidden = true
            
            vc.usuarioLog[idUsuarioAModificar].nombre = txtNombre.stringValue
            vc.usuarioLog[idUsuarioAModificar].apellidoMaterno = txtApellidoMaterno.stringValue
            vc.usuarioLog[idUsuarioAModificar].apellidoPaterno = txtApellidoPaterno.stringValue
            vc.usuarioLog[idUsuarioAModificar].email = txtEmail.stringValue
            vc.usuarioLog[idUsuarioAModificar].telefono = txtTelefono.stringValue
            vc.usuarioLog[idUsuarioAModificar].genero = txtGenero.stringValue
            vc.usuarioLog[idUsuarioAModificar].fechaNacimiento = dtpFechaNacimiento.dateValue
            vc.usuarioLog[idUsuarioAModificar].edad = edad
            vc.usuarioLog[idUsuarioAModificar].contraseña = txtPassword.stringValue
            vc.usuarioLog[idUsuarioAModificar].confirmarContraseña = txtConfirmarPassword.stringValue
            vc.usuarioLog[idUsuarioAModificar].rol = rolSeleccionado
            
            if obtenerIndiceColor(id: idUsuarioAModificar) != 5{
                vc.usuarioLog[idUsuarioAModificar].colorFondo = colorSeleccionado
            }else{
                vc.usuarioLog[idUsuarioAModificar].colorFondo = ""
            }
            
            if obtenerIndiceImagen(id: idUsuarioAModificar) != 7{
                vc.usuarioLog[idUsuarioAModificar].imgFondo = imgSeleccionada
            }else{
                vc.usuarioLog[idUsuarioAModificar].colorFondo = ""
            }
            
            vcMenu.txtNombreUsuario.stringValue = "Bienvenide " + vc.usuarioLog[idDeUsuarioRecibido].nombre
            
            dismiss(self)
        }

                
    }
    
    func autorellenarCampos(){
            
            lblCamposVacios.isHidden = true
        emailTemporal = vc.usuarioLog[idUsuarioAModificar].email
                    
                    idDeUsuarioRecibido = vc.idUsuarioActual
                    
                        txtNombre.stringValue = vc.usuarioLog[idUsuarioAModificar].nombre
                        txtApellidoPaterno.stringValue=vc.usuarioLog[idUsuarioAModificar].apellidoPaterno
                        txtApellidoMaterno.stringValue = vc.usuarioLog[idUsuarioAModificar].apellidoMaterno
                        txtEmail.stringValue=vc.usuarioLog[idUsuarioAModificar].email
                        txtTelefono.stringValue = vc.usuarioLog[idUsuarioAModificar].telefono
                        txtGenero.stringValue=vc.usuarioLog[idUsuarioAModificar].genero
                        dtpFechaNacimiento.dateValue = vc.usuarioLog[idUsuarioAModificar].fechaNacimiento
                        lblEdad.stringValue = "Edad: \(vc.usuarioLog[idUsuarioAModificar].edad)"
                        txtPassword.stringValue = vc.usuarioLog[idUsuarioAModificar].contraseña
                        txtConfirmarPassword.stringValue = vc.usuarioLog[idUsuarioAModificar].contraseña
        
        cmbRoles.selectItem(at: obtenerIndiceRol(id: idUsuarioAModificar))
        
        if obtenerIndiceColor(id: idUsuarioAModificar) != 5{
            cmbColorFondo.selectItem(at: obtenerIndiceColor(id: idUsuarioAModificar))
        }else{
            cmbColorFondo.selectItem(at:0)
        }
        
        if obtenerIndiceImagen(id: idUsuarioAModificar) != 7{
            cmbImagenFondo.selectItem(at: obtenerIndiceImagen(id: idUsuarioAModificar))
        }else{
            cmbImagenFondo.selectItem(at:0)
        }
    }
    
    func obtenerIndiceRol(id:Int) -> Int{
       
        switch vc.usuarioLog[id].rol {
        case "Admin": return 0
        case "Cliente": return 1
        case "Compras": return 2
        case "Ventas": return 3
        default:
            print("Algo salió muy mal (sacar índice rol)")
            return 1
        }
    }
    
    func obtenerIndiceColor(id:Int) -> Int{
       
        switch vc.usuarioLog[id].colorFondo {
        case "Rosa": return 0
        case "Morado": return 1
        case "Amarillo": return 2
        case "Verde": return 3
        case "Azul": return 4
        case "Sin color": return 5
        default:
            return 5
        }
    }
    
    func obtenerIndiceImagen(id:Int) -> Int{
       
        switch vc.usuarioLog[id].imgFondo {
        case "trina": return 0
        case "andre": return 1
        case "cat": return 2
        case "robbie": return 3
        case "beck": return 4
        case "jade": return 5
        case "tori": return 6
        case "Sin avatar": return 7
        default:
            return 7
        }
    }
    
    func registrarUsuario(){
        print("entra a registrar usuario")
        calcularEdad()
        if hacerValidaciones(){
            lblCamposVacios.isHidden = true
            
            calcularEdad()
            
            vc.usuarioLog.append(UsuarioModelo(position, txtNombre.stringValue, txtApellidoPaterno.stringValue, txtApellidoMaterno.stringValue, txtEmail.stringValue, txtTelefono.stringValue, txtGenero.stringValue, edad
                                               ,            txtPassword.stringValue, txtConfirmarPassword.stringValue, rolSeleccionado, dtpFechaNacimiento.dateValue, colorSeleccionado, imgSeleccionada))
            
            print("Agregaste!!!!")
            print("id de user agregado", position)
            dismiss(self)
        }
    }
    
    func calcularEdad(){
        let calendario = Calendar(identifier: .gregorian)
        
        let fechaNacimiento = dtpFechaNacimiento.dateValue
        let fechaActual = Date()
        
        let componentesFechaNacimiento = calendario.dateComponents([.year, .month, .day], from: fechaNacimiento)
        let componentesFechaActual = calendario.dateComponents([.year, .month, .day], from: fechaActual)

        edad = componentesFechaActual.year! - componentesFechaNacimiento.year!

        // Comprobar si todavía no ha pasado su cumpleaños este año
        if (componentesFechaNacimiento.month! > componentesFechaActual.month!) || (componentesFechaNacimiento.month! == componentesFechaActual.month! && componentesFechaNacimiento.day! > componentesFechaActual.day!) {
          edad -= 1
        }
        
        lblEdad.stringValue = "Edad: \(edad)"

    }
    
    func hacerValidaciones()->Bool{
        if validarCamposVacios(){
            if validarNoUsuarioRepetido(){
                if emailEsValido(){
                    if numeroTelfonicoEsValido(){
                        if validarEdad(){
                            if validarPasswordsIguales(){
                                return true
                            }else{
                                lblCamposVacios.stringValue = "Las contraseñas no coinciden"
                                lblCamposVacios.isHidden = false
                            }
                        }else{
                            lblCamposVacios.stringValue = "Edad inválida"
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
                lblCamposVacios.stringValue = "Ese usuario ya existe"
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
    
    func validarNoUsuarioRepetido()->Bool{
        if modificar{
            print("entra a modificar en validación de usuario repetido")
            print("email",emailTemporal)
            if txtEmail.stringValue == emailTemporal{
                print("email",emailTemporal)
                return true
            }else{
                for usuario in vc.usuarioLog {
                    if txtEmail.stringValue == usuario.email{
                        return false
                    }
                }
                return true
            }
        }else{
            for usuario in vc.usuarioLog {
                if txtEmail.stringValue == usuario.email{
                    return false
                }
            }
            return true
        }
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
    
    func validarEdad()->Bool{
        if edad<18{
            return false
        }
        return true
    }
    
    func validarPasswordsIguales()->Bool{
        if txtPassword.stringValue == txtConfirmarPassword.stringValue{
            return true
        }
        return false
    }
    
    func permitirCambioRol(usuarioLoggeado : Int) {
        
        if idUsuarioAModificar == 1 {
            lblRolAdmin.isHidden=false
            cmbRoles.isHidden = true
        }
        else if vc.idUsuarioActual == idUsuarioAModificar {
            lblRolAdmin.isHidden=false
            cmbRoles.isHidden = true
        }
        else{
            lblRolAdmin.isHidden=true
            cmbRoles.isHidden = false
        }
       
    }
    
    @IBAction func cerrarViewController(_ sender: NSButton) {
        dismiss(self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="registrarUsuarioSegue"{
            //(segue.destinationController as! RegistrarUsuario).vc = self
        }
    }
 
}
