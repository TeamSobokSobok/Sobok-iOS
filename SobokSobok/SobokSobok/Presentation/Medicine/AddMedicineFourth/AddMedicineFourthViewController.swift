//
//  AddMedicineFourthViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/16.
//

import UIKit

final class AddMedicineFourthViewController: BaseViewController {

    // MARK: Property
    // 임시 데이터
    private var medicineList: [String] = [] {
        didSet {
            medicineInfoCollectionView.reloadData()
        }
    }

    // MARK: @IBOutlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var medicineInfoCollectionView: UICollectionView!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
    override func style() {
        super.style()
        mainView.makeRounded(radius: 8)
    }
    
    // MARK: Functions
    private func setCollectionView() {
        medicineInfoCollectionView.delegate = self
        medicineInfoCollectionView.dataSource = self
        // register
        medicineInfoCollectionView.register(MedicineInfoCollectionViewCell.self)
        medicineInfoCollectionView.register(AddMyMedicineFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddMyMedicineFooterView.reuseIdentifier)
        // flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 166)
        medicineInfoCollectionView.collectionViewLayout = flowLayout
    }
}

// MARK: UICollectionViewDelegate
extension AddMedicineFourthViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource
extension AddMedicineFourthViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medicineList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MedicineInfoCollectionViewCell.self)
        cell.deleteCellClosure = {
            self.medicineList.remove(at: 0)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddMyMedicineFooterView.reuseIdentifier, for: indexPath) as? AddMyMedicineFooterView else { return UICollectionReusableView()}
        // FooterView +버튼 클릭 시 셀 추가
        cell.addMedicineCellClosure = {
            self.medicineList.append("")
        }
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension AddMedicineFourthViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 54)
    }
}
