//
//  MenuAdmin.swift.
//  Drinkable Inc
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
    
    //TODO: índices de eliminar, agregar y modificar estan mal
    
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
    var usuarioAModificar = UsuarioModelo(0, "", "", "", "", "", "", 0, "", "", "", Date(), "", "")
    var usuarioAEliminar = UsuarioModelo(0, "", "", "", "", "", "", 0, "", "", "", Date(), "", "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let usuarioActual = vc.usuarioLog
        idUsuarioActual = vc.idUsuarioActual
        
        print("aaaaaaaaa",usuarioActual[idUsuarioActual].colorFondo);
        
        vc.cambiarImagenYFondo(idUsuarioActual: vc.idUsuarioActual, imgAvatar: imgAvatar, view: self.view)
        
        clientes = []
        
        print("MENU ADMIN: bool es admin? ",vc.usuarioEsAdmin)
        
        lblIDIncorrecto.isHidden = true
        lblBajaCorrecta.isHidden = true
        
        
        
        txtNombreUsuario.stringValue = "Bienvenide " + usuarioActual[idUsuarioActual].nombre
    }
    
    
    @IBAction func irAMenuCompras(_ sender: NSButton) {
        lblBajaCorrecta.isHidden = true
        lblIDIncorrecto.isHidden = true
        performSegue(withIdentifier: "irMenuComprasAdmin", sender: self)
    }
    
    @IBAction func irAMenuVentas(_ sender: NSButton) {
        lblBajaCorrecta.isHidden = true
        lblIDIncorrecto.isHidden = true
        performSegue(withIdentifier: "irMenuVentasAdmin", sender: self)
    }
    
    @IBAction func irAMenuPedidos(_ sender: NSButton) {
        
        if txtIdCliente.stringValue != "" && txtID.stringValue==""{
            if soloHayNumerosEnTxtID(){
                idUsuarioPedidos = txtIdCliente.integerValue
               idCliente=buscarIdCliente(id:idUsuarioPedidos)
                if  idCliente != -1 && idCliente != 0
                {
                    lblIDIncorrecto.isHidden = true
                    lblBajaCorrecta.isHidden = true
                    performSegue(withIdentifier: "irMenuPedidosAdmin", sender: self)
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
                    lblIDIncorrecto.isHidden = true
                    lblBajaCorrecta.isHidden = true
                    performSegue(withIdentifier: "irMenuPedidosAdmin", sender: self)
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
        lblIDIncorrecto.isHidden = true
        lblBajaCorrecta.isHidden = true
        performSegue(withIdentifier: "irARegistrar", sender: self)
    }
    
    @IBAction func eliminarUsuario(_ sender: NSButton) {
        if txtID.stringValue != ""{
            if soloHayNumerosEnTxtID(){
                idUsuarioAEliminar = sacarPosicionUsuario(idDeTxt: txtID.integerValue)
                if getUsuarioAEliminar().id != 0 {
                    if idUsuarioActual != getUsuarioAEliminar().id{
                        if checarExistenciaUsuario(id: idUsuarioAEliminar){
                            if usuarioAEliminar.rol=="Cliente"{
                                if !validarClienteYaEliminado(){
                                    usuarioAEliminar.nombre="-1"
                                    usuarioAEliminar.email="-1"
                                }
                            }else{
                                vc.usuarioLog.remove(at: idUsuarioAEliminar)
                                lblBajaCorrecta.isHidden=false
                                lblIDIncorrecto.isHidden=true
                            }
                            //vc.contadorGlobalUsuarios -= 1
                          
                        }else{
                            print("usuario no existe??")
                            lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                            lblIDIncorrecto.isHidden = false
                            lblBajaCorrecta.isHidden = true
                        }
                    }else{
                        print("usuario se quiere matar")
                        lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                        lblIDIncorrecto.isHidden = false
                        lblBajaCorrecta.isHidden = true
                    }
                }else{
                    print("id usuario a eliminar es 0")
                    lblIDIncorrecto.stringValue = "*El admin no se puede eliminar*"
                    lblIDIncorrecto.isHidden = false
                    lblBajaCorrecta.isHidden = true
                }
            }else{
                print("hay letras")
                lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                lblIDIncorrecto.isHidden = false
                lblBajaCorrecta.isHidden = true
            }
        }else{
            print("campos vacios")
            lblIDIncorrecto.stringValue = "*Inserta el ID que quieres eliminar*"
            lblIDIncorrecto.isHidden = false
            lblBajaCorrecta.isHidden = true
        }
        
    }
    
    func validarClienteYaEliminado()->Bool{
        if usuarioAEliminar.nombre == "-1" && usuarioAEliminar.email == "-1"{
            lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
            lblIDIncorrecto.isHidden = false
            lblBajaCorrecta.isHidden = true
            return true
        }else{
            lblIDIncorrecto.isHidden = true
            lblBajaCorrecta.isHidden = false
            return false
        }
       
    }
    
    func sacarPosicionUsuario(idDeTxt:Int) -> Int{
        for usuario in vc.usuarioLog {
            if (usuario.id == idDeTxt) {
                print("usuario ganaodr eliminar ",vc.usuarioLog.firstIndex(of: usuario)!)
                print("usuario ganaodr eliminar ",usuario.id)
                return vc.usuarioLog.firstIndex(of: usuario)!
            }
        }
        return 0
    }
    
    @IBAction func irAModificar(_ sender: NSButton) {
        if txtID.stringValue != ""{
            if soloHayNumerosEnTxtID(){
                idUsuarioAModificar = txtID.integerValue
                
                if checarExistenciaUsuario(id: idUsuarioAModificar) && verificarUsuarioEsBorrado() == false{
                    print("pasa checar existencia usuario")
                    lblIDIncorrecto.isHidden = true
                    lblBajaCorrecta.isHidden = true
                    performSegue(withIdentifier: "irAModificar", sender: self)
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
        lblIDIncorrecto.isHidden = true
        lblBajaCorrecta.isHidden = true
        performSegue(withIdentifier: "irAConsultar", sender: self)
    }
    
    func checarExistenciaUsuario(id:Int) -> Bool{
        if (id==0){
            return false
        }
        for UsuarioModelo in vc.usuarioLog {
            if (String(UsuarioModelo.id) == txtID.stringValue) {
                return true
            }
        }
        return false
    }
    
    func verificarUsuarioEsBorrado() -> Bool {
        var usuarioEsModificado = false
        if getUsuarioAModificar().nombre == "-1" || getUsuarioAModificar().email == "-1"{
            usuarioEsModificado = true
        }
        else{
            usuarioEsModificado = false
        }
        return usuarioEsModificado
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
    
    func getUsuarioAModificar() -> UsuarioModelo {
        print (txtID.stringValue)
        for usuario in vc.usuarioLog{
            print(txtID.stringValue)
            if(txtID.stringValue == String(usuario.id)){
                usuarioAModificar = usuario
            }
        }
        print (usuarioAModificar.nombre)
        print ("wtffff")
        return usuarioAModificar
    }
    
    func getUsuarioAEliminar() -> UsuarioModelo {
        for usuario in vc.usuarioLog{
            if(txtID.stringValue == String(usuario.id)){
                usuarioAEliminar = usuario
            }
        }
        return usuarioAEliminar
    }
    
    
    
    func soloHayNumerosEnTxtID() -> Bool{
        let numericCharacters = CharacterSet.decimalDigits.inverted
        return txtID.stringValue.rangeOfCharacter(from: numericCharacters) == nil
    }
    
    @IBAction func volverAInicio(_ sender: NSButton) {
        dismiss(self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "irAModificar" {
            
            (segue.destinationController as! RegistroAdmin).vc = self.vc
            
            (segue.destinationController as! RegistroAdmin).vcMenu = self
            
            let destinationVC = segue.destinationController as! RegistroAdmin;
            
            destinationVC.idDeUsuarioRecibido = idUsuarioActual
            destinationVC.idUsuarioAModificar = idUsuarioAModificar
            destinationVC.modificar=true
            destinationVC.usuarioAModificar = getUsuarioAModificar()
            txtID.stringValue = ""
            
        }else if segue.identifier=="irARegistrar"{
            
            (segue.destinationController as! RegistroAdmin).vc = self.vc
            let destinationVC = segue.destinationController as! RegistroAdmin;
            destinationVC.modificar=false
            
        }else if segue.identifier=="irAConsultar"{
            (segue.destinationController as! ConsultarUsuario).usuarioLogTemp = vc.usuarioLog
            (segue.destinationController as! ConsultarUsuario).vcTabla = self.vc
        }else if segue.identifier=="irMenuComprasAdmin"{
            (segue.destinationController as! MenuCompras).vc = vc
            
        }else if segue.identifier=="irMenuVentasAdmin"{
            (segue.destinationController as! MenuVentas).vc = vc
        }else if segue.identifier=="irMenuPedidosAdmin"{
            (segue.destinationController as! PedidosCliente).vcTablaPedidos = vc
            (segue.destinationController as! PedidosCliente).idClienteAdmin = idCliente
            
            (segue.destinationController as! PedidosCliente).ventasLog = vc.ventasLog
        }
    }
}
