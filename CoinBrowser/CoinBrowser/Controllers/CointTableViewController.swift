//
//  CointTableViewController.swift
//  CoinBrowser
//
//  Created by Jake Gloschat on 2/20/23.
//

import UIKit

class CointTableViewController: UITableViewController {
    // MARK: - Outlets

    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoinList()
        
    }
    
    // MARK: - Properties
    var coins: [Coin] = []
    
    // MARK: - Functions
    func fetchCoinList() {
        CoinController.fetchCoins { coins in
            guard let coins = coins else { return }
            self.coins = coins
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath)
        
        let coin = coins[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = coin.name
        config.secondaryText = coin.id
        cell.contentConfiguration = config
     
        return cell
    }
}
