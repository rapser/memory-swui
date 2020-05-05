//
//  ViewController.swift
//  memory-swui
//
//  Created by miguel tomairo on 5/4/20.
//  Copyright © 2020 rapser. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let dataSource = MemoryDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
        title = "Memorize"
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MemoryViewController") as? MemoryViewController else {
            fatalError("Habilitar para instanciar memory view controller")
        }
        
        let item = dataSource.item(at: indexPath.row)
        vc.item = item
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

