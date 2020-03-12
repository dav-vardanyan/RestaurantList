//
//  MainViewController.swift
//  TestAppRestaurants
//
//  Created by David V on 3/12/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import UIKit
import Combine
import ViewModel

final class MainViewController: UIViewController,
                                UITableViewDelegate,
                                UITableViewDataSource,
                                UISearchBarDelegate {

    @IBOutlet private weak var restaurantFilter: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var orderByButton: UIButton!

    private let viewModel = RestaurantsViewModel() // need protocol
    private var cancellable = Set<AnyCancellable>()
    private let cellHeight: CGFloat = 106.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        viewModel.getItems()
    }

    @IBAction func orderButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: title,
                                                message: "Sort?",
                                                preferredStyle: .alert)

        SortingKey.allCases.forEach({
            let sortingKey = $0
            let action = UIAlertAction(title: sortingKey.description,
                                       style: .default,
                                       handler: { [weak self] _ in
                                        self?.viewModel.orderSortSelected(key: sortingKey)
            })
            alertController.addAction(action)
        })
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }

    //MARK: Table View
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(RestaurantCellTableViewCell.self, indexPath: indexPath)
        let model = viewModel.getRestaurantAt(index: indexPath.row)
        cell.setup(model: model)
        cell.favoritePressed = { [weak self] in
            self?.viewModel.favoriteButtonPressed(index: indexPath.row)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    //MARK: Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterRestaurants(restaurantName: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.restaurantFilter.endEditing(true)
    }

    private func setup() {
        self.restaurantFilter.delegate = self


        self.tableView.register(RestaurantCellTableViewCell.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.viewModel.$reloadData
        .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] newValue in
            if newValue {
                self?.tableView.reloadData()
            }
            }).store(in: &cancellable)

        self.viewModel.$sortingKey
        .receive(on: DispatchQueue.main)
        .sink(receiveValue: { [weak self] newValue in
            self?.orderByButton.setTitle("Sort : \(newValue.description)", for: .normal)
        }).store(in: &cancellable)
    }
}

