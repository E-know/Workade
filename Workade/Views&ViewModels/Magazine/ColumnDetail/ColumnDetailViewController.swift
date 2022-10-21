//
//  ColumnDetailViewController.swift
//  Workade
//
//  Created by Hong jeongmin on 2022/10/18.
//

import UIKit

class ColumnDetailViewController: UIViewController {
    let sampleLabel: UILabel = {
        let label = UILabel()
        label.text = "칼럼 뷰 입니다."
        label.textColor = .black
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(sampleLabel)
        let sampleLabelLayout = [
            sampleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sampleLabel.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        NSLayoutConstraint.activate(sampleLabelLayout)
    }
}
