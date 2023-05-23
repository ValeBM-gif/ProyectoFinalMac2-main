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
    @objc dynamic var vieneDeAdmin: Bool  = false
    @objc dynamic var idClienteAdmin: Int = -1
    
    @objc dynamic var ventasLog:[VentaModelo] = []
    @objc dynamic var productosLog:[ProductoModelo] = []
    @objc dynamic var pedidosLog:[PedidoModelo] = []
    @objc dynamic var idsVentas:[Int] = []
    @objc dynamic var clientesLog:[UsuarioModelo] = []
    
    @IBOutlet weak var btnAtras: NSButton!
    
    @IBOutlet weak var tablaPedidos: NSTableView!
    var idClienteActual:Int!
    var idPedido:Int!
    var tempId:Int!
    var idUsuarioActual:Int!
    var usuarios:[UsuarioModelo]!
    var clientes:[UsuarioModelo]!
    
    //TO DO: MOSTRAR EL TOTAL DEL PEDIDO
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idPedido=1;
        tempId = -1;
        
        
        if vcTablaPedidos.usuarioEsAdmin{
            btnAtras.isHidden = false
        }else{
            btnAtras.isHidden = true
        }
        
        usuarios = vcTablaPedidos.usuarioLog
        clientes = []
        if(idClienteAdmin == -1){
            idUsuarioActual = vcTablaPedidos.idUsuarioActual
        }
        else{
            idUsuarioActual = idClienteAdmin
        }
        
        buscarClientes()
        
        obtenerIdClienteActual()
        
        buscarPedidosDeCliente()
        
        
        //
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
    func obtenerIdsVentas(){
        for venta in ventasLog{
            if (venta.idCliente == idClienteActual){
                if(!idsVentas.contains(venta.idVenta)){
                    idsVentas.append(venta.idVenta)
                }
            }
        }
    }
    
    func buscarPedidosDeCliente(){
        for venta in ventasLog
        {
            if (venta.idCliente == idClienteActual){
                print(venta.idVenta)
                if(tempId == -1){
                    tempId=venta.idVenta
                }
                else{
                    if(tempId != venta.idVenta){
                        tempId=venta.idVenta
                        pedidosLog.append(PedidoModelo(idPedido-1, "", "Total Pedido", "" ,"" ,"$"+String(venta.totalVenta), venta.totalVenta))
                    }
                }
               
                pedidosLog.append(PedidoModelo(idPedido, String(venta.idProducto),
                                               obtenerDescripcionProducto(id: venta.idProducto)                ,String(venta.cantidad), String(venta.precioProducto), String(venta.totalProducto), venta.totalVenta))
                
                idPedido=idPedido+1
            }
            
        }
        pedidosLog.append(PedidoModelo(tempId, "", "Total Pedido", "" ,"" ,"$"+String(ventasLog[tempId].totalVenta), ventasLog[tempId].totalVenta))
    }
    
    func obtenerDescripcionProducto(id:Int) -> String{
        for producto in productosLog{
            if producto.id == id {
                return producto.descripcion
            }
        }
        return ""
    }
    
    @IBAction func CerrarVc(_ sender: NSButton) {
        dismiss(self)
    }
    
}
