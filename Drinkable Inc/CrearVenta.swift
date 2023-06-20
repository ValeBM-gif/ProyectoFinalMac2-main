//
//  CrearVenta.swift
//  Drinkable Inc
//
//  Created by Uriel Resendiz on 07/05/23.
//

import Cocoa

class CrearVenta: NSViewController {
    
    @IBOutlet weak var imgAvatar: NSImageView!
    
    @IBOutlet var vc: ViewController!
    @IBOutlet var vcMenuVenta: MenuVentas!
    
    @IBOutlet weak var btnEliminarVenta: NSButton!
    @IBOutlet weak var btnAgregarVenta: NSButton!
    @IBOutlet weak var txtIdProducto: NSTextField!
    @IBOutlet weak var txtCantidad: NSTextField!
    @IBOutlet weak var lblIncorrecto: NSTextField!
    @IBOutlet weak var lblSubtotalVenta: NSTextField!
    @IBOutlet weak var lblTotalVenta: NSTextField!
    @IBOutlet weak var lblNombreVendedor: NSTextField!
    @IBOutlet weak var lblNombreCliente: NSTextField!
    
    @IBOutlet weak var tablaVentas: NSTableView!
    @objc dynamic var ventasLogFinal:[VentaModelo] = []
    @objc dynamic var ventasTemp:[VentaModelo] = []
    @objc dynamic var ventasLog:[VentaModelo] = []
    
    var idProducto: Int=0
    var cantidadProducto: Int=0
    var totalProducto: Double=0
    var totalVenta:Double=0
    var subtotalVenta:Double=0
    var idUsuarioActual:Int!
    var subtotal : Double = 0
    var multi : Double = 0
    var total:Double = 0
    var totalVentas: Int = 0
    var selectedRow:Int = 0
    
    override func viewDidLoad() {
        
        ventasLog = vc.ventasLog
        ventasTemp = vc.ventasLog
        ventasLogFinal = vc.ventasLog
        
        super.viewDidLoad()
        
        totalVentas=ventasLog.count
      
        ventasLog.removeAll()
        
        tablaVentas.reloadData()
        lblIncorrecto.isHidden = true
        
        lblNombreCliente.stringValue = vcMenuVenta.nombreClienteABuscar
        lblNombreVendedor.stringValue = vc.usuarioLog[vc.idUsuarioActual].nombre
        
        vc.cambiarImagenYFondo(idUsuarioActual: vc.idUsuarioActual, imgAvatar: imgAvatar, view: self.view)
        
    }
    
    @IBAction func eliminarVenta(_ sender: NSButton) {
       
        selectedRow = tablaVentas.selectedRow
        
        if selectedRow >= 0 {
            
            ventasLog.remove(at: selectedRow)
            ventasLogFinal.remove(at: selectedRow+totalVentas)
            ventasTemp.remove(at: selectedRow+totalVentas)
            tablaVentas.reloadData()
            
            calcularSubtotalVenta(id: vc.contadorIdVenta)
            calcularTotalVenta()
            
            for venta in ventasLog{
                venta.subtotalVenta=subtotal
                venta.totalVenta=total
                ventasLogFinal[totalVentas+ventasLog.firstIndex(of: venta)!].subtotalVenta=subtotal
                ventasLogFinal[totalVentas+ventasLog.firstIndex(of: venta)!].totalVenta=total
            }

            vc.ventasLog = ventasLogFinal
            lblIncorrecto.isHidden=true;
            
        }else{
            
            if(ventasLog.count<1){
                lblIncorrecto.stringValue = "*Primero debes agregar una venta*"
            }
            else{
                lblIncorrecto.stringValue = "*Selecciona una venta de la tabla para eliminar*"
            }
            
            lblIncorrecto.isHidden = false
            return
        }

    }
    
