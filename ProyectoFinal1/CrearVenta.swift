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
    
    @objc dynamic var ventasLog:[VentaModelo] = []
    
    //TODO: CONECTAR VENTAS A PEDIDOS PARA QUE EL CLIENTE TENGA ACCESO
    
    //TODO: Agregar a tablitas nombre (nombre producto, nombre vendedor, etc) EN TODOS LOS COSIS, NO SOLO VENTAS
    //TODO: Validar que no se pueda buscar un producto que no existe (id 0, nums negativos o mayor a la cantidad de productos existentes)
    //TODO: appendear realmente total y subtotal de venta (solo aparecen bien el lbl externo a tabla)
    //TODO: Agregar botón para completar venta
    //TODO: Restar cantidad de productos en stock al venderlos
    //TODO: Checar qpd con que busque un producto 0, ya que ahora los productos empiezan en 1
    
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
                if txtIdProducto.stringValue != ""{
                    if soloHayNumerosEnCantidad(){
                        cantidadProducto = txtCantidad.integerValue
                        lblIncorrecto.isHidden = true
                        if soloHayNumerosEnIdProducto(){
                            idProducto = txtIdProducto.integerValue
                            lblIncorrecto.isHidden = true
                            if validarExistenciaProducto(id: idProducto){
                                if checarIdRepetido(id:idProducto){
                                    if checarCantidadValida(id: idProducto){
                                        
                                        calcularTotalVenta()

                                        ventasLog.append(VentaModelo(idVenta: vc.contadorIdVenta, idVendedor: vc.idUsuarioActual, nombreVendedor: vcMenuVenta.nombreVendedor, idCliente: vcMenuVenta.idClienteABuscar, nombreCliente:vcMenuVenta.nombreClienteABuscar, idProducto: vc.productoLog[txtIdProducto.integerValue].id, nombreProducto: vc.productoLog[txtIdProducto.integerValue].nombre, cantidad: txtCantidad.integerValue, precioProducto: vc.productoLog[txtIdProducto.integerValue].precio, totalProducto: calcularTotalProducto(id: idProducto), subtotalVenta: 100, ivaVenta: 16, totalVenta: 100))

                                        lblNombreVendedor.stringValue = vcMenuVenta.nombreVendedor
                                        
                                        calcularSubtotalVenta(id: vc.contadorIdVenta)
                                        calcularTotalVenta()
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
                        }
                    }
                }else{
                    lblIncorrecto.stringValue = "*Inserta un ID*"
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
    
    func calcularSubtotalVenta(id:Int){
        for venta in ventasLog{
            if(venta.idVenta == id){
                print("entro de nuevo")
                multi = Double(txtCantidad.stringValue)! * vc.productoLog[txtIdProducto.integerValue].precio
            }
        }
        subtotal = subtotal + multi
        multi=0
        lblSubtotalVenta.stringValue = ("$" + String(subtotal))
    }
    
    func calcularTotalVenta(){
        total = subtotal + (subtotal * 0.16)
        lblTotalVenta.stringValue = "$\(total)"
    }
    
    override func viewDidDisappear() {
        vc.contadorIdVenta = vc.contadorIdVenta + 1
        print(vc.contadorIdVenta)
    }
}
