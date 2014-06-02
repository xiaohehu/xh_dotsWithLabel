//
//  xh_dotsLabel.h
//  xh_dotsWithLabel
//
//  Created by Xiaohe Hu on 5/30/14.
//  Copyright (c) 2014 Xiaohe Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xh_dotsLabel : UIView
{
    CGRect      viewFrame;
    float       x_Value;
    float       y_Value;
    float       radius_Value;
    float       space_Value;
    float       font_Size;
    int         numOfDots;
    BOOL        directionUP;
}

@property (nonatomic, strong) NSDictionary *dict_viewData;
@end
