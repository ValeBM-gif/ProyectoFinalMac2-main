//
//  ModificarProducto.swift
//  ProyectoFinal1
//
//  Created by Valeria Baeza on 07/05/23.
//

import Cocoa

class ModificarProducto: NSViewController {

    
    @IBOutlet weak var vc: ViewController!
    @IBOutlet weak var vcMenu: MenuCompras!
    
    @IBOutlet weak var txtNombre: NSTextField!
    @IBOutlet weak var txtDescripcion: NSTextField!
    @IBOutlet weak var txtUnidad: NSTextField!
    @IBOutlet weak var txtPrecio: NSTextField!
    @IBOutlet weak var txtCosto: NSTextField!
    @IBOutlet weak var txtCategoria: NSTextField!
    @IBOutlet weak var txtCantidad: NSTextField!
    
    @IBOutlet weak var lblIncorrecto: NSTextField!
    
    var idUsuarioRecibido:Int = 0
    var idProductoAModificar:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblIncorrecto.isHidden = true
        
        idUsuarioRecibido = vc.idUsuarioActual
        
        txtNombre.stringValue = vcMenu.productoLog[idProductoAModificar].nombre
        txtDescripcion.stringValue = vcMenu.productoLog[idProductoAModificar].descricpion
        txtUnidad.stringValue = vcMenu.productoLog[idProductoAModificar].unidad
        txtPrecio.stringValue = String( vcMenu.productoLog[idProductoAModificar].precio)
        txtCosto.stringValue = String( vcMenu.productoLog[idProductoAModificar].costo)
        txtCategoria.stringValue =  vcMenu.productoLog[idProductoAModificar].categoria
        txtCantidad.stringValue = String( vcMenu.productoLog[idProductoAModificar].cantidad)
    }
    
    
    @IBAction func actualizarProducto(_ sender: NSButton) {
        
        if validarCamposVacios(){
            if validarNumeroDoublePositivo(txtPrecio.stringValue){
                if validarNumeroDoublePositivo(txtCosto.stringValue){
                    if validarNumeroEnteroPositivo(){
                        lblIncorrecto.isHidden = true
                        
                        vcMenu.productoLog[idProductoAModificar].nombre = txtNombre.stringValue
                        vcMenu.productoLog[idProductoAModificar].descricpion = txtDescripcion.stringValue
                        vcMenu.productoLog[idProductoAModificar].unidad = txtUnidad.stringValue
                        vcMenu.productoLog[idProductoAModificar].precio = txtNombre.doubleValue
                        vcMenu.productoLog[idProductoAModificar].costo = txtNombre.doubleValue
                        vcMenu.productoLog[idProductoAModificar].categoria = txtNombre.stringValue
                        vcMenu.productoLog[idProductoAModificar].cantidad = txtNombre.integerValue
                        
                        dismiss(self)
                        
                    }else{
                        lblIncorrecto.stringValue = "*En cantidad inserta un número válido*"
                        lblIncorrecto.isHidden = false
                    }
                }else{
                    lblIncorrecto.stringValue = "*En costo inserta un número válido*"
                    lblIncorrecto.isHidden = false
                }
            }else{
                lblIncorrecto.stringValue = "*En precio inserta un número válido*"
                lblIncorrecto.isHidden = false
            }
        }else{
            lblIncorrecto.stringValue = "*Recuerda llenar todos los campos*"
            lblIncorrecto.isHidden = false
        }
    }
    
    func validarCamposVacios()->Bool{
        if txtNombre.stringValue == "" ||
            txtDescripcion.stringValue == "" ||
            txtUnidad.stringValue == "" ||
            txtPrecio.stringValue == "" ||
            txtCosto.stringValue == "" ||
            txtCategoria.stringValue == "" ||
            txtCantidad.stringValue == "" {
            return false
        }
        return true
    }
    
    func validarNumeroDoublePositivo(_ str: String) -> Bool {
        let numericCharacters = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "."))
        let stringCharacterSet = CharacterSet(charactersIn: str)
        return numericCharacters.isSuperset(of: stringCharacterSet) && Double(str) != nil && Double(str)! >= 0
    }
    
    func validarNumeroEnteroPositivo() -> Bool {
        let numericCharacters = CharacterSet.decimalDigits
        let stringCharacterSet = CharacterSet(charactersIn: txtCantidad.stringValue)
        return numericCharacters.isSuperset(of: stringCharacterSet) && Int(txtCantidad.stringValue) != nil && Int(txtCantidad.stringValue)! >= 0
    }
}
