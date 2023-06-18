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
        
        vcTabla.cambiarImagenYFondo(idUsuarioActual: vcTabla.idUsuarioActual, imgAvatar: imgAvatar, view: self.view)

    }

    
    @IBAction func cerrarViewController(_ sender: NSButton) {
        dismiss(self)
    }
    
    
}
