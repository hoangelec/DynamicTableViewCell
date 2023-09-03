//
//  Model.swift
//  DynamicTableViewCell
//
//  Created by Hoang Cap on 03/09/2023.
//

import Foundation
import UIKit

struct AModel: DynamicTableViewCellModel {
    typealias MyCell = ACell
    var a: String
}

class ACell: UITableViewCell, DynamicTableViewCell {
    
    var label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label.numberOfLines = 0
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for model: AModel) {
        // configure for A cell type
        label.text = " alksjdl kjaskld ajslkdj askldj aklsdj as \n asfd sdf sdf ds\n asf sadf dsf\n  ssfdf dsf\n dsfgsd fsd\n"
    }
}

struct BModel: DynamicTableViewCellModel {
    typealias MyCell = BCell
    
    var B: String
    var x: Int
    
    func tableCell(in tableView: UITableView, at IndexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyCell.self)) as? MyCell else {
            return UITableViewCell()
        }
        cell.configure(for: self)
        return cell
    }
}

class BCell: UITableViewCell, DynamicTableViewCell {
    func configure(for model: BModel) {
        // empty cell
    }
}

final class DefaultMultipleCellTypeViewModel: DynamicCellTypeViewModel {
    var associatedCellTypes: [any DynamicTableViewCell.Type] = [ACell.self, BCell.self]
    
    
    var data: [any DynamicTableViewCellModel] = [AModel(a: "A1"), AModel(a: "A2"), BModel(B: "B1", x: 1), AModel(a: "A3"), BModel(B: "B2", x: 2)]
}
