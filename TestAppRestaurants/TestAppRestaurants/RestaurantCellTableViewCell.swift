//
//  RestaurantCellTableViewCell.swift
//  TestAppRestaurants
//
//  Created by David V on 3/11/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import UIKit
import ViewModel

class RestaurantCellTableViewCell: UITableViewCell {

    public var favoritePressed: (() -> ())? = nil

    @IBOutlet private weak var restaurantName: UILabel!
    @IBOutlet private weak var openState: UILabel!
    @IBOutlet private weak var currentSorting: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func setup( model: RestaurantPresenter?) {
        guard let model = model else { return }
        restaurantName.text = model.name
        openState.text = model.status.description
        if model.status == .open {
            openState.textColor = .systemGreen
        } else {
            openState.textColor = .gray
        }
        currentSorting.text = model.sortingValue
        let notFavImage = UIImage(systemName: "heart")
        let favImage = UIImage(systemName: "heart.fill")
        let currentImage = (model.isFavorite ?? false) ? favImage : notFavImage
        favoriteButton.setBackgroundImage(currentImage, for: .normal)
    }

    @IBAction func favoriteButtonPressed(_ sender: Any) {
        favoritePressed?()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
