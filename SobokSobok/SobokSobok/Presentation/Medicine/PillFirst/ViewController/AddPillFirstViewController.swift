//
//  AddPillFirstViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/01.
//

import UIKit

import RxSwift
import RxCocoa

final class AddPillFirstViewController: BaseViewController {

    private var pillTimeList: [String] = ["오전 8:00", "오후 1:00", "오후 7:00"] {
        didSet {
            addPillFirstView.collectionView.reloadData()
        }
    }
    
    let addPillFirstView = AddPillFirstView()
    
    override func loadView() {
        self.view = addPillFirstView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegate()
    }
    
    override func style() {
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = true
    }
    
    private func assignDelegate() {
        addPillFirstView.collectionView.delegate = self
        addPillFirstView.collectionView.dataSource = self
    }

    @objc func peopleSelectButtonClicked() {
        print("1")
    }

}

extension AddPillFirstViewController: UICollectionViewDelegate {
    
}

extension AddPillFirstViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pillTimeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = addPillFirstView.collectionView.dequeueReusableCell(for: indexPath, cellType: PillTimeCollectionViewCell.self)
        
        cell.timeLabel.text = pillTimeList[indexPath.row]
        
        return cell
    }
}
