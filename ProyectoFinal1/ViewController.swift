//
//  ViewController.swift
//  ProyectoFinal1
//
//  Created by Valeria Baeza on 19/04/23.
//

import Cocoa

class ViewController: NSViewController {
        
    @IBOutlet weak var vc: ViewController!
    
    @IBOutlet weak var txtUsuario: NSTextField!
    @IBOutlet weak var txtPassword: NSTextField!
    @IBOutlet weak var lblIncorrecto: NSTextField!
    
    @objc dynamic var usuarioLog:[UsuarioModelo] = []
    @objc dynamic var productoLog: [ProductoModelo] = []
    @objc dynamic var ventasLog:[VentaModelo] = []
    
    var idUsuarioActual: Int!
    var nombreUsuarioActual: String!

    var contadorIdVenta: Int = 1
    var usuarioEsAdmin: Bool = false
    
    override func viewDidLoad() {
        
        usuarioLog.append(UsuarioModelo(0, "Default User", "def", "def", "def@g.com","4771234567", "no binarie", 20, "123", "123","Admin",formatStringToDate(date: "2002/10/10")))
        usuarioLog.append(UsuarioModelo(1, "Uriel", "Resendiz", "Medina", "murmi@lasalle.com","4771234567", "no binarie", 20, "123", "123","Admin", formatStringToDate(date: "2003/04/26")))
        usuarioLog.append(UsuarioModelo(2, "Pedro", "f", "f", "p@g.com","4771234567", "no binarie", 20, "123", "123","Ventas", formatStringToDate(date: "2002/08/23")))
        usuarioLog.append(UsuarioModelo(3, "Cliente", "f", "f", "c@g.com","4771234567", "no binarie", 21, "123", "123","Cliente", formatStringToDate(date: "2001/02/17")))
        usuarioLog.append(UsuarioModelo(4, "vale", "b", "m", "v@g.com","4771234567", "no binarie", 20, "123", "123","Compras", formatStringToDate(date: "2002/07/20")))
        usuarioLog.append(UsuarioModelo(5, "valeAdmin", "b", "m", "v2@g.com","4771234567", "no binarie", 20, "123", "123","Admin", formatStringToDate(date: "2002/07/20")))
        usuarioLog.append(UsuarioModelo(6, "valeAdmin2", "b", "m", "v3@g.com","4771234567", "no binarie", 20, "123", "123","Admin", formatStringToDate(date: "2002/07/20")))
        
        productoLog.append(ProductoModelo(0, "Default Prod", "def", "def", 1, 1, "def", 1, 0, "def"))
        productoLog.append(ProductoModelo(1, "awita", "de limon", "lt", 10, 5, "liquidoss", 20, 3, "vale"))
        productoLog.append(ProductoModelo(2, "jugue", "de uva", "ml", 20, 10, "liquidoss complejos", 30, 0, "uriel"))
        productoLog.append(ProductoModelo(3, "awita", "de limon", "lt", 30, 5, "liquidoss", 20, 3, "vale"))
        productoLog.append(ProductoModelo(4, "jugue", "de uva", "ml", 40, 10, "liquidoss complejos", 30, 2, "Cliente"))

        lblIncorrecto.isHidden=true
    }
    
    override func viewDidAppear(){
        self.view.window?.title = "Iniciar sesión"
    }
    
    func formatStringToDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = date
        let date = dateFormatter.date(from: dateString)
        print(date)
        return date!
    }
    
    @IBAction func iniciarSesion(_ sender: NSButton) {
        
        let resultadoLogin = login(username: txtUsuario.stringValue, password: txtPassword.stringValue)
               
               if(resultadoLogin is UsuarioModelo){
                   txtUsuario.stringValue = ""
                   txtPassword.stringValue = ""
                   lblIncorrecto.isHidden = true
                   let UsuarioActual = resultadoLogin as! UsuarioModelo
                   idUsuarioActual=UsuarioActual.id
                   nombreUsuarioActual=UsuarioActual.nombre
                   if UsuarioActual.rol == "Cliente"{
                       usuarioEsAdmin = false
                       
                       performSegue(withIdentifier: "irVcCliente", sender: self)
                   }else if UsuarioActual.rol == "Admin"{
                       usuarioEsAdmin = true
                       performSegue(withIdentifier: "iniciarSesionCorrecto", sender: self)
                   }else if UsuarioActual.rol == "Ventas"{
                       usuarioEsAdmin = false
                       performSegue(withIdentifier: "irMenuVentas", sender: self)
                   }else if UsuarioActual.rol == "Compras"{
                       usuarioEsAdmin = false
                       performSegue(withIdentifier: "irVcMenuCompras", sender: self)
                   }
               }
               else{
                   lblIncorrecto.isHidden = false;
               }
    }
    

    func login(username: String, password: String) -> Any {
        for UsuarioModelo in usuarioLog {
            if (UsuarioModelo.email == username && UsuarioModelo.contraseña == password) {
                return UsuarioModelo
            }
        }
        return false
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="registrarUsuarioSegue"{
            (segue.destinationController as! RegistrarUsuario).vc = self
        }
        else if segue.identifier=="iniciarSesionCorrecto"{(segue.destinationController as! MenuAdmin).vc = self
        }
        else if segue.identifier=="irMenuVentas"{(segue.destinationController as! MenuVentas).vc = self
            (segue.destinationController as! MenuVentas).nombreVendedor = nombreUsuarioActual
        }else if segue.identifier=="irVcMenuCompras"{
            (segue.destinationController as! MenuCompras).vc = self
            
        }else if segue.identifier=="irVcCliente"{
            (segue.destinationController as! PedidosCliente).vcTablaPedidos = self
        }
        print("VIEWCONTROLLER: bool es admin? ",usuarioEsAdmin)
    }
    
    
    


}

