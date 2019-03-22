//
//  NumberCollectionViewCell.swift
//  SwipeCollectionViewController
//
//  Created by Sean Espressoft on 21/03/2019.
//  Copyright © 2019 Sean. All rights reserved.
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell {
    
    var textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textLabel.textAlignment = .center
        self.contentView.addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentView.addSubview(textLabel)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(textLabelText: String){
        textLabel.text = textLabelText
    }
    
    override var isSelected: Bool{
        didSet{
            textLabel.textColor = isSelected ? .green : .black
        }
    }
    
    override var isHighlighted: Bool{
        didSet{
            textLabel.textColor = isSelected ? .green : .black
        }
    }
    
}
