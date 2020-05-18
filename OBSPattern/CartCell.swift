//
//  CartCell.swift
//  OBSPattern
//
//  Created by MattHew Phraxayavong on 4/7/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//

import Foundation
import UIKit


class CartCell: UITableViewCell {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "title"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        //MARK: TODO: call the created methods
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - TODO: Create method to add subviews
    
    func addSubviews(){
        contentView.addSubview(label)
    }
    
    //MARK: - TODO: Create method to setup subviews constraints
    func layout() {
        NSLayoutConstraint.activate([
        
        ])
    }
}
