//
//  ViewController.swift
//  OBSPattern
//
//  Created by MattHew Phraxayavong on 4/7/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//

import UIKit
import MediaPlayer

class CartViewController: UITableViewController, CartSubscriber {
    var isPlaying = false
//    var timer:Timer!
//    var audioPlayer = AVAudioPlayer()

    var cartManager = CartManager()
    open override var description: String { return "CartViewController" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cartManager.add(subscriber: self)
        setupTableView()
        setupNavBar()
//        let pc = PlayCommand()
//        pc.execute()
    }
    
    func accept(changed cart: [Product]) {
        print("CartViewController: Updated an appearance of your cart")
        tableView.reloadData()
    }
    
    
    // MARK: - TODO: create method to set up the tableView UI
    func setupTableView() {
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.description())
        tableView.rowHeight = 100
    }
    
    // MARK: - TODO: create method to set up the nav bar UI
    var playButton = UIBarButtonItem()
    
    func setupNavBar() {
        title = "My Cart"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
//        let playButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(playButtons))
        playButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(playOrPause))
        let pauseButton = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(playButtons))
        navigationItem.rightBarButtonItems = [addButton, playButton, pauseButton]

    }
    
    @objc func playOrPause() {
        if isPlaying {
//            let pC = PlayCommand()
//            pC.execute()
            isPlaying = false
            
        } else {
//            let pC = PlayCommand()
//            pC.execute()
            isPlaying = true
            playButton = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(playButtons))
        }
    }

//    @objc func pauseButtons() {
//        let pC = PauseCommand()
//        pC.execute()
//    }
    
    @objc func playButtons() {
//        let pC = PlayCommand()
//        pC.execute()
    }
    
    @objc func addNewItem() {
        let alert = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let save = UIAlertAction(title: "Save", style: .default) { _ in
            let id = UUID().uuidString
            let title = alert.textFields![0].text ?? ""
            let newProduct = Food(id: id, title: title)
            self.cartManager.add(product: newProduct)
        }
        
        alert.addTextField { (textField) in
            textField.textColor = .black
            textField.placeholder = "Name of Item"
        }
        
        alert.addAction(cancel)
        alert.addAction(save)
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - TODO: call tableViewDataSource methods
extension CartViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartManager.cart.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.description(), for: indexPath) as! CartCell
        cell.textLabel?.text = cartManager.cart[indexPath.row].title
        cell.imageView?.image = UIImage(named: "googleImage")
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }
}

//MARK: TODO: call tableViewDelegate methods
extension CartViewController {
    // MARK: - TODO: call delete cell for row at method
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = cartManager.cart[indexPath.row]
            cartManager.remove(product: item)
        }
    }
}

