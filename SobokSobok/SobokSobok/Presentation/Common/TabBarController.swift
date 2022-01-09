//
//  TabBarController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/10.
//

import UIKit

final class TabBarController: UITabBarController {
    // MARK: - Properties
    
    var tabs: [UIViewController] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        setTabBarAppearance()
        setTabBarItems()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.frame.size.height = 90
        tabBar.frame.origin.y = view.frame.height - 90
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == TabBarItem.medicine.rawValue {
            selectMedicineTab()
            guard let imageView = tabBar.subviews[item.tag + 1].subviews.compactMap({ $0 as? UIImageView }).first else { return }
            bounceAnimation(imageView: imageView)
        } else {
            unselectMedicineTab()
            guard let imageView = tabBar.subviews[item.tag + 1].subviews.compactMap({ $0 as? UIImageView }).first else { return }
            bounceAnimation(imageView: imageView)
        }
    }
    
    // MARK: - Functions
    
    private func setTabBarAppearance() {
        UITabBar.appearance().tintColor = Color.black
        UITabBar.appearance().unselectedItemTintColor = Color.gray500
        UITabBar.appearance().shadowImage = nil
        UITabBar.appearance().backgroundImage = nil
        UITabBar.appearance().backgroundColor = UIColor.white

        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 11.0)!]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        
        tabBar.layer.borderWidth = 1.0
        tabBar.layer.borderColor = Color.gray200?.cgColor
    }

    private func setTabBarItems() {
        tabs = [
            UINavigationController(rootViewController: SampleViewController.instanceFromNib()),
            UINavigationController(rootViewController: SampleViewController.instanceFromNib()),
            UINavigationController(rootViewController: SampleViewController.instanceFromNib()),
            UINavigationController(rootViewController: UIViewController())
        ]

        TabBarItem.allCases.forEach {
            tabs[$0.rawValue].tabBarItem = $0.asTabBarItem()
            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
        }
        
        setViewControllers(tabs, animated: true)
    }
    
    private func bounceAnimation(imageView: UIImageView) {
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
    
    private func selectMedicineTab() {
        tabs[3].tabBarItem.image = Image.icPlusActive
        let fontAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Color.mint!,
            NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 11.0)!
        ]
        tabs[3].tabBarItem.setTitleTextAttributes(fontAttributes, for: .normal)
    }
    
    private func unselectMedicineTab() {
        tabBar.tintColor = Color.black
        tabs[3].tabBarItem.image = Image.icPlusInactive
        let fontAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Color.gray500!,
            NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 11.0)!
        ]
        tabs[3].tabBarItem.setTitleTextAttributes(fontAttributes, for: .normal)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewController.tabBarItem.tag
        if index != 3 {
            // 바텀 시트 off.
            print("바텀 시트 off")
            return true
        }
        
        // 이 부분에서 바텀 시트 띄우는 코드 쓰면 됨.
        // 바텀 시트 on.
        print("바텀 시트 on")
        
        return false
    }
}
