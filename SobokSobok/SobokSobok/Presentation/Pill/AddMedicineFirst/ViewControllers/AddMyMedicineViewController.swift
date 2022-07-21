//
//  AddMyMedicineViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/10.
//

import UIKit

final class AddMyMedicineViewController: BaseViewController {
    
    enum TossPill: Int {
        case me, friend
    }
    
    // MARK: Properties
    var tossPill: TossPill?
    var selectedPeopleName: String?
    var medicineData: [String] = [""] {
        didSet {
            addMyMedicineView.collectionView.reloadData()
        }
    }
    
    private let addMyMedicineView = AddMyMedicineView()
    
    override func loadView() {
        self.view = addMyMedicineView
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegate()
        actionPeopleSelectButton()
        divideViewControllerCase()
    }
    
    override func style() {
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: Functions
    func divideViewControllerCase() {
        addMyMedicineView.whoLabel.text = tossPill == .me ? "내가 먹을 약이에요" : "하니에게 전송할 약이에요"
        addMyMedicineView.navigationTitleLabel.text = tossPill == .me ? "내 약 추가하기" : "약 전송하기"
        addMyMedicineView.peopleLabel.text = tossPill == .me ? "나" : "하니"
        addMyMedicineView.morePillImage.isHidden = tossPill == .me
        addMyMedicineView.peopleSelectButton.isEnabled = tossPill == .friend
    }
    
    private func assignDelegate() {
        addMyMedicineView.collectionView.delegate = self
        addMyMedicineView.collectionView.dataSource = self
    }
    
    private func actionPeopleSelectButton() {
        addMyMedicineView.peopleSelectButton.addTarget(self, action: #selector(peopleSelectButtonClicked), for: .touchUpInside)
        addMyMedicineView.nextButton.addTarget(self, action: #selector(pushDivideMedicineSecondViewController), for: .touchUpInside)
        addMyMedicineView.xButton.addTarget(self, action: #selector(popTabbarController), for: .touchUpInside)
    }
    
    func pushMedicineSecondViewController(tossPill: AddMedicineSecondViewController.TossPill) {
        let addMedicineSecondViewController = AddMedicineSecondViewController.instanceFromNib()
        addMedicineSecondViewController.tossPill = tossPill
        addMedicineSecondViewController.medicineData = medicineData
        navigationController?.pushViewController(addMedicineSecondViewController, animated: true)
    }
                  
    @objc func peopleSelectButtonClicked() {
        let addPeopleViewController = AddPeopleViewController.instanceFromNib()
        addPeopleViewController.modalPresentationStyle = .overCurrentContext
        addPeopleViewController.modalTransitionStyle = .crossDissolve
        addPeopleViewController.sendDelegate = self
        self.present(addPeopleViewController, animated: true)
    }
    
    @objc func pushDivideMedicineSecondViewController() {
        tossPill == .me ? pushMedicineSecondViewController(tossPill: .me) : pushMedicineSecondViewController(tossPill: .friend)
    }
    
    @objc func popTabbarController() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: UICollectionViewDelegate

extension AddMyMedicineViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource

extension AddMyMedicineViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medicineData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: AddMyMedicineCollectionViewCell.self)
        cell.delegate = self
        cell.index = indexPath.row
        cell.medicineTextField.text = medicineData[indexPath.row]
        //         셀 X버튼 클릭 시 셀 삭제
        
        cell.deleteCellClosure = {
            self.medicineData.remove(at: indexPath.row)
            collectionView.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = addMyMedicineView.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddMyMedicineFooterView.reuseIdentifier, for: indexPath) as? AddMyMedicineFooterView else { return UICollectionReusableView()}
        
        // FooterView +버튼 클릭 시 셀 추가
        cell.addMedicineCellClosure = {
            self.medicineData.append("")
            self.addMyMedicineView.collectionView.reloadData()
        }
        
        // 추후 코드 리팩토링 예정
        if self.medicineData.count == 5 {
            cell.addMedicineCellButton.isHidden = true
            cell.withMedicineLabel.isHidden = true
            cell.plusImage.isHidden = true
            cell.withLabel.isHidden = true
        } else {
            cell.addMedicineCellButton.isHidden = false
            cell.withMedicineLabel.isHidden = true
            cell.plusImage.isHidden = false
            cell.withLabel.isHidden = false
        }
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension AddMyMedicineViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 82)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 54)
    }
}

// MARK: Delegate
extension AddMyMedicineViewController: SendPeopleNameDelegate {
    func sendPeopleName(name: String) {
        addMyMedicineView.peopleLabel.text = name
        addMyMedicineView.whoLabel.text = "\(name)에게 전송할 약이에요"
        UserDefaults.standard.set(name, forKey: "friendName")
    }
}

extension AddMyMedicineViewController: AddMyMedicineCollectionViewCellDelegate {
    func cellTextFieldChange(for cell: AddMyMedicineCollectionViewCell) {
        guard let index = cell.index else {return}
        medicineData[index] = cell.medicineTextFieldText
        addMyMedicineView.collectionView.reloadData()
        UserDefaults.standard.set(medicineData, forKey: "medicineData")
    }
}
