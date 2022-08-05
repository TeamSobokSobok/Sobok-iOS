//
//  BaseViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/07.
//

import UIKit

class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        target()
        hierarchy()
        layout()
    }
    
    func target() { }
    func style() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
    }
    func hierarchy() {}
    func layout() {}
    
}
