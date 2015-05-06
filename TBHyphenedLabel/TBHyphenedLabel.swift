//
//  TBHyphenedLabel.swift
//  TBHyphenedLabel
//
//  Created by Bhattacharyya, Tushar on 5/5/15.
//
//

import UIKit
import CoreGraphics

/**
*  Draws hyphened text. It fills the remaning space of the label with hyphen in both side.
*  ----- Some Text -----
*/

public class TBHyphenedLabel:UILabel  {

    public var spaceBetweenTextAndHyphen: NSNumber! // can be mentioned in xib/storyboard through "User Define Runtime attributes" in the Identity Inspector.

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.customise()
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customise()
    }
    
    func customise(){
        self.textAlignment = .Center
    }
    
    public override func drawRect(rect: CGRect) {
        // if 'spaceBetweenTextAndHyphen' is set from IB use it, otherwise use default value of 3
        let space: CGFloat = CGFloat((spaceBetweenTextAndHyphen != nil) ? spaceBetweenTextAndHyphen.floatValue : 3)

        let textLength = self.text?.sizeWithAttributes([NSFontAttributeName: self.font]).width
        let lengthForEachHyphen = ((rect.size.width - textLength!) - 2 * space)/2
        let yPositionForHyphen = self.font.lineHeight/2
        
        var context: CGContextRef = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(context, self.textColor.CGColor);
        CGContextSetLineWidth(context, 1);
        
        CGContextMoveToPoint(context, 0, yPositionForHyphen);
        CGContextAddLineToPoint(context, lengthForEachHyphen, yPositionForHyphen);
        CGContextStrokePath(context);
        CGContextMoveToPoint(context, lengthForEachHyphen+space*2+textLength!, yPositionForHyphen);
        CGContextAddLineToPoint(context, rect.size.width, yPositionForHyphen);
        CGContextStrokePath(context);
        
        super.drawRect(rect)
    }
}