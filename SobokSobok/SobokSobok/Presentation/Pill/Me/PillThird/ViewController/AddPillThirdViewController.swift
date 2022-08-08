//
//  AddPillThirdViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/04/30.
//

import UIKit

protocol AddPillThirdProtocol: TargetProtocol, DelegationProtocol, BindProtocol, TossPillProtocol {}

final class AddPillThirdViewController: UIViewController, AddPillThirdProtocol {
 
    var type: TossPill = .myPill
    let timeArray: [String] = []
    let addPillThirdView = AddPillThirdView()
    let addPillInfoView = AddPillInfoView()
    
    private let sendPillViewModel: SendPillViewModel
    private let pillThirdViewModel: PillThirdViewModel
    
    init(sendPillViewModel: SendPillViewModel, pillThirdViewModel: PillThirdViewModel) {
        self.sendPillViewModel = sendPillViewModel
        self.pillThirdViewModel = pillThirdViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = addPillThirdView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
        target()
        bind()
    }
    
    func target() {
        addPillThirdView.nextButton.addTarget(self, action: #selector(divideType), for: .touchUpInside)
        
        addPillThirdView.countInfoButton.addTarget(self, action: #selector(hideToolTipImage), for: .touchUpInside)
    }
    
    func assignDelegation() {
        addPillThirdView.collectionView.delegate = self
        addPillThirdView.collectionView.dataSource = self
    }
    
    func bind() {
        pillThirdViewModel.pillCount.bind { count in
            self.addPillThirdView.pillCountLabel.text = "\(count)개"
        }
        
        pillThirdViewModel.pillList.bind { _ in
            DispatchQueue.main.async {
                self.addPillThirdView.collectionView.reloadData()
            }
        }
    }
    
    private func presentView() {
        let bottomSheetVC = AddPillInfoViewController(sendPillViewModel: SendPillViewModel())
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        bottomSheetVC.modalTransitionStyle = .crossDissolve
        self.present(bottomSheetVC, animated: false, completion: nil)
    }
    
    private func postMyPill() {
        sendPillViewModel.postFriendPill()
    }
    
    @objc func divideType() {
        switch type {
        case .myPill:
            postMyPill()
        case .friendPill:
            presentView()
        }
    }
    
    @objc func hideToolTipImage() {
        addPillThirdView.tooltipImage.isHidden.toggle()
    }
    
    func divide(style: PillStyle) {
        
        let navigationView = addPillThirdView.navigationView
        
        type = style.type
        
        [navigationView.bottomFirstView,
         navigationView.bottomSecondView].forEach {
            $0.isHidden = style.bottomNavigationBarIsHidden
        }
        
        [navigationView.sendBottomFirstView,
         navigationView.sendBottomSecondView,
         navigationView.sendBottomThirdView].forEach {
            $0.isHidden = style.sendBottomNavigationBarIsHidden
        }
    }
}

extension AddPillThirdViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pillThirdViewModel.pillList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: AddPillCollectionViewCell.self)
    
        cell.pillThirdViewModel.deleteCellClosure = { [weak self] in
            guard let self = self else { return }
            self.pillThirdViewModel.deleteCell(index: indexPath.row)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let cell = addPillThirdView.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddPillFooterView.reuseIdentifier, for: indexPath) as? AddPillFooterView else { return UICollectionReusableView() }
        
            cell.viewModel.addCellClosure = { [weak self] in
                guard let self = self else { return }
                self.pillThirdViewModel.addCell()
            }
        
        self.pillThirdViewModel.hideFooterView(button: &cell.addPillButton.isHidden)
      
        return cell
    }
}

extension AddPillThirdViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 54)
    }
}
