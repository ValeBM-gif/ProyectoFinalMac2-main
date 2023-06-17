//
//  PedidosCliente.swift
//  ProyectoFinal1
//
//  Created by Diego Juárez on 07/05/23.
//

import Cocoa

class PedidosCliente: NSViewController {
    
    //TODO: Todeeeeeee
    
    @IBOutlet weak var imgAvatar: NSImageView!
    
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
        
        let usuarioActual = vcTablaPedidos.usuarioLog
        idUsuarioActual = vcTablaPedidos.idUsuarioActual
        
        colorFondo(color: usuarioActual[idUsuarioActual].colorFondo)
        if usuarioActual[idUsuarioActual].imgFondo != "Sin avatar"{
            imgAvatar.isHidden = false
            imgAvatar.image = NSImage(named: usuarioActual[idUsuarioActual].imgFondo)
        }else{
            imgAvatar.isHidden = true
        }
        
        buscarClientes()
        
        obtenerIdClienteActual()
        
        buscarPedidosDeCliente()
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
        if (ventasLog.count>0){
           
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
                            pedidosLog.append(PedidoModelo(tempId-1, "", "Total Pedido", "" ,"" ,"$"+String(venta.totalVenta), venta.totalVenta))
                        }
                    }
                    
                    pedidosLog.append(PedidoModelo(tempId, String(venta.idProducto),
                                                   obtenerDescripcionProducto(id: venta.idProducto)                ,String(venta.cantidad), String(venta.precioProducto), String(venta.totalProducto), venta.totalVenta))
                    
                    
                }
                
            }
            print(ventasLog.count, "COUNT")
            if(ventasLog.count != 1){
                pedidosLog.append(PedidoModelo(tempId, "", "Total Pedido", "" ,"" ,"$"+String(ventasLog[tempId].totalVenta), ventasLog[tempId].totalVenta))}
            else{
                print(ventasLog.count, "COUNT1")
                pedidosLog.append(PedidoModelo(tempId, "", "Total Pedido", "" ,"" ,"$"+String(ventasLog[tempId-1].totalVenta), ventasLog[tempId-1].totalVenta))
        }
        }
            
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
