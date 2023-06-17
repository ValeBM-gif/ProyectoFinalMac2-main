//
//  MenuAdmin.swift.
//  ProyectoFinal1.
//
//  Created by Diego Juárez on 25/04/23.
//

import Cocoa

extension NSColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

class MenuAdmin: NSViewController {
    
    //TODO: que exista el user
    
    @IBOutlet weak var imgAvatar: NSImageView!
    
    @IBOutlet weak var vc: ViewController!
    
    @IBOutlet weak var txtNombreUsuario: NSTextField!
    @IBOutlet weak var txtID: NSTextField!
    @IBOutlet weak var lblIDIncorrecto: NSTextField!
    
    @IBOutlet weak var txtIdCliente: NSTextField!
    @IBOutlet weak var lblBajaCorrecta: NSTextField!
    
    var idUsuarioActual:Int!
    var idUsuarioAModificar:Int=0
    var idUsuarioAEliminar:Int=0
    var idCliente:Int=0
    var idUsuarioPedidos:Int=0
    var clientes:[UsuarioModelo]!
    var colorFondo:String = "Rosa"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let usuarioActual = vc.usuarioLog
        idUsuarioActual = vc.idUsuarioActual
        
        print("aaaaaaaaa",usuarioActual[idUsuarioActual].colorFondo);
        
        colorFondo(color: usuarioActual[idUsuarioActual].colorFondo)
        if usuarioActual[idUsuarioActual].imgFondo != "Sin avatar"{
            imgAvatar.isHidden = false
            imgAvatar.image = NSImage(named: usuarioActual[idUsuarioActual].imgFondo)
        }else{
            imgAvatar.isHidden = true
        }
        
        clientes = []
        
        print("MENU ADMIN: bool es admin? ",vc.usuarioEsAdmin)
        
        lblIDIncorrecto.isHidden = true
        lblBajaCorrecta.isHidden = true
        
        
        
        txtNombreUsuario.stringValue = "Bienvenide " + usuarioActual[idUsuarioActual].nombre
    }
    
    func colorFondo(color:String){
        view.wantsLayer = true
        if color=="Rosa"{
            view.layer?.backgroundColor = NSColor(hex: 0xFBDEF9).cgColor
        }else if color=="Morado"{
            view.layer?.backgroundColor = NSColor(hex: 0xEEDEFB).cgColor
        }else if color=="Amarillo"{
            view.layer?.backgroundColor = NSColor(hex: 0xFBF4DE).cgColor
        }else if color=="Verde"{
            view.layer?.backgroundColor = NSColor(hex: 0xFBF4DE).cgColor
        }else if color == "Azul"{
            view.layer?.backgroundColor = NSColor(hex: 0xb2d1d1).cgColor
        }else{
            view.wantsLayer = false
        }
        
    }
    
    @IBAction func irAMenuCompras(_ sender: NSButton) {
        performSegue(withIdentifier: "irMenuComprasAdmin", sender: self)
    }
    
    @IBAction func irAMenuVentas(_ sender: NSButton) {
        performSegue(withIdentifier: "irMenuVentasAdmin", sender: self)
    }
    
    @IBAction func irAMenuPedidos(_ sender: NSButton) {
        
        if txtIdCliente.stringValue != "" && txtID.stringValue==""{
            if soloHayNumerosEnTxtID(){
                idUsuarioPedidos = txtIdCliente.integerValue
               idCliente=buscarIdCliente(id:idUsuarioPedidos)
                if  idCliente != -1 && idCliente != 0
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
        }else if txtID.stringValue != "" && txtIdCliente.stringValue == ""{
            if soloHayNumerosEnTxtID(){
                idCliente = txtID.integerValue
              
                if  buscarIdClienteValido(id:idCliente)
                {
                    performSegue(withIdentifier: "irMenuPedidosAdmin", sender: self)
                    lblIDIncorrecto.isHidden = true
                    lblBajaCorrecta.isHidden = true
                    
                }else{
                    lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                    lblIDIncorrecto.isHidden = false
                    lblBajaCorrecta.isHidden = true
                }
            }
            else{
                lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                lblIDIncorrecto.isHidden = false
                lblBajaCorrecta.isHidden = true
            }
            
        } else if txtID.stringValue != "" && txtIdCliente.stringValue != "" {
            lblIDIncorrecto.stringValue = "*Sólo se puede buscar por un tipo de ID a la vez*"
            lblIDIncorrecto.isHidden = false
            lblBajaCorrecta.isHidden = true
            
        }
        else{
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
                            if(vc.usuarioLog[idUsuarioAEliminar].rol=="Cliente"){
                                vc.usuarioLog[idUsuarioAEliminar].nombre="-1"
                                vc.usuarioLog[idUsuarioAEliminar].email="-1"
                            }else{
                                vc.usuarioLog.remove(at: idUsuarioAEliminar)}
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
    
    func buscarClientes(){
        for usuario in vc.usuarioLog {
            if (usuario.rol=="Cliente"){
                clientes.append(usuario)
            }
        }
    }
    
    func buscarIdCliente(id:Int) -> Int{
        buscarClientes()
       
        for cliente in clientes {
            if (clientes.firstIndex(of: cliente)  == id && cliente.email != "-1"){
                
                return cliente.id
            }
        }
        return -1
    }
    
    func buscarIdClienteValido(id:Int) -> Bool{
        buscarClientes()
        if id == 0{
            return false
        }
        for cliente in clientes {
            if (cliente.id == id && cliente.email != "-1"){
                
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
            (segue.destinationController as! PedidosCliente).idClienteAdmin = idCliente
            
            (segue.destinationController as! PedidosCliente).ventasLog = vc.ventasLog
            (segue.destinationController as! PedidosCliente).productosLog = vc.productoLog
        }
    }
}
