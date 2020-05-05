//
//  MemoryDataSource.swift
//  memory-swui
//
//  Created by miguel tomairo on 5/4/20.
//  Copyright © 2020 rapser. All rights reserved.
//

import UIKit

class MemoryDataSource: NSObject, UITableViewDataSource {
    
    var items = [MemoryItem]()
    
    
    override init() {
        
        guard let url = Bundle.main.url(forResource: "Items", withExtension: "json") else {
            fatalError("No encuentro el JSON")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("habilitad la carga de JSON")
        }
        
        let decoder = JSONDecoder()
        
        guard let savedItems = try? decoder.decode([MemoryItem].self, from: data) else {
            fatalError("Fallo al decodificar JSON")
        }
        
        items = savedItems
    }

    // MARK: - UITableViewDatasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.text
        
        return cell
    }
    
    func item(at index: Int) -> MemoryItem {
        
        return items[index]
    }
}
