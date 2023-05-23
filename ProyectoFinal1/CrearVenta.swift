//
//  CrearVenta.swift
//  ProyectoFinal1
//
//  Created by Uriel Resendiz on 07/05/23.
//

import Cocoa

class CrearVenta: NSViewController {
    
    @IBOutlet var vc: ViewController!
    @IBOutlet var vcMenuVenta: MenuVentas!
    
    @IBOutlet weak var btnAgregarVenta: NSButton!
    @IBOutlet weak var txtIdProducto: NSTextField!
    @IBOutlet weak var txtCantidad: NSTextField!
    @IBOutlet weak var lblIncorrecto: NSTextField!
    @IBOutlet weak var lblSubtotalVenta: NSTextField!
    @IBOutlet weak var lblTotalVenta: NSTextField!
    @IBOutlet weak var lblNombreVendedor: NSTextField!
    @IBOutlet weak var txtNombreCliente: NSTextField!
    
    @objc dynamic var ventasLog:[VentaModelo] = []
    
    //TODO: CONECTAR VENTAS A PEDIDOS PARA QUE EL CLIENTE TENGA ACCESO
    
    var idProducto: Int=0
    var cantidadProducto: Int=0
    var totalProducto: Double=0
    var totalVenta:Double=0
    var subtotalVenta:Double=0
    var idUsuarioActual:Int!
    var subtotal : Double = 0
    var multi : Double = 0
    var total:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblIncorrecto.isHidden = true
        
    }
    
    @IBAction func agregarVenta(_ sender: NSButton) {
        if validarCamposVacios(){
            if txtCantidad.stringValue != ""{
                if txtIdProducto.stringValue != "" && validarIdProductoMayorCero(){
                    if soloHayNumerosEnCantidad() && validarCantidadMayorCero(){
                        cantidadProducto = txtCantidad.integerValue
                        lblIncorrecto.isHidden = true
                        if soloHayNumerosEnIdProducto(){
                            idProducto = txtIdProducto.integerValue
                            lblIncorrecto.isHidden = true
                            if validarExistenciaProducto(id: idProducto){
                                if checarIdRepetido(id:idProducto){
                                    if checarCantidadValida(id: idProducto){
                                        
                                        calcularTotalVenta()

                                        ventasLog.append(VentaModelo(idVenta: vc.contadorIdVenta, idVendedor: vc.idUsuarioActual, nombreVendedor: vcMenuVenta.nombreVendedor, idCliente: vcMenuVenta.idClienteABuscar, nombreCliente:vcMenuVenta.nombreClienteABuscar, idProducto: vc.productoLog[txtIdProducto.integerValue].id, nombreProducto: vc.productoLog[txtIdProducto.integerValue].nombre, cantidad: txtCantidad.integerValue, precioProducto: vc.productoLog[txtIdProducto.integerValue].precio, totalProducto: calcularTotalProducto(id: idProducto), subtotalVenta: calcularSubtotalVenta(id: vc.contadorIdVenta), ivaVenta: 16, totalVenta: calcularTotalVenta()))

                                        lblNombreVendedor.stringValue = vcMenuVenta.nombreVendedor
                                        
                                        calcularSubtotalVenta(id: vc.contadorIdVenta)
                                        calcularTotalVenta()
                                        restarInventario(id: Int(txtIdProducto.stringValue)!)
                                        txtNombreCliente.stringValue = vcMenuVenta.nombreClienteABuscar
                                    }else{
                                        lblIncorrecto.stringValue = "*Cantidad solicitada excedente a la cantidad en existencia*"
                                        lblIncorrecto.isHidden = false
                                    }
                                }else{
                                    lblIncorrecto.stringValue = "*Inserta un ID diferente*"
                                    lblIncorrecto.isHidden = false
                                }
                            }else{
                                lblIncorrecto.stringValue = "*Producto inexistente*"
                                lblIncorrecto.isHidden = false
                            }
                        }else{
                            lblIncorrecto.stringValue = "*Inserta un ID válido en producto*"
                            lblIncorrecto.isHidden = false
                        }
                    }else{
                        lblIncorrecto.stringValue = "*Inserta una cantidad valida"
                        lblIncorrecto.isHidden = false
                    }
                }else{
                    lblIncorrecto.stringValue = "*Inserta un ID Valido*"
                    lblIncorrecto.isHidden = false
                }
            }else{
                lblIncorrecto.stringValue = "*Inserta una cantidad*"
                lblIncorrecto.isHidden = false
            }
        }else{
            lblIncorrecto.stringValue = "*Inserta un ID y una cantidad*"
            lblIncorrecto.isHidden = false
        }
    }
    
    func validarCantidadMayorCero() -> Bool {
        var cantEsMayorCero = false
        if((Int(txtCantidad.stringValue)!) > 0){
            cantEsMayorCero = true
        }
        else{
            cantEsMayorCero = false
            lblIncorrecto.stringValue = "Inserta una cantidad valida"
        }
        return cantEsMayorCero
    }
    
    func restarInventario(id:Int){
        vc.productoLog[id].cantidad = vc.productoLog[id].cantidad - Int(txtCantidad.stringValue)!
        print("cantidad del producto ahora es: " , vc.productoLog[id].cantidad)
    }
    
    func validarIdProductoMayorCero() -> Bool {
        var idProductoMayorcero = false
        if((Int(txtIdProducto.stringValue)!) > 0){
            idProductoMayorcero = true
        }
        else{
            idProductoMayorcero = false
            lblIncorrecto.stringValue = "Inserta un id de producto valido"
        }
        return idProductoMayorcero
    }
    
    func validarCamposVacios() -> Bool{
        if(txtCantidad.stringValue == "" && txtIdProducto.stringValue == ""){
            return false
        }
        return true
    }
    
    func soloHayNumerosEnCantidad() -> Bool{
        let numericCharacters = CharacterSet.decimalDigits.inverted
        return txtCantidad.stringValue.rangeOfCharacter(from: numericCharacters) == nil
    }
    
    func soloHayNumerosEnIdProducto() -> Bool{
        let numericCharacters = CharacterSet.decimalDigits.inverted
        return txtIdProducto.stringValue.rangeOfCharacter(from: numericCharacters) == nil
    }
    
    func validarExistenciaProducto(id:Int)->Bool{
        for ProductoModelo in vc.productoLog {
            if (ProductoModelo.id == id) {
                return true
            }
        }
        return false
    }
    
    func checarIdRepetido(id:Int) -> Bool{
        for venta in ventasLog{
            if (venta.idProducto == id){
                return false
            }
        }
        return true
    }
    
    func checarCantidadValida(id:Int)->Bool{
        if txtCantidad.integerValue <= vc.productoLog[id].cantidad{
            return true
        }
        return false
    }
    
    func calcularTotalProducto(id:Int)->Double{
        for producto in vc.productoLog{
            if(producto.id == id){
                totalProducto = producto.precio * txtCantidad.doubleValue
                print(totalProducto, "vale tonte 2")
            }
        }
        return totalProducto
    }
    
    func calcularSubtotalVenta(id:Int)->Double{
        for venta in ventasLog{
            if(venta.idVenta == id){
                print("entro de nuevo")
                multi = Double(txtCantidad.stringValue)! * vc.productoLog[txtIdProducto.integerValue].precio
            }
        }
        subtotal = subtotal + multi
        multi=0
        lblSubtotalVenta.stringValue = ("$" + String(subtotal))
        return subtotal
    }
    
    func calcularTotalVenta()->Double{
        total = subtotal + (subtotal * 0.16)
        lblTotalVenta.stringValue = "$\(total)"
        return total
    }
    
    override func viewDidDisappear() {
        vc.contadorIdVenta = vc.contadorIdVenta + 1
        print(vc.contadorIdVenta)
    }
}
