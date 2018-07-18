//
//  ProductCollectionViewCell.swift
//  AlephAssignment
//
//  Created by DuyN on 7/18/18.
//  Copyright © 2018 DuyN. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imvThumbnail: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(product: Product?) {
        if let product = product {
            lbTitle.text = product.title
            lbPrice.text = product.price
            imvThumbnail.kf.indicatorType = .activity
            imvThumbnail.kf.setImage(with: URL(string: product.imageUrl!))
        }
    }
}
