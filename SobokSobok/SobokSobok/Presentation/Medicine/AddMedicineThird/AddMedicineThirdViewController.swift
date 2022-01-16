//
//  AddMedicineThirdViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/14.
//

import UIKit

final class AddMedicineThirdViewController: BaseViewController {
    
    // MARK: - Properties
    private var medicineTimeData: [String] = [] {
        didSet {
            timeCollectionView.reloadData()
        }
    }
    
    // MARK: @IBOutlet
    @IBOutlet weak var timeCollectionView: UICollectionView!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
    // MARK: Function
    private func setCollectionView() {
        timeCollectionView.dataSource = self
        timeCollectionView.delegate = self
        // register
        timeCollectionView.register(AddTimeCollectionViewCell.self)
        timeCollectionView.register(AddMedicineTimeFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddMedicineTimeFooterView.reuseIdentifier)
        // CollectionViewFlowLayout
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        timeCollectionView.contentInset = UIEdgeInsets.init(top: 8, left: 20, bottom: 0, right: 20)
        timeCollectionView.showsVerticalScrollIndicator = false
        timeCollectionView.collectionViewLayout = flowLayout
    }
}

// MARK: UICollectionViewDelegate
extension AddMedicineThirdViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource
extension AddMedicineThirdViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medicineTimeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: AddTimeCollectionViewCell.self)
        
        cell.deleteCellClosure = {
            self.medicineTimeData.remove(at: 0)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddMedicineTimeFooterView.reuseIdentifier, for: indexPath) as? AddMedicineTimeFooterView else { return UICollectionReusableView()}
        // FooterView +버튼 클릭 시 셀 추가
        cell.addCellClosure = {
            self.medicineTimeData.append("")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let addMedicineTimeSheet = MedicineTimeViewController.instanceFromNib()
        addMedicineTimeSheet.modalPresentationStyle = .overCurrentContext
        addMedicineTimeSheet.modalTransitionStyle = .crossDissolve
        self.present(addMedicineTimeSheet, animated: false
        ) {
            DispatchQueue.main.async {
                addMedicineTimeSheet.sheetWithAnimation()
            }
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension AddMedicineThirdViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 54)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 54)
    }
}
