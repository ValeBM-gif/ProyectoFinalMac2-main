//
//  ConsultarUsuario.swift
//  ProyectoFinal1
//
//  Created by ISSC_412_2023 on 02/05/23.
//

import Cocoa

class ConsultarUsuario: NSViewController {
    
    
    @IBOutlet var vcTabla: ViewController!
    @objc dynamic var usuarioLog:[UsuarioModelo] = []

    @IBOutlet weak var tablaUsuarios: NSTableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        usuarioLog.remove(at: 0)
        tablaUsuarios.reloadData()
        
    }
    
    @IBAction func cerrarViewController(_ sender: NSButton) {
        dismiss(self)
    }
    
    
}