    func hacerValidaciones() -> Bool{
        if validarCamposVacios(){
            if txtCantidad.stringValue != ""{
                if validarIdProductoMayorCero(){
                    if soloHayNumerosEnCantidad() && validarCantidadMayorCero(){
                        cantidadProducto = txtCantidad.integerValue
                        lblIncorrecto.isHidden = true
                        if soloHayNumerosEnIdProducto(){
                            idProducto = txtIdProducto.integerValue
                            lblIncorrecto.isHidden = true
                            if validarExistenciaProducto(id: idProducto){
                                if checarIdRepetido(id:idProducto){
                                    if checarCantidadValida(id: idProducto){
                                        return true
                                    }else{
                                        lblIncorrecto.stringValue = "*Cantidad solicitada excedente a la cantidad en existencia*"
                                        lblIncorrecto.isHidden = false
                                        return false
                                    }
                                }else{
                                    lblIncorrecto.stringValue = "*Inserta un ID diferente*"
                                    lblIncorrecto.isHidden = false
                                    return false
                                }
                            }else{
                                lblIncorrecto.stringValue = "*Producto inexistente*"
                                lblIncorrecto.isHidden = false
                                return false
                            }
                        }else{
                            lblIncorrecto.stringValue = "*Inserta un ID válido en producto*"
                            lblIncorrecto.isHidden = false
                            return false
                        }
                    }else{
                        lblIncorrecto.stringValue = "*Inserta una cantidad válida"
                        lblIncorrecto.isHidden = false
                        return false
                    }
                }else{
                    lblIncorrecto.stringValue = "*Inserta un ID válido*"
                    lblIncorrecto.isHidden = false
                    return false
                }
            }else{
                lblIncorrecto.stringValue = "*Inserta una cantidad*"
                lblIncorrecto.isHidden = false
                return false
            }
        }else{
            lblIncorrecto.stringValue = "*Inserta un ID y una cantidad*"
            lblIncorrecto.isHidden = false
            return false
        }
    }
    
    
    @IBAction func agregarVenta(_ sender: NSButton) {
        if hacerValidaciones(){
            
            ventasTemp.append(VentaModelo(idVenta: vc.contadorIdVenta, idVendedor: vc.idUsuarioActual, nombreVendedor: vcMenuVenta.nombreVendedor, idCliente: vcMenuVenta.idClienteABuscar, nombreCliente:vcMenuVenta.nombreClienteABuscar, idProducto: vc.productoLog[encontrarPosicionProductoPorId()].id, nombreProducto: vc.productoLog[encontrarPosicionProductoPorId()].nombre,descripcionProducto: vc.productoLog[encontrarPosicionProductoPorId()].descripcion  ,cantidad: txtCantidad.integerValue, precioProducto: vc.productoLog[encontrarPosicionProductoPorId()].precio, totalProducto: 0, subtotalVenta: 0, ivaVenta: 16, totalVenta: 0))
            
            ventasLog.append(VentaModelo(idVenta: vc.contadorIdVenta, idVendedor: vc.idUsuarioActual, nombreVendedor: vcMenuVenta.nombreVendedor, idCliente: vcMenuVenta.idClienteABuscar, nombreCliente:vcMenuVenta.nombreClienteABuscar, idProducto: vc.productoLog[encontrarPosicionProductoPorId()].id, nombreProducto: vc.productoLog[encontrarPosicionProductoPorId()].nombre,descripcionProducto: vc.productoLog[encontrarPosicionProductoPorId()].descripcion  ,cantidad: txtCantidad.integerValue, precioProducto: vc.productoLog[encontrarPosicionProductoPorId()].precio, totalProducto: calcularTotalProducto(id: idProducto), subtotalVenta: calcularSubtotalVenta(id: vc.contadorIdVenta), ivaVenta: 16, totalVenta: calcularTotalVenta()))
    

            ventasLogFinal.append(ventasLog[ventasLog.count-1])
           
            restarInventario(id: Int(txtIdProducto.stringValue)!)
            
            vc.ventasLog = ventasLogFinal
           
        }
    }
    
    
    @IBAction func modificarVenta(_ sender: NSButton) {
        
        selectedRow = tablaVentas.selectedRow
        
        if selectedRow >= 0 {
            lblIncorrecto.isHidden = true
            performSegue(withIdentifier: "irModificarVenta", sender: self)
        }else{
            lblIncorrecto.isHidden = false
            lblIncorrecto.stringValue = "*Selecciona un producto a modificar*"
        }
    }
    
    func encontrarPosicionProductoPorId() -> Int {
        guard let posicionProducto =  vc.productoLog.firstIndex(where: {$0.id == txtIdProducto.integerValue}) else {return 0}
        
        return posicionProducto
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
        vc.productoLog[encontrarPosicionProductoPorId()].cantidad = vc.productoLog[encontrarPosicionProductoPorId()].cantidad - Int(txtCantidad.stringValue)!
    }
    
    func validarIdProductoMayorCero() -> Bool {
        var idProductoMayorcero = false
        
        if((Int(txtIdProducto.stringValue) ?? -1) > 0){
            idProductoMayorcero = true
        }
        else{
            idProductoMayorcero = false
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
        if txtCantidad.integerValue <= vc.productoLog[encontrarPosicionProductoPorId()].cantidad{
            return true
        }
        return false
    }
    
    func calcularTotalProducto(id:Int)->Double{
        for producto in vc.productoLog{
            if(producto.id == id){
                totalProducto = producto.precio * txtCantidad.doubleValue
            }
        }
        return totalProducto
    }
    
    func calcularSubtotalVenta(id:Int)->Double{
        
        subtotal=0
        total=0
        
        for venta in ventasTemp{
           
            if(venta.idVenta == id){
                multi += Double(venta.cantidad) * ventasTemp[ventasTemp.firstIndex(of: venta)!].precioProducto
            }
        }
        
        subtotal = (total/1.16) + (multi/1.16)
        multi=0
        
        lblSubtotalVenta.stringValue = ("$" + String(round(subtotal*100)/100.0))
        
        return subtotal
    }
    
    func calcularTotalVenta()->Double{
        
        total = round((subtotal*1.16)*100)/100.0
        
        lblTotalVenta.stringValue = "$\(round(total*100)/100.0)"
     
        return total
    }

    override func viewDidDisappear() {
        if(ventasLog.count>0){
            vc.contadorIdVenta += 1
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        txtCantidad.stringValue = ""
        txtIdProducto.stringValue = ""
        if segue.identifier == "irModificarVenta" {
            
            let destinationVC = segue.destinationController as! ModificarVenta;
            
            destinationVC.vcVentas = self
        }
    }
}
