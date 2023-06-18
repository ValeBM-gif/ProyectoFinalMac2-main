//
//  ConsultarUsuario.swift
//  ProyectoFinal1
//
//  Created by ISSC_412_2023 on 02/05/23.
//

import Cocoa

class ConsultarUsuario: NSViewController {
    
    @IBOutlet weak var imgAvatar: NSImageView!
    
    @IBOutlet var vcTabla: ViewController!
    @objc dynamic var usuarioLogTemp:[UsuarioModelo] = []
    @objc dynamic var usuarioLog:[UsuarioModelo] = []

    @IBOutlet weak var tablaUsuarios: NSTableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        usuarioLogTemp.remove(at: 0)
        usuarioLog = usuarioLogTemp
        for usuario in usuarioLog{
            if (usuario.nombre == "-1" && usuario.email == "-1"){
                usuarioLog.remove(at: usuarioLog.firstIndex(of: usuario)!)
            }
        }
        tablaUsuarios.reloadData()
        
        let usuarioActual = vcTabla.usuarioLog
        var idUsuarioActual:Int = vcTabla.idUsuarioActual
        
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
    
    @IBAction func cerrarViewController(_ sender: NSButton) {
        dismiss(self)
    }
    
    
}
