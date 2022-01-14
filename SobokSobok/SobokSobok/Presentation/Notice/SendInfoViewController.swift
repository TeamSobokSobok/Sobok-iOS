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
        $0.font = .systemFont(ofSize: 17)
    }
    let xButton = UIButton().then {
        $0.setImage(Image.icClose48, for: .normal)
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
    }
    
    // MARK: - Functions
    private func setUI() {
        [navigationView, navigationTitleLabel, xButton].forEach {
            view.addSubview($0)
        }
        [refuseButton, acceptButton].forEach {
            $0.cornerRadius = 12
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
    
    func assignDelegation() {
        sendInfoCollectionView.delegate = self
        sendInfoCollectionView.dataSource = self
    }
    
    func registerXib() {
        sendInfoCollectionView.register(SendInfoCollectionViewCell.self)
        sendInfoCollectionView.register(FooterCollectionViewCell.self)
    }
}

// MARK: - Extensions
extension SendInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sendInfoList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == sendInfoList.count {
            let footer = collectionView.dequeueReusableCell(for: indexPath, cellType: FooterCollectionViewCell.self)
            return footer
        } else {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SendInfoCollectionViewCell.self)
            cell.setData(sendInfoData: sendInfoList[indexPath.row])
            cell.makeRoundedWithBorder(radius: 12, color: Color.gray300!.cgColor)
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
        if indexPath.row == sendInfoList.count {
            return CGSize(width: 335, height: 76)
        } else {
            return CGSize(width: 335, height: 166)
        }
    }
}
