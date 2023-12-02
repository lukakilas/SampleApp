//
//  DetailsScreen.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import UIKit

class DetailsScreen: UIViewController {
    
    var viewModel: DetailsViewModel!
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(DetailsImageTableViewCell.self, forCellReuseIdentifier: "DetailsImageTableViewCell")
        table.register(DetailsTableCellWithLabel.self, forCellReuseIdentifier: "DetailsTableCellWithLabel")
        return table
    }()
    
    private lazy var sectionHeader: UIView = {
        let header = UIView()
        return header
    }()
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("no coder available")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
// MARK: - UITableViewDataSource
extension DetailsScreen: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId = viewModel.reuseId(for: indexPath)
        let item = viewModel.item(at: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.update(with: item)
        return cell
    }
    
}
// MARK: - UITableViewDelegate
extension DetailsScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeader(in: section)
    }
}
