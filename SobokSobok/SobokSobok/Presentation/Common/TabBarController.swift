//
//  TabBarController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/10.
//

import UIKit

import EasyKit

final class TabBarController: UITabBarController {
    // MARK: - Properties
    
    private var tabs: [UIViewController] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarAppearance()
        setTabBarItems()
        setDelegation()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.frame.size.height = 90
        tabBar.frame.origin.y = view.frame.height - 90
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let imageView = tabBar.subviews[item.tag + 1].subviews.compactMap({ $0 as? UIImageView }).first else { return }
        tabBarItemBounceAnimation(imageView: imageView)
    }
}

// MARK: - Functions

extension TabBarController {
    private func setTabBarAppearance() {
        UITabBar.clearShadow()
        UITabBar.appearance().tintColor = Color.black
        UITabBar.appearance().unselectedItemTintColor = Color.gray500

        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 11.0)!]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        
        tabBar.layer.borderWidth = 1.0
        tabBar.layer.borderColor = Color.gray200.cgColor
    }

    private func setTabBarItems() {
        tabs = [
            UINavigationController(rootViewController: MainViewController()),
            UINavigationController(rootViewController: ShareViewController()),
            UINavigationController(rootViewController: NoticeViewController.instanceFromNib()),
            UINavigationController(rootViewController: UIViewController())
        ]

        TabBarItem.allCases.forEach {
            tabs[$0.rawValue].tabBarItem = $0.asTabBarItem()
            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
        }
        
        setViewControllers(tabs, animated: true)
    }
    
    private func setDelegation() {
        self.delegate = self
    }
    
    private func tabBarItemBounceAnimation(imageView: UIImageView) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut) {
            
            imageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseInOut) {
                
                imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}

// MARK: - TabBarController Delegate

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let tabBarItemIndex = viewController.tabBarItem.tag
        
        if tabBarItemIndex == 3 {
            let addMedicineSheet = AddMedicineSheet.instanceFromNib()
            addMedicineSheet.modalPresentationStyle = .overCurrentContext
            addMedicineSheet.modalTransitionStyle = .crossDissolve
            self.present(addMedicineSheet, animated: false
            ) {
                DispatchQueue.main.async {
                    addMedicineSheet.sheetWithAnimation()
                }
            }
            return false
        }
        return true
    }
}
