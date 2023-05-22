//
//  PedidosCliente.swift
//  ProyectoFinal1
//
//  Created by Diego Juárez on 07/05/23.
//

import Cocoa

class PedidosCliente: NSViewController {
    
    //TODO: Todeeeeeee
    
    @IBOutlet var vcTablaPedidos: ViewController!
    @objc dynamic var ventasLog:[VentaModelo] = []
    @objc dynamic var pedidosLog:[PedidoModelo] = []
    @objc dynamic var clientesLog:[UsuarioModelo] = []
    
    var idClienteActual:Int!
    var idUsuarioActual:Int!
    var usuarios:[UsuarioModelo]!
    var clientes:[UsuarioModelo]!
    
    //TO DO: MOSTRAR EL TOTAL DEL PEDIDO
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usuarios = vcTablaPedidos.usuarioLog
        clientes = []
        idUsuarioActual = vcTablaPedidos.idUsuarioActual
        
        buscarClientes()
        
        obtenerIdClienteActual()
        
        
       pedidosLog.append(PedidoModelo(1, 1, 1, 100, 100, 200, false))
    pedidosLog.append(PedidoModelo(2, 2, 1, 100, 100, 200, false))
        
        
        
        print(clientes[idClienteActual].nombre)

    }
    
    func buscarClientes(){
        for usuario in usuarios {
            if (usuario.rol=="Cliente"){
                clientes.append(usuario)
            }
        }
    }
    
    func obtenerIdClienteActual(){
        for cliente in clientes {
            if (cliente.id == idUsuarioActual){
                idClienteActual = clientes.firstIndex(of: cliente)
            }
        }
    }
}
