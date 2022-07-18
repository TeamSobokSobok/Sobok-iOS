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
    
    func setEmptyView(title: String, image: UIImage, message: String) {
        let emptyView = UIView().then {
            $0.frame = CGRect(x: self.center.x, y: self.center.y, width: self.bounds.width, height: self.bounds.height)
        }
        
        let titleLabel = UILabel().then {
            $0.textAlignment = .left
            $0.text = title
            $0.textColor = Color.black
            $0.font = UIFont.font(.pretendardBold, ofSize: 24)
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
        
        [titleLabel, sobokImage, descriptionLabel].forEach {
            emptyView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(84)
            $0.left.equalTo(20)
        }
        
        sobokImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(297)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(165)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(491)
            $0.leading.equalToSuperview().offset(28)
            $0.width.equalTo(318)
        }
        
        self.backgroundView = emptyView
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
