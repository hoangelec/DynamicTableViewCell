//
//  ViewController.swift
//  DynamicTableViewCell
//
//  Created by Hoang Cap on 02/09/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            let viewModel = DefaultMultipleCellTypeViewModel()
            let vc = MultipleCellTypeViewController(viewModel: viewModel)
            vc.modalPresentationStyle = .pageSheet
            self.present(vc, animated: true)
        }
    }
    
    
    

}

