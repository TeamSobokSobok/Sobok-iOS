//
//  SendInfoViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/11.
//

import UIKit

import Then
import SnapKit

final class SendInfoViewController: UIViewController {
    
    // MARK: - Properties
    let navigationView = UIView().then {
        $0.backgroundColor = .white
    }
    let navigationTitleLabel = UILabel().then {
        $0.text = "전송 받은 약"
        $0.font = UIFont.font(.pretendardRegular, ofSize: 17)
    }
    let xButton = UIButton().then {
        $0.setImage(Image.icClose48, for: .normal)
        $0.tintColor = Color.black
    }
    private var sendInfoList: [SendInfoListData] = SendInfoListData.dummy
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var refuseButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var sendInfoCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setConstraints()
        assignDelegation()
        registerXib()
        addDismissButton()
    }
    
    // MARK: - Functions
    private func setUI() {
        [navigationView, navigationTitleLabel, xButton].forEach {
            view.addSubview($0)
        }
        [refuseButton, acceptButton].forEach {
            $0?.makeRounded(radius: 12)
        }
    }
    
    private func setConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(102)
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.equalTo(navigationView)
            $0.bottom.equalTo(navigationView).inset(20)
        }
        
        xButton.snp.makeConstraints {
            $0.leading.equalTo(navigationView).inset(1)
            $0.centerY.equalTo(navigationTitleLabel)
        }
    }
    
    private func addDismissButton() {
       xButton.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
    }
    
    @objc func xButtonClicked() {
        self.dismiss(animated: true)
    }
    
    func assignDelegation() {
        sendInfoCollectionView.delegate = self
        sendInfoCollectionView.dataSource = self
    }
    
    func registerXib() {
        sendInfoCollectionView.register(SendInfoCollectionViewCell.self)
        sendInfoCollectionView.register(FooterCollectionViewCell.self)
        sendInfoCollectionView.register(SenderInfoCollectionViewCell.self)
    }
}

// MARK: - Extensions
extension SendInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sendInfoList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let header = collectionView.dequeueReusableCell(for: indexPath, cellType: SenderInfoCollectionViewCell.self)
            return header
        case sendInfoList.count:
            let footer = collectionView.dequeueReusableCell(for: indexPath, cellType: FooterCollectionViewCell.self)
            return footer
        default:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SendInfoCollectionViewCell.self)
            cell.index = indexPath.row
            cell.delegate = self
            cell.setData(sendInfoData: sendInfoList[indexPath.row])
            cell.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
            return cell
        }
    }
}

extension SendInfoViewController: UICollectionViewDelegate { }

extension SendInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0:
            return CGSize(width: 335, height: 48)
        case sendInfoList.count:
            return CGSize(width: 335, height: 76)
        default:
            return CGSize(width: 335, height: 166)
        }
    }
}

extension SendInfoViewController: EditCellDelegate {
    func selectedInfoButton(index: Int) {
        let nextVC = PillInfoEditViewController.instanceFromNib()
        self.present(nextVC, animated: true)
    }
}
