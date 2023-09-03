//
//  MultipleCellTypeTableExample.swift
//  CircularCollectionView
//
//  Created by Hoang Cap on 21/08/2023.
//

import UIKit
import Foundation
import SnapKit

protocol DynamicTableViewCell: UITableViewCell {
    associatedtype MyModel: DynamicTableViewCellModel // Defines the model that this cell is associated with
    func configure(for model: MyModel)
}

protocol MyViewModel {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> any DynamicTableViewCell
}

protocol DynamicTableViewCellModel {
    associatedtype MyCell: DynamicTableViewCell // The cell type that this cell model is associated with
    func tableCell(in tableView: UITableView, at IndexPath: IndexPath) -> UITableViewCell
}

extension DynamicTableViewCellModel {
    func tableCell(in tableView: UITableView, at IndexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyCell.self)) as? MyCell else {
            return UITableViewCell()
        }
        
        cell.configure(for: self as! Self.MyCell.MyModel)
        return cell
    }
}

protocol DynamicCellTypeViewModel {
    var associatedCellTypes: [any DynamicTableViewCell.Type] { get }
    var data: [any DynamicTableViewCellModel] { get }
}

extension DynamicCellTypeViewModel {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        data[indexPath.row].tableCell(in: tableView, at: indexPath)
    }
}

open class MultipleCellTypeViewController:UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    let viewModel: DynamicCellTypeViewModel
    
    init(viewModel: DynamicCellTypeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        viewModel.associatedCellTypes.forEach(tableView.register(cellType:))
    }
}

fileprivate extension UITableView {
    func register(cellType: UITableViewCell.Type) {
        self.register(cellType.self, forCellReuseIdentifier: String(String(describing: cellType.self)))
    }
}

extension MultipleCellTypeViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.tableView(tableView, cellForRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
