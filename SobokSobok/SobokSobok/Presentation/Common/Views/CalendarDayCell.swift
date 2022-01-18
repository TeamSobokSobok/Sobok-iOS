//
//  CalendarDayCell.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/15.
//

import UIKit
import FSCalendar
import SwiftUI

enum FilledType: Int {
    case none
    case all
    case some
    case today
}

enum SelectedType: Int {
    case not
    case single
}

final class CalendarDayCell: FSCalendarCell {
    weak var circleImageView: UIImageView!
    weak var selectionLayer: CAShapeLayer!
    
    var width: CGFloat = 32.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var yPosition: CGFloat = 2.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var filledType: FilledType = .none {
        didSet {
            setNeedsLayout()
        }
    }
    
    var selectedType: SelectedType = .not {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let circleImageView = UIImageView(image: Image.calenderBackgroundSome)
        self.contentView.insertSubview(circleImageView, at: 0)
        self.circleImageView = circleImageView
        self.shapeLayer.isHidden = true
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = width
        let yPosition = yPosition
        let distance = (self.contentView.bounds.width - width) / 2
        let frame = CGRect(x: self.contentView.bounds.minX + distance,
                           y: self.contentView.bounds.minY + yPosition,
                           width: width,
                           height: width)
        self.circleImageView.frame = frame
        
        switch selectedType {
        case .not:
            self.titleLabel.font = UIFont.font(.pretendardRegular, ofSize: 16)
        case .single:
            self.titleLabel.font = UIFont.font(.pretendardBold, ofSize: 22)
        }
        
        switch filledType {
        case .all:
            self.titleLabel.textColor = Color.white
            self.circleImageView.image = Image.calenderBackgroundAll
        case .some:
            self.titleLabel.textColor = Color.black
            self.circleImageView.image = Image.calenderBackgroundSome
        case .today:
            self.titleLabel.textColor = Color.black
            self.titleLabel.font = UIFont.font(.pretendardBold, ofSize: 22)
            self.circleImageView.image = Image.calendarBackgroundToday
        case .none:
            self.titleLabel.textColor = Color.black
            self.circleImageView.image = nil
        }
    }
}
