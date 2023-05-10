//
//  ViewController.swift
//  ProyectoFinal1
//
//  Created by Valeria Baeza on 19/04/23.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var txtUsuario: NSTextField!
    @IBOutlet weak var txtPassword: NSTextField!
    @IBOutlet weak var lblIncorrecto: NSTextField!
    
    @objc dynamic var usuarioLog:[UsuarioModelo] = []
    
    var idUsuarioActual: Int!
    
    override func viewDidLoad() {
        
        usuarioLog.append(UsuarioModelo(0, "Uriel", "Resendiz", "Medina", "murmi@lasalle.com","4771234567", "no binarie", "123", "123","Admin"))
        usuarioLog.append(UsuarioModelo(1, "Pedro", "f", "f", "p@g.com","4771234567", "no binarie", "123", "123","Ventas"))

        lblIncorrecto.isHidden=true
    }
    
    override func viewDidAppear(){
        self.view.window?.title = "Iniciar sesión"
    }
    
    @IBAction func iniciarSesion(_ sender: NSButton) {
        
        let resultadoLogin = login(username: txtUsuario.stringValue, password: txtPassword.stringValue)
               
               if(resultadoLogin is UsuarioModelo){
                   
                   lblIncorrecto.isHidden = true
                   let UsuarioActual = resultadoLogin as! UsuarioModelo
                   idUsuarioActual=UsuarioActual.id
                   if UsuarioActual.rol == "Cliente"{
                       performSegue(withIdentifier: "irVcCliente", sender: self)
                   }else if UsuarioActual.rol == "Admin"{
                       performSegue(withIdentifier: "iniciarSesionCorrecto", sender: self)
                   }else if UsuarioActual.rol == "Ventas"{
                       performSegue(withIdentifier: "irMenuVentas", sender: self)
                   }else if UsuarioActual.rol == "Compras"{
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
            
        }else if segue.identifier=="irVcMenuCompras"{
            (segue.destinationController as! MenuCompras).vc = self
            
        }else if segue.identifier=="irVcCliente"{
            (segue.destinationController as! PedidosCliente).vcTablaPedidos = self
        }
    }
    


}

