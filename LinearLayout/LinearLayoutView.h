//
//  LinearLayoutView.h
//  LinearLayout
//
//  Created by OurEDA on 2018/3/25.
//  Copyright © 2018 OurEDA. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum Gravity{
    GRAVITY_CENTER, GRAVITY_START, GRAVITY_END
} ;

typedef enum Orientation{
    VERTICAL, HORIZONTAL
};

@interface LinearLayoutParams : NSObject

- initWithWidth:(CGFloat)width withHeight:(CGFloat)height;

- initWithWidth:(CGFloat)width withHeight:(CGFloat)height withGravity:(enum Gravity)gravity;

- initWithWidth:(CGFloat)width withHeight:(CGFloat)height withWeight:(int)weight;


- initWithWidth:(CGFloat)width withHeight:(CGFloat)height withGravity:(enum Gravity)gravity withWeight: (int) weight;

@property(assign, nonatomic) enum Gravity gravity;

@property(assign, nonatomic) CGFloat width;
@property(assign, nonatomic) CGFloat height;
@property(class, readonly) CGFloat MATCH_PARENT;

@property(assign, nonatomic) int weight;

@end

@interface LinearLayoutView : UIView {
    NSMutableArray *subViews;
    NSMutableArray *layoutParams;
}

@property(assign, nonatomic) enum Orientation orientation;

@property(assign, nonatomic) int weightSum;

- (void)addSubView:(UIView *)subView withLayoutParams:(LinearLayoutParams *)params;

@end
