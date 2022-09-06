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
            self.circleImageView.image = selectedType == .not ?
            Image.calendarBackgroundTodayDefault : Image.calendarBackgroundToday
        case .none:
            self.titleLabel.textColor = Color.black
            self.circleImageView.image = nil
        }
    }
    
    func configureUI(isSelected: Bool, with type: FilledType) {
        width = isSelected ? 48 : 32
        yPosition = isSelected ? -6 : 2
        selectedType = isSelected ? .single : .not
        filledType = type
    }
}

enum SelectionType : Int {
    case none
    case single
    case leftBorder
    case middle
    case rightBorder
}

class DIYCalendarCell: FSCalendarCell {
    weak var selectionLayer: CAShapeLayer?
    weak var connectionLayer: CAShapeLayer?

    var selectionType: SelectionType = .none {
        didSet {
            if selectionType == .none {
                self.selectionLayer?.opacity = 0
                self.connectionLayer?.opacity = 0
                self.selectionLayer?.isHidden = true
                self.connectionLayer?.isHidden = true
                return
            }
            setNeedsLayout()
        }
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let selectionLayer = CAShapeLayer()
        selectionLayer.fillColor = UIColor(red: 228 / 255, green: 246 / 255, blue: 246 / 255, alpha: 1.0).cgColor
        selectionLayer.opacity = 0
        self.contentView.layer.insertSublayer(selectionLayer, below: self.titleLabel.layer)
        self.selectionLayer = selectionLayer
        self.selectionLayer?.isHidden = true

        let connectionLayer = CAShapeLayer()
        connectionLayer.fillColor = UIColor(red: 228 / 255, green: 246 / 255, blue: 246 / 255, alpha: 1.0).cgColor
        connectionLayer.opacity = 0
        self.contentView.layer.insertSublayer(connectionLayer, below: self.titleLabel.layer)
        self.connectionLayer = connectionLayer
        self.connectionLayer?.isHidden = true

        self.shapeLayer.isHidden = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.selectionLayer?.opacity = 0
        self.connectionLayer?.opacity = 0
        self.contentView.layer.removeAnimation(forKey: "opacity")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.selectionLayer?.frame = self.contentView.bounds.insetBy(dx: 0, dy: -3)
        self.connectionLayer?.frame = self.contentView.bounds.insetBy(dx: 0, dy: -3)
        guard var connectionRect = connectionLayer?.bounds else {
            return
        }
        
        connectionRect.size.height = connectionRect.height * 5 / 6
        if selectionType == .middle {
            self.connectionLayer?.isHidden = false
            self.connectionLayer?.opacity = 1
            self.connectionLayer?.path = UIBezierPath(rect: connectionRect).cgPath
            self.titleLabel.textColor = UIColor.black
        }
        else if selectionType == .leftBorder {
            self.connectionLayer?.isHidden = false
            self.connectionLayer?.opacity = 1
            var rect = connectionRect
            rect.origin.x = connectionRect.width / 2
            rect.size.width = connectionRect.width / 2
            self.connectionLayer?.path = UIBezierPath(rect: rect).cgPath
        }
        else if selectionType == .rightBorder {
            self.connectionLayer?.isHidden = false
            self.connectionLayer?.opacity = 1
            var rect = connectionRect
            rect.size.width = connectionRect.width / 2
            self.connectionLayer?.path = UIBezierPath(rect: rect).cgPath
        }

        if selectionType == .single || selectionType == .leftBorder || selectionType == .rightBorder {
            self.selectionLayer?.isHidden = false
            self.selectionLayer?.opacity = 1
            let diameter: CGFloat = min(connectionRect.height, connectionRect.width)
            let rect = CGRect(
                x: self.contentView.frame.width / 2 - diameter / 2,
                y: 0,
                width: diameter,
                height: diameter)
            self.selectionLayer?.path = UIBezierPath(ovalIn: rect).cgPath
        }
        
        if selectionType == .single {
            self.titleLabel.textColor = UIColor(red: 0 / 255, green: 171 / 255, blue: 182 / 255, alpha: 1.0)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()
        if self.isPlaceholder {
            self.eventIndicator.isHidden = true
            self.titleLabel.textColor = UIColor.lightGray
        }
    }
    
}
