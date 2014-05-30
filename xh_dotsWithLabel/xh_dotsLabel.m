//
//  xh_dotsLabel.m
//  xh_dotsWithLabel
//
//  Created by Xiaohe Hu on 5/30/14.
//  Copyright (c) 2014 Xiaohe Hu. All rights reserved.
//

#import "xh_dotsLabel.h"
#define kBigDotSize  80.0

@interface xh_dotsLabel ()
@property (nonatomic, strong)   UIView          *uiv_bigDot;
@property (nonatomic, strong)   UITextView      *uitv_textView;
@end

@implementation xh_dotsLabel
@synthesize dict_viewData;

-(void)setDict_viewData:(NSDictionary *)viewData {
    if (viewData == nil)
        return;
    else {
        dict_viewData = [[NSDictionary alloc] init];
        dict_viewData = viewData;
        [self initViewData];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initViewData {
    //Get X,Y postion
    NSString *str_position = [[NSString alloc] initWithString:[dict_viewData objectForKey:@"xy"]];
    NSRange range = [str_position rangeOfString:@","];
    NSString *str_x = [str_position substringWithRange:NSMakeRange(0, range.location)];
    NSString *str_y = [str_position substringFromIndex:(range.location + 1)];
    x_Value = [str_x floatValue];
    y_Value = [str_y floatValue];
    
    //Get dots' radius
    NSNumber *radiusNum = [[NSNumber alloc] init];
    radiusNum = [dict_viewData objectForKey:@"radius"];
    radius_Value = [radiusNum floatValue];
    
    //Get space between dots
    NSNumber *spaceNum = [[NSNumber alloc] init];
    spaceNum = [dict_viewData objectForKey:@"space"];
    space_Value = [spaceNum floatValue];
    
    //Get num of dots
    NSNumber *dotsNum = [[NSNumber alloc] init];
    dotsNum = [dict_viewData objectForKey:@"num"];
    numOfDots = [dotsNum intValue];
    
    //Get direction
    directionUP = [[dict_viewData objectForKey:@"up"] boolValue];
    
    [self initDotsView];
}

-(void)initDotsView {
    
    self.frame = CGRectMake(x_Value, y_Value, kBigDotSize, kBigDotSize);
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor blueColor];
    
    //Create Dots
    if (directionUP) {
        self.frame = CGRectMake(x_Value, (y_Value - numOfDots * (space_Value + radius_Value*2)), kBigDotSize, numOfDots * (space_Value + radius_Value*2) + kBigDotSize);
        
        //Create big dot at bottom
        _uiv_bigDot = [[UIView alloc] init];
        _uiv_bigDot.backgroundColor = [UIColor whiteColor];
        _uiv_bigDot.frame = CGRectMake(0, numOfDots * (space_Value + radius_Value*2), kBigDotSize, kBigDotSize);
        CGPoint savedCenter = _uiv_bigDot.center;
        _uiv_bigDot.layer.cornerRadius = kBigDotSize/2.0;
        _uiv_bigDot.center = savedCenter;
        [self addSubview: _uiv_bigDot];
        
        for (int i = 0; i < numOfDots; i++) {
            UIView *uiv_smallDots = [[UIView alloc] init];
            uiv_smallDots.backgroundColor = [UIColor whiteColor];
            CGSize dotSize = CGSizeMake(radius_Value*2, radius_Value*2);
            CGPoint dotCenter = _uiv_bigDot.center;
            
            uiv_smallDots.frame = CGRectMake(dotCenter.x - radius_Value, dotCenter.y - kBigDotSize - space_Value - (space_Value + dotSize.height)*i, dotSize.width, dotSize.height);
            CGPoint savedCenter = uiv_smallDots.center;
            uiv_smallDots.layer.cornerRadius = radius_Value;
            uiv_smallDots.center = savedCenter;
            [self addSubview:uiv_smallDots];
        }
    }
    else {
        self.frame = CGRectMake(x_Value, y_Value, kBigDotSize, numOfDots * (space_Value + radius_Value*2) + kBigDotSize);
        
        //Create big dot at bottom
        _uiv_bigDot = [[UIView alloc] init];
        _uiv_bigDot.backgroundColor = [UIColor whiteColor];
        _uiv_bigDot.frame = CGRectMake(0, 0, kBigDotSize, kBigDotSize);
        CGPoint savedCenter = _uiv_bigDot.center;
        _uiv_bigDot.layer.cornerRadius = kBigDotSize/2.0;
        _uiv_bigDot.center = savedCenter;
        [self addSubview: _uiv_bigDot];
        
        for (int i = 0; i < numOfDots; i++) {
            UIView *uiv_smallDots = [[UIView alloc] init];
            uiv_smallDots.backgroundColor = [UIColor whiteColor];
            CGSize dotSize = CGSizeMake(radius_Value*2, radius_Value*2);
            CGPoint dotCenter = _uiv_bigDot.center;
            
            uiv_smallDots.frame = CGRectMake(dotCenter.x - radius_Value, dotCenter.y + kBigDotSize/2 + space_Value + (space_Value + dotSize.height)*i, dotSize.width, dotSize.height);
            CGPoint savedCenter = uiv_smallDots.center;
            uiv_smallDots.layer.cornerRadius = radius_Value;
            uiv_smallDots.center = savedCenter;
            [self addSubview:uiv_smallDots];
        }
    }
    
    [self initText];
}

-(void)initText {
    if (directionUP) {
        _uitv_textView = [[UITextView alloc] initWithFrame:CGRectMake(0, -100, 500, 100)];
        _uitv_textView.backgroundColor = [UIColor redColor];
        _uitv_textView.userInteractionEnabled = NO;
        NSString *textContent = [[NSString alloc] initWithString:[dict_viewData objectForKey:@"text"]];
        _uitv_textView.text = [textContent stringByReplacingOccurrencesOfString:@"+" withString:@"\n"];
        [_uitv_textView setFont:[UIFont fontWithName:nil size:20]];
        [_uitv_textView setTextColor:[UIColor whiteColor]];
        [self addSubview:_uitv_textView];

        CGSize textFrame = [_uitv_textView sizeThatFits:CGSizeMake(_uitv_textView.frame.size.width, FLT_MAX)];
        _uitv_textView.frame = CGRectMake( - (textFrame.width - kBigDotSize)/2, - textFrame.height, textFrame.width, textFrame.height);
    }
    else {
        _uitv_textView = [[UITextView alloc] initWithFrame:CGRectMake(0, -100, 500, 100)];
        _uitv_textView.backgroundColor = [UIColor redColor];
        _uitv_textView.userInteractionEnabled = NO;
        NSString *textContent = [[NSString alloc] initWithString:[dict_viewData objectForKey:@"text"]];
        _uitv_textView.text = [textContent stringByReplacingOccurrencesOfString:@"+" withString:@"\n"];
        [_uitv_textView setFont:[UIFont fontWithName:nil size:20]];
        [_uitv_textView setTextColor:[UIColor whiteColor]];
        [self addSubview:_uitv_textView];
#warning The following method only works in iOS 7
        CGSize textFrame = [_uitv_textView sizeThatFits:CGSizeMake(_uitv_textView.frame.size.width, FLT_MAX)];
        _uitv_textView.frame = CGRectMake( - (textFrame.width - kBigDotSize)/2, self.frame.size.height, textFrame.width, textFrame.height);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
