//
//  EmptyView.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/02/17.
//

import UIKit

import SnapKit
import Then

extension UICollectionView {
    func setEmptyView(image: UIImage, message: String) {
        let emptyView = UIView().then {
            $0.frame = CGRect(x: self.center.x, y: self.center.y, width: self.bounds.width, height: self.bounds.height)
        }
        let sobokImage = UIImageView().then {
            $0.image = image
            $0.contentMode = .scaleAspectFit
        }
        let descriptionLabel = UILabel().then {
            $0.textAlignment = .center
            $0.text = message
            $0.textColor = Color.gray500
            $0.font = UIFont.font(.pretendardRegular, ofSize: 16)
        }
        
        // MARK: - Render
        [sobokImage, descriptionLabel].forEach { emptyView.addSubview($0) }

        sobokImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(178)
            make.centerX.equalToSuperview()
            make.height.equalTo(165.adjustedHeight)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(sobokImage.snp.bottom).offset(29)
            make.centerX.equalToSuperview()
        }
        self.backgroundView = emptyView
    }
    
    // MARK: - Empty
    func restore() {
        let noticeListView = NoticeListView()
        self.backgroundView = noticeListView
    }
}
