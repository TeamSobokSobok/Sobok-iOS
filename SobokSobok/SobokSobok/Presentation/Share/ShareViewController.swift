//
//  ShareViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/12.
//

import UIKit

final class ShareViewController: UIViewController {

    @IBOutlet weak var pagerTab: PagerTab!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewControllers: [PageComponentProtocol] = [
            MainViewController.instanceFromNib(),
            MainViewController.instanceFromNib(),
            MainViewController.instanceFromNib(),
            MainViewController.instanceFromNib(),
            MainViewController.instanceFromNib()
        ]
        let style = PagerTab.Style.default
        pagerTab.setup(self, viewControllers: viewControllers, style: style)
    }
}
