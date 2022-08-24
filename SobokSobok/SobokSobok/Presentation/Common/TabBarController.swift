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
    
    let tabbarManager: ScheduleServiceable = ScheduleManager(apiService: APIManager(), environment: .development)
    
    private var tabs: [UIViewController] = []
    var members: [Member] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarAppearance()
        setTabBarItems()
        setDelegation()
        
        getGroupInformation()
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
        UITabBar.appearance().unselectedItemTintColor = Color.gray800
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 11.0)!]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        
        tabBar.layer.borderWidth = 1.0
        tabBar.layer.borderColor = Color.gray200.cgColor
    }
    
    private func setTabBarItems() {
        tabs = [
            UINavigationController(rootViewController: MainViewController()),
            UINavigationController(rootViewController: ShareViewController()),
            UINavigationController(rootViewController: NoticeViewController()),
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
            let addMedicineSheet = AddPillSheet(with: AddPillSheetViewModel())
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

extension TabBarController {
    func getGroupInformation() {
        Task {
            do {
                let members = try await tabbarManager.getGroupInformation()
                if let members = members,
                   !members.isEmpty {
                    self.members = members
                    UserDefaults.standard.member = members
                }
            }
        }
    }
}
