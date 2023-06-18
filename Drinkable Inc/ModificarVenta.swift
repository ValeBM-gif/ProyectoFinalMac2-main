//
//  ModificarVenta.swift
//  Drinkable Inc
//
//  Created by Valeria Baeza on 17/06/23.
//

import Cocoa

class ModificarVenta: NSViewController {

    //TODO: validar cantidad existente
    
    @IBOutlet var vcVentas: CrearVenta!
    
    @IBOutlet weak var txtCantidadModificar: NSTextField!
    
    @IBOutlet weak var lblIncorrecto: NSTextField!
        
    var cantidadNueva: Int=0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        lblIncorrecto.isHidden = true
        //NO TIENE NS IMAGEVIEW
        //vc.cambiarImagenYFondo(idUsuarioActual: vc.idUsuarioActual, imgAvatar: imgAvatar, view: self.view)
    }
        
    @IBAction func modificarVenta(_ sender: NSButton) {
        if hacerValidaciones(){
            cantidadNueva = txtCantidadModificar.integerValue
            if vcVentas.selectedRow >= 0 {
                vcVentas.ventasLog[vcVentas.selectedRow].cantidad = cantidadNueva
                //print("ventas log cantidad",)
                vcVentas.ventasLogFinal[vcVentas.selectedRow+vcVentas.totalVentas].cantidad = cantidadNueva
                vcVentas.ventasTemp[vcVentas.selectedRow+vcVentas.totalVentas].cantidad = cantidadNueva
                
                vcVentas.ventasLog[vcVentas.selectedRow].totalProducto = vcVentas.calcularTotalProducto(id: vcVentas.selectedRow)
                
                vcVentas.ventasLogFinal[vcVentas.selectedRow+vcVentas.totalVentas].totalProducto = vcVentas.calcularTotalProducto(id: vcVentas.selectedRow+vcVentas.totalVentas)
                
                vcVentas.ventasTemp[vcVentas.selectedRow+vcVentas.totalVentas].totalProducto = vcVentas.calcularTotalProducto(id: vcVentas.selectedRow+vcVentas.totalVentas)
                
                vcVentas.tablaVentas.reloadData()
                
                vcVentas.calcularSubtotalVenta(id: vcVentas.vc.contadorIdVenta)
                vcVentas.calcularTotalVenta()
                
                for venta in vcVentas.ventasLog{
                    venta.subtotalVenta=vcVentas.subtotal
                    venta.totalVenta=vcVentas.total
                    vcVentas.ventasLogFinal[vcVentas.totalVentas+vcVentas.ventasLog.firstIndex(of: venta)!].subtotalVenta=vcVentas.subtotal
                    vcVentas.ventasLogFinal[vcVentas.totalVentas+vcVentas.ventasLog.firstIndex(of: venta)!].totalVenta=vcVentas.total
                    
                    vcVentas.vc.ventasLog = vcVentas.ventasLogFinal
                }
                
                //vcVentas.lblTotalVenta.stringValue = String(vcVentas.totalVentas)
                //vcVentas.lblSubtotalVenta.stringValue = String(vcVentas.subtotalVenta)
                
            }
        }
        dismiss(self)
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
            lblIncorrecto.stringValue = "Inserta una cantidad valida"
        }
        return cantEsMayorCero
    }
    
    func validarCantidadExistente()->Bool{
        return true
    }
}
