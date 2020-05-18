//
//  CartManager.swift
//  OBSPattern
//
//  Created by MattHew Phraxayavong on 4/7/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//

import Foundation


protocol CartSubscriber: CustomStringConvertible {
    func accept(changed cart: [Product])
}


protocol Product {
    var id: String { get }
    var title: String { get }
    
    func isEqual(to product: Product) -> Bool
}

extension Product {
    func isEqual(to product: Product) -> Bool {
        return id == product.id
    }
}

struct Food: Product {
    var id: String
    var title: String
}

final class CartManager {
    lazy var cart = [Product]()
    private var subscribers = [CartSubscriber]()
    
    func add(subscriber: CartSubscriber){
        print("CartManager: adding a new subscriber \(subscriber.description)")
        subscribers.append(subscriber)
        
    }
    
    func add(product: Product){
        print("CartManager: adding new product \(product.title)")
        cart.insert(product, at: 0)
        updateSubscribers()
    }
    
    func remove(product: Product){
        guard let index = cart.firstIndex(where: { $0.isEqual(to: product) }) else { return }
        print("CartManager: this product (\(product.title)) is removed from your cart")
        cart.remove(at: index)
        updateSubscribers()
    }
    
    private func updateSubscribers() {
        subscribers.forEach({ $0.accept(changed: cart) })
    }
}
