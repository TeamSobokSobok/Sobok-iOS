//
//  AddMedicineFourthViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/16.
//

import UIKit
import Moya

final class AddMedicineFourthViewController: BaseViewController {
    
    // MARK: Property
    // 임시 데이터
    private var medicineList: [String] = [] {
        didSet {
            medicineInfoCollectionView.reloadData()
        }
    }
    
    // MARK: @IBOutlets
    @IBOutlet weak var medicineInfoCollectionView: UICollectionView!
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        getMyPillCount()
    }
    
    override func style() {
        super.style()
        
    }
    
    // MARK: Functions
    private func setCollectionView() {
        medicineInfoCollectionView.delegate = self
        medicineInfoCollectionView.dataSource = self
        // register
        medicineInfoCollectionView.register(MedicineInfoCollectionViewCell.self)
        medicineInfoCollectionView.register(AddMyMedicineFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddMyMedicineFooterView.reuseIdentifier)
        medicineInfoCollectionView.register(MedicineInfoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MedicineInfoHeaderView.reuseIdentifier)
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
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MedicineInfoHeaderView.reuseIdentifier, for: indexPath) as? MedicineInfoHeaderView else { return UICollectionReusableView()}
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddMyMedicineFooterView.reuseIdentifier, for: indexPath) as? AddMyMedicineFooterView else { return UICollectionReusableView()}
            
            footerView.addMedicineCellClosure = {
                self.medicineList.append("")
                self.getMyPillCount()
            }
            return footerView
        default:
            assert(false, "응 아니야")
            
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension AddMedicineFourthViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 75)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 54)
    }
}

extension AddMedicineFourthViewController {
    
    func getMyPillCount() {
        PillCountAPI.shared.getMyPillCount(completion: { (result) in
            switch result {
            case .success(let pill):
                if let data = pill as? PillCount {
                    print(data)// UI 등 할일 작성, reloadData 등등..
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        })
    }
}
