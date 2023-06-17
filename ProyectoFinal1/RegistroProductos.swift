//
//  RegistroProductos.swift
//  ProyectoFinal1
//
//  Created by Valeria Baeza on 07/05/23.
//

import Cocoa

class RegistroProductos: NSViewController {

    @IBOutlet weak var imgAvatar: NSImageView!
    
    @IBOutlet weak var vc: ViewController!
    
    @IBOutlet weak var lblTitulo: NSTextField!
    @IBOutlet weak var lblDescripcion: NSTextField!
    
    @IBOutlet weak var txtNombre: NSTextField!
    @IBOutlet weak var txtDescripcion: NSTextField!
    @IBOutlet weak var txtUnidad: NSTextField!
    @IBOutlet weak var txtPrecio: NSTextField!
    @IBOutlet weak var txtCosto: NSTextField!
    @IBOutlet weak var txtCategoria: NSTextField!
    @IBOutlet weak var txtCantidad: NSTextField!
    
    @IBOutlet weak var lblIncorrecto: NSTextField!
    
    @IBOutlet weak var btnEnviar: NSButton!
    
    var esRegistroProducto: Bool = true
    var registerPosition: Int = 0
    var modifyPosition: Int = 0
    //@objc dynamic var productoLog: [ProductoModelo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblIncorrecto.isHidden = true
        
        registerPosition = vc.productoLog.count
        print("count de producto log",vc.productoLog.count)
        
        if esRegistroProducto{
            lblTitulo.stringValue = "Registro de Productos"
            lblDescripcion.isHidden = false
            btnEnviar.title = "Registrar"
        }else{
            print("entraa a elseeeeeeeeeee")
            llenarCampos()
            lblTitulo.stringValue = "Modificación de Productos"
            lblDescripcion.isHidden = true
            btnEnviar.title = "Modificar"
        }
        
        let usuarioActual = vc.usuarioLog
        var idUsuarioActual:Int = vc.idUsuarioActual
        
        colorFondo(color: usuarioActual[idUsuarioActual].colorFondo)
        if usuarioActual[idUsuarioActual].imgFondo != "Sin avatar"{
            imgAvatar.isHidden = false
            imgAvatar.image = NSImage(named: usuarioActual[idUsuarioActual].imgFondo)
        }else{
            imgAvatar.isHidden = true
        }
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
    
    
    @IBAction func enviar(_ sender: NSButton) {
        
        if hacerValidaciones(){
            if esRegistroProducto{
                registrarProducto()
            }else{
                modificarProducto()
            }
        }
    }
    
    
    func hacerValidaciones()->Bool{
        
        if validarCamposVacios(){
            if validarNumeroDoublePositivo(txtPrecio.stringValue){
                if validarNumeroDoublePositivo(txtCosto.stringValue){
                    if validarNoCeros(){
                        if validarNumeroEnteroPositivo(txtCantidad.stringValue){
                            lblIncorrecto.isHidden = true
                            return true
                        }else{
                            lblIncorrecto.stringValue = "*En cantidad inserta un número válido*"
                            lblIncorrecto.isHidden = false
                        }
                    }else{
                        lblIncorrecto.stringValue = "*Inserta mas de 0 en costo o precio*"
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
        
        return false
    }
    
    func registrarProducto(){
        print("  position: ",registerPosition)
        vc.productoLog.append(ProductoModelo(registerPosition, txtNombre.stringValue, txtDescripcion.stringValue, txtUnidad.stringValue, txtPrecio.doubleValue, txtCosto.doubleValue, txtCategoria.stringValue, txtCantidad.integerValue, vc.idUsuarioActual, vc.nombreUsuarioActual))
        print("count de producto log, después de registrar",vc.productoLog.count)
        for producto in vc.productoLog{
            print("productos", producto.nombre)
        }
        dismiss(self)
    }
    
    func modificarProducto(){
        vc.productoLog[modifyPosition].nombre = txtNombre.stringValue
        vc.productoLog[modifyPosition].descripcion = txtDescripcion.stringValue
        vc.productoLog[modifyPosition].unidad = txtUnidad.stringValue
        vc.productoLog[modifyPosition].precio = txtPrecio.doubleValue
        vc.productoLog[modifyPosition].costo = txtCosto.doubleValue
        vc.productoLog[modifyPosition].categoria = txtCategoria.stringValue
        vc.productoLog[modifyPosition].cantidad = txtCantidad.integerValue

        dismiss(self)
    }
    
    func llenarCampos(){
        print("entra a llenar campos")
        txtNombre.stringValue = vc.productoLog[modifyPosition].nombre
        txtDescripcion.stringValue = vc.productoLog[modifyPosition].descripcion
        txtUnidad.stringValue = vc.productoLog[modifyPosition].unidad
        txtPrecio.stringValue = String( vc.productoLog[modifyPosition].precio)
        txtCosto.stringValue = String( vc.productoLog[modifyPosition].costo)
        txtCategoria.stringValue =  vc.productoLog[modifyPosition].categoria
        txtCantidad.stringValue = String( vc.productoLog[modifyPosition].cantidad)
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
    
    func validarNumeroDoublePositivo(_ campo: String) -> Bool {
        let numericCharacters = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "."))
        let stringCharacterSet = CharacterSet(charactersIn: campo)
        return numericCharacters.isSuperset(of: stringCharacterSet) && Double(campo) != nil && Double(campo)! >= 0
    }
    
    func validarNoCeros()->Bool{
        if txtCosto.integerValue == 0 || txtPrecio.integerValue == 0{
            return false
        }
        return true
    }
    
    func validarNumeroEnteroPositivo(_ campo: String) -> Bool {
        let numericCharacters = CharacterSet.decimalDigits
        let stringCharacterSet = CharacterSet(charactersIn: campo)
        return numericCharacters.isSuperset(of: stringCharacterSet) && Int(campo) != nil && Int(campo)! >= 0
    }
    
    @IBAction func cerrarVC(_ sender: NSButton) {
        dismiss(self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        (segue.destinationController as! ViewController).productoLog = vc.productoLog
    }

    
}
