//
//  NoticeToolTipView.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/10.
//

import UIKit

import SnapKit
import Then

final class NoticeToolTipView: UIView {
    init(
        tipStartX: CGFloat,
        tipWidth: CGFloat,
        tipHeight: CGFloat
    ) {
        super.init(frame: .zero)
        self.backgroundColor = Color.black
        
        let path = CGMutablePath()
        
        let tipWidthCenter = tipWidth / 2.0
        let endXwidth = tipStartX + tipWidth
        
        path.move(to: CGPoint(x: tipStartX, y: 0))
        path.addLine(to: CGPoint(x: tipStartX + tipWidthCenter, y: -tipHeight))
        path.addLine(to: CGPoint(x: endXwidth, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = Color.black.cgColor
        
        self.layer.insertSublayer(shape, at: 0)
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 6
        
        self.addLabel()
    }
    
    private func addLabel() {
        let titleLabel = UILabel()
        titleLabel.textColor = Color.white
        titleLabel.text = "친구가 보낸 약 알림 일정을 확인해보세요"
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.font(.pretendardMedium, ofSize: 14)
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(9)
            make.left.right.equalToSuperview().inset(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
