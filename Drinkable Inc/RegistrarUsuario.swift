//
//  RegistrarUsuario.swift.
//  Drinkable Inc
//
//  Created by Valeria Baeza on 19/04/23.
//

import Cocoa

class RegistrarUsuario: NSViewController {
    
    //TODO: Validar contraseñas seguras
    
    @IBOutlet weak var vc: ViewController!
    
    @IBOutlet weak var txtNombre: NSTextField!
    @IBOutlet weak var txtApellidoPaterno: NSTextField!
    @IBOutlet weak var txtApellidoMaterno: NSTextField!
    @IBOutlet weak var txtEmail: NSTextField!
    @IBOutlet weak var txtTelefono: NSTextField!
    @IBOutlet weak var txtGenero: NSTextField!
    @IBOutlet weak var txtPassword: NSTextField!
    @IBOutlet weak var txtConfirmarPassword: NSTextField!
    
    @IBOutlet weak var cmbRoles: NSPopUpButton!
    
    @IBOutlet weak var btnRegistrar: NSButton!
    
    @IBOutlet weak var lblClienteExistente: NSTextField!
    @IBOutlet weak var lblCamposVacios: NSTextField!
    
    @IBOutlet weak var dtpFechaNacimiento: NSDatePicker!
    @IBOutlet weak var lblEdad: NSTextField!
    
    var position:Int = 0
    var vcMenu:String = "Menu"
    let roles = ["Admin", "Cliente", "Compras", "Ventas"]
    var rolSeleccionado:String = "Cliente"
    var idDeUsuarioRecibido:Int = 0
    var idUsuarioAModificar:Int = 0
    var edad:Int = 0
    
    @objc dynamic var usuarioLog:[UsuarioModelo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cmbRoles.isHidden = true
        
        cmbRoles.removeAllItems()
       cmbRoles.addItems(withTitles: roles)
        cmbRoles.selectItem(at: 1)
        
        lblCamposVacios.isHidden = true;
        
        position = vc.usuarioLog.count
        

        btnRegistrar.isEnabled = true
        
        lblClienteExistente.isHidden = true
        
        if(vcMenu=="Ventas"){
            lblClienteExistente.isHidden = false
        }
        
        //FALTA EL NSVIEW DE LA IMAGEN
        //vc.cambiarImagenYFondo(idUsuarioActual: vc.idUsuarioActual, imgAvatar: imgAvatar, view: self.view)
        
    }
    
    @IBAction func rolCambiado(_ sender: NSPopUpButton) {
        let indiceSeleccionado = sender.indexOfSelectedItem
            rolSeleccionado = roles[indiceSeleccionado]
            
        }
    
    @IBAction func registrarUsuario(_ sender: NSButton) {
        
        calcularEdad()
        
        if validarCamposVacios(){
            if validarNoUsuarioRepetido(){
                if validarPasswordsIguales(){
                    if emailEsValido(){
                        if numeroTelfonicoEsValido(){
                            if validarEdad(){
                                lblCamposVacios.isHidden = true
                                
                                vc.usuarioLog.append(UsuarioModelo(position, txtNombre.stringValue, txtApellidoPaterno.stringValue, txtApellidoMaterno.stringValue, txtEmail.stringValue, txtTelefono.stringValue, txtGenero.stringValue, edad, txtPassword.stringValue, txtConfirmarPassword.stringValue, "Cliente",dtpFechaNacimiento.dateValue, "", ""))
                                
                            print("Agregaste Cliente")
                                print("id de user agregado", position)

                                dismiss(self)
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
                    lblCamposVacios.stringValue = "Las contraseñas no coinciden"
                    lblCamposVacios.isHidden = false
                }
            }else{
                lblCamposVacios.stringValue = "Ese email ya está en uso"
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
    
    func validarNoUsuarioRepetido()->Bool{
        for usuario in vc.usuarioLog {
            if txtEmail.stringValue == usuario.email{
                return false
            }
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
    
    func validarEdad()->Bool{
        if edad<18{
            return false
        }
        return true
    }
    
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier=="irAMenuVentas"{
            (segue.destinationController as! MenuVentas).vc = self.vc
        }
    }
        
    @IBAction func cerrarViewController(_ sender: NSButton) {
       print("entra al ib action?")
        dismiss(self)
    }
    
    override func viewDidDisappear() {
        if(vcMenu=="Ventas"){
            performSegue(withIdentifier: "irAMenuVentas", sender: self)
        }
    }

}

