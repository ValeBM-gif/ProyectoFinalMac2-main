//
//  CrearVenta.swift
//  ProyectoFinal1
//
//  Created by Uriel Resendiz on 07/05/23.
//

import Cocoa

class CrearVenta: NSViewController {
    
    @IBOutlet var vcVentas: ViewController!
    @objc dynamic var ventasLog:[VentaModelo] = []
    var idUsuarioActual:Int!
    @IBOutlet weak var btnAgregarVenta: NSButton!
    @IBOutlet weak var txtIdProducto: NSTextField!
    @IBOutlet weak var txtCantidad: NSTextField!
    @IBOutlet weak var lblIncorrecto: NSTextField!
    @IBOutlet weak var lblSubtotalVenta: NSTextField!
    @IBOutlet weak var lblTotalVenta: NSTextField!
    
    //TODO: Funcionalidad de agregar venta a partir de un botón
    //TODO: NO SE PUEDE REPETIR ID DE VENTA
    //TODO: CONECTAR VENTAS A PEDIDOS PARA QUE EL CLIENTE TENGA ACCESO
    
    var idProducto: Int=0
    var cantidadProducto: Int=0
    var totalProducto: Double=0
    var totalVenta:Double=0
    var subtotalVenta:Double=0
    var precio1: Double=100
    var precio2: Double=200
    
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
                            if checarIdRepetido(id:txtIdProducto.integerValue){
                                ventasLog.append(VentaModelo(idVenta: 1, idVendedor: 1, idCliente: txtIdProducto.integerValue, idProducto: 1, cantidad: txtCantidad.integerValue, precioProducto: precio1, totalProducto: calcularTotalProducto(id: txtIdProducto.integerValue), subtotalVenta: 100, ivaVenta: 10, totalVenta: 100))
                            }else{
                                lblIncorrecto.stringValue = "*Inserta un ID diferente*"
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
    
    func calcularTotalProducto(id:Int)->Double{
        for venta in ventasLog{
            if(venta.idProducto == id){
                totalProducto = venta.precioProducto * txtCantidad.doubleValue
            }
        }
        return totalProducto
    }
    
    func calcularTotalVenta(id:Int){
      //Se compara el id de venta actual para encontrar todos los productos de la venta, se suman todos los totalesProductos y se obtiene totalVenta
    }
    
    func calcularSubtotalVenta(id:Int)->Double{
        for venta in ventasLog{
            if(venta.idVenta == id){
                
            }
        }
        return totalVenta
    }
    
    func checarIdRepetido(id:Int) -> Bool{
        for i in ventasLog{
            if (i.idProducto == id){
                return false
            }
        }
        return true
    }
        
    func validarCamposVacios() -> Bool{
        if(txtCantidad.stringValue == "" && txtIdProducto.stringValue == ""){
            return false
        }
        return true
    }
    
    func soloHayNumerosEnIdProducto() -> Bool{
        let numericCharacters = CharacterSet.decimalDigits.inverted
        return txtIdProducto.stringValue.rangeOfCharacter(from: numericCharacters) == nil
    }
    
    func soloHayNumerosEnCantidad() -> Bool{
        let numericCharacters = CharacterSet.decimalDigits.inverted
        return txtCantidad.stringValue.rangeOfCharacter(from: numericCharacters) == nil
    }
}
