//
//  CustomCell.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 22.08.2023.
//

import UIKit

class CustomCell: UITableViewCell {
    var labelData = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(labelData)
        
        // Configure labelData's constraints
        labelData.translatesAutoresizingMaskIntoConstraints = false
        labelData.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        labelData.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        labelData.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        labelData.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

