//
//  AddPillThirdViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/04/30.
//

import UIKit

import RxCocoa
import RxSwift

protocol AddPillThirdProtocol: TargetProtocol, BindProtocol, TossPillProtocol, StyleProtocol, DelegationProtocol {}

final class AddPillThirdViewController: UIViewController, AddPillThirdProtocol {
    
    private let disposeBag = DisposeBag()
    var type: TossPill = .myPill
    private let addPillThirdView = AddPillThirdView()
    private let addPillInfoView = AddPillInfoView()
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
        target()
        bind()
        style()
        didTappedView()
        assignDelegation()
    }
    
    func assignDelegation() {
        addPillThirdView.collectionView.dataSource = self
        addPillThirdView.collectionView.delegate = self
        addPillThirdView.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addPillThirdView.collectionView.collectionViewLayout = createCompositionalLayoutForFirst()
    }
    
    func style() {
        self.view.backgroundColor = Color.white
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
        
        addPillThirdView.navigationView.xButton.rx.tap.bind {
            self.navigationController?.popViewController(animated: true)
        }
        .disposed(by: disposeBag)
        
        addPillThirdView.navigationView.cancelButton.rx.tap.bind {
            let viewController = StopPillViewController(
                navigation: self.navigationController!
            )
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .overFullScreen
            self.present(viewController, animated: true)
        }
        .disposed(by: disposeBag)
    }
    
    fileprivate func createCompositionalLayoutForFirst() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(54))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            
            let groupHeight = NSCollectionLayoutDimension.fractionalWidth(1/4)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            
            
            let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: .absolute(54))
            
            let footer = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: footerHeaderSize,
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom)
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            section.boundarySupplementaryItems = [footer]
            return section
        }
        return layout
    }
    
    func didTappedView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(hideToolTipImage))
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideToolTipImage() {
        addPillThirdView.tooltipImage.isHidden = true
    }
    
    func target() {
        addPillThirdView.nextButton.addTarget(self, action: #selector(divideType), for: .touchUpInside)
        
        addPillThirdView.countInfoButton.addTarget(self, action: #selector(openToolTipImage), for: .touchUpInside)
    }
    
    @objc func openToolTipImage() {
        addPillThirdView.tooltipImage.isHidden = false
    }
    
    private func presentView() {
        let bottomSheetVC = AddPillInfoViewController(sendPillViewModel: sendPillViewModel)
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        bottomSheetVC.modalTransitionStyle = .crossDissolve
        self.present(bottomSheetVC, animated: false)
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
    
    private func enableNextButton() {
        addPillThirdView.nextButton.backgroundColor = Color.mint
        addPillThirdView.nextButton.setTitleColor(Color.white, for: .normal)
        addPillThirdView.nextButton.isEnabled = true
    }
    
    private func unableNextButton() {
        addPillThirdView.nextButton.backgroundColor = Color.gray200
        addPillThirdView.nextButton.setTitleColor(Color.gray500, for: .normal)
        addPillThirdView.nextButton.isEnabled = false
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
        
        navigationView.navigationTitleLabel.text = style.navigationTitle
    }
}

extension AddPillThirdViewController: UICollectionViewDelegate {}

extension AddPillThirdViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pillThirdViewModel.pillList.value.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PillNameViewCell.self)
        
        cell.pillNameTextField.tag = indexPath.row
        
        cell.delegate = self
        
        cell.pillThirdViewModel.deleteCellClosure = {
            self.pillThirdViewModel.deleteCell(index: indexPath.row)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddPillFooterView.reuseIdentifier, for: indexPath) as? AddPillFooterView else { return UICollectionReusableView()}
        
        cell.viewModel.addCellClosure = { [weak self] in
            guard let self = self else { return }
            self.pillThirdViewModel.addCell()
        }
        
        self.pillThirdViewModel.hideFooterView(button: &cell.addPillButton.isHidden)
        
        return cell
    }
}

extension AddPillThirdViewController: PillNameCellDelegate {
    func didTapPillNameTextField(text: String, tag: Int) {
        pillThirdViewModel.pillList.value[tag] = text
    }
}

