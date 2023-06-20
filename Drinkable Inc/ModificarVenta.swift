//
//  ModificarVenta.swift
//  Drinkable Inc
//
//  Created by Valeria Baeza on 17/06/23.
//

import Cocoa

class ModificarVenta: NSViewController {
    
    @IBOutlet weak var imgAvatar: NSImageView!
    @IBOutlet var vcVentas: CrearVenta!
    
    @IBOutlet weak var txtCantidadModificar: NSTextField!
    
    @IBOutlet weak var lblIncorrecto: NSTextField!
        
    var cantidadNueva: Int=0
    var cantidadAnterior: Int=0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        lblIncorrecto.isHidden = true
        vcVentas.vc.cambiarImagenYFondo(idUsuarioActual: vcVentas.vc.idUsuarioActual, imgAvatar: imgAvatar, view: self.view)
    }
        
    @IBAction func modificarVenta(_ sender: NSButton) {
        if hacerValidaciones(){
            cantidadNueva = txtCantidadModificar.integerValue
            if vcVentas.selectedRow >= 0 {
                vcVentas.ventasLog[vcVentas.selectedRow].cantidad = cantidadNueva
                vcVentas.ventasLogFinal[vcVentas.selectedRow+vcVentas.totalVentas].cantidad = cantidadNueva
                vcVentas.ventasTemp[vcVentas.selectedRow+vcVentas.totalVentas].cantidad = cantidadNueva

                vcVentas.ventasLog[vcVentas.selectedRow].totalProducto = vcVentas.ventasLog[vcVentas.selectedRow].precioProducto * Double(cantidadNueva)
                
                vcVentas.ventasLogFinal[vcVentas.selectedRow+vcVentas.totalVentas].totalProducto = vcVentas.ventasLog[vcVentas.selectedRow+vcVentas.totalVentas].precioProducto * Double(cantidadNueva)
                
                vcVentas.ventasTemp[vcVentas.selectedRow+vcVentas.totalVentas].totalProducto = vcVentas.ventasLog[vcVentas.selectedRow+vcVentas.totalVentas].precioProducto * Double(cantidadNueva)
                
                vcVentas.vc.productoLog[vcVentas.ventasLog[vcVentas.selectedRow+vcVentas.totalVentas].idProducto].cantidad -= txtCantidadModificar.integerValue
                vcVentas.vc.productoLog[vcVentas.ventasLog[vcVentas.selectedRow+vcVentas.totalVentas].idProducto].cantidad += cantidadAnterior
                
                let nuevoSubtotal = vcVentas.calcularSubtotalVenta(id: vcVentas.vc.contadorIdVenta)
                let nuevoTotal = vcVentas.calcularTotalVenta()
                
                for venta in vcVentas.ventasLog{
                    
                    venta.subtotalVenta=nuevoSubtotal
                    venta.totalVenta=nuevoTotal
                    
                    vcVentas.ventasLogFinal[vcVentas.totalVentas+vcVentas.ventasLog.firstIndex(of: venta)!].subtotalVenta=nuevoSubtotal
                    
                    vcVentas.ventasLogFinal[vcVentas.totalVentas+vcVentas.ventasLog.firstIndex(of: venta)!].totalVenta=nuevoTotal
                    
                    vcVentas.vc.ventasLog = vcVentas.ventasLogFinal
                }
                
                vcVentas.tablaVentas.reloadData()
                vcVentas.vc.ventasLog = vcVentas.ventasLogFinal
                
            }
            dismiss(self)
        }
        
    }
    
    func calcularTotalProducto(id:Int)->Double{
        for producto in vcVentas.vc.productoLog{
            if(producto.id == id){
                vcVentas.totalProducto = producto.precio * Double(cantidadNueva)
            }
        }
        return vcVentas.totalProducto
    }
    
    func hacerValidaciones()->Bool{
        if validarCamposVacios(){
            if soloHayNumerosEnCantidad(){
                if validarCantidadMayorCero(){
                    if validarCantidadExistente(){
                        lblIncorrecto.isHidden = true
                        return true
                    }else{
                        lblIncorrecto.isHidden = false
                        lblIncorrecto.stringValue = "*Introduce una cantidad en disponibilidad*"
                        return false
                    }
                }else{
                    lblIncorrecto.isHidden = false
                    lblIncorrecto.stringValue = "*Introduce una cantidad mayor a 0*"
                    return false
                }
            }else{
                lblIncorrecto.isHidden = false
                lblIncorrecto.stringValue = "*Introduce una cantidad válida*"
                return false
            }
        }else{
            lblIncorrecto.isHidden = false
            lblIncorrecto.stringValue = "*Introduce una cantidad*"
            return false
        }
    }
    
    func validarCamposVacios() -> Bool{
        if(txtCantidadModificar.stringValue == ""){
            return false
        }else{
            return true
        }
    }
    
    func soloHayNumerosEnCantidad() -> Bool{
        let numericCharacters = CharacterSet.decimalDigits.inverted
        return txtCantidadModificar.stringValue.rangeOfCharacter(from: numericCharacters) == nil
    }
    
    func validarCantidadMayorCero() -> Bool {
        var cantEsMayorCero = false
        
        if((Int(txtCantidadModificar.stringValue)!) > 0){
            cantEsMayorCero = true
        }
        else{
            cantEsMayorCero = false
            lblIncorrecto.stringValue = "Inserta una cantidad válida"
        }
        return cantEsMayorCero
    }
    
    func validarCantidadExistente()->Bool{
        if vcVentas.vc.productoLog[vcVentas.ventasLog[vcVentas.selectedRow+vcVentas.totalVentas].idProducto].cantidad+1 < txtCantidadModificar.integerValue{
            return false
        }else{
            return true
        }
    }
}
