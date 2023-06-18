//
//  MenuVentas.swift
//  ProyectoFinal1
//
//  Created by Uriel Resendiz on 07/05/23.
//

import Cocoa

class MenuVentas: NSViewController {
    
    //TODO: validar que solo deje vender a clientes
    
    @IBOutlet weak var imgAvatar: NSImageView!
    
    @IBOutlet weak var vc: ViewController!
    
    @IBOutlet weak var txtID: NSTextField!
    @IBOutlet weak var btnBuscar: NSButton!
    @IBOutlet weak var lblIDIncorrecto: NSTextField!
    @IBOutlet weak var btnAtras: NSButton!
    @IBOutlet weak var btnCerrarSesion: NSButton!
    
    var idClienteABuscar: Int=0
    var nombreClienteABuscar:String = ""
    var nombreVendedor:String = ""
    var esClienteOAdmin: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MENU VENTAS: bool es admin? ",vc.usuarioEsAdmin)
        if vc.usuarioEsAdmin{
            btnAtras.isHidden = false
            btnCerrarSesion.isHidden = true
        }else{
            btnAtras.isHidden = true
            btnCerrarSesion.isHidden = false
        }
        
        let usuarioActual = vc.usuarioLog
        var idUsuarioActual:Int = vc.idUsuarioActual
        
        colorFondo(color: usuarioActual[idUsuarioActual].colorFondo)
        if usuarioActual[idUsuarioActual].imgFondo != "Sin avatar"{
            imgAvatar.isHidden = false
            imgAvatar.image = NSImage(named: usuarioActual[idUsuarioActual].imgFondo)
        }else{
            imgAvatar.isHidden = true
        }
        
        lblIDIncorrecto.isHidden = true
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
    
    @IBAction func buscarCliente(_ sender: NSButton){
        if txtID.stringValue != ""{
            if soloHayNumerosEnTxtID(){
                idClienteABuscar = txtID.integerValue
                lblIDIncorrecto.isHidden = true
                print("id cliente a buscar",idClienteABuscar)
                if checarExistenciaCliente(id: idClienteABuscar){
                    print("cliente existe")
                    if checarSiEsClienteOAdmin(id: idClienteABuscar){
                        print("es cliente o admin")
                        performSegue(withIdentifier: "irVentas", sender: self)
                    }
                }else{
                    performSegue(withIdentifier: "irVcRegistroVentas", sender: self)
                    dismiss(self)
                }
            }else{
                lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
                lblIDIncorrecto.isHidden = false
            }
        }else{
            lblIDIncorrecto.stringValue = "*Inserta un ID válido*"
            lblIDIncorrecto.isHidden = false
        }
    }
    
    func soloHayNumerosEnTxtID() -> Bool{
        let numericCharacters = CharacterSet.decimalDigits.inverted
        return txtID.stringValue.rangeOfCharacter(from: numericCharacters) == nil
    }
    
    func checarExistenciaCliente(id:Int) -> Bool{
        for UsuarioModelo in vc.usuarioLog{
            if(UsuarioModelo.id == id){
                nombreClienteABuscar = UsuarioModelo.nombre
                print("nombre cliente a buscar",UsuarioModelo.nombre)
                return true
            }
        }
        return false
    }
    
    func checarSiEsClienteOAdmin(id: Int)->Bool{

        if vc.usuarioLog[id].rol == "Admin" || vc.usuarioLog[id].rol == "Cliente"{
            print("entra a admin/cliente")
            esClienteOAdmin = true
            lblIDIncorrecto.isHidden = true
            return true
        }else{
            lblIDIncorrecto.stringValue = "*Inserta un usuario válido*"
            lblIDIncorrecto.isHidden = false
            return false
        }
    }
    
    @IBAction func cerrarSesion(_ sender: NSButton) {
        dismiss(self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        print("entra a prepare")
        if segue.identifier == "irVcRegistroVentas" {
            let destinoVc = segue.destinationController as! RegistrarUsuario
            destinoVc.vcMenu = "Ventas"
            destinoVc.vc = vc
           
        }else if segue.identifier == "irVentas"{
            print("entra a segue irvemtas")
            let destinoVc = segue.destinationController as! CrearVenta
            destinoVc.vc = vc
            destinoVc.vcMenuVenta = self
        }
    }
    
    @IBAction func CerrarVc(_ sender: NSButton) {
        dismiss(self)
    }
}
