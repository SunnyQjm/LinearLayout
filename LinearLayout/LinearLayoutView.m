//
//  LinearLayoutView.m
//  LinearLayout
//
//  Created by OurEDA on 2018/3/25.
//  Copyright © 2018 OurEDA. All rights reserved.
//

#import "LinearLayoutView.h"

@implementation LinearLayoutParams

- (id)initWithWidth:(CGFloat)width withHeight:(CGFloat)height {
    if(self = [super init]){
        self.width = width;
        self.height = height;
        self.gravity = GRAVITY_START;
        self.weight = 0;
    }
    return self;
}

- (id)initWithWidth:(CGFloat)width withHeight:(CGFloat)height withGravity:(enum Gravity)gravity {
    if(self = [super init]){
        self.width = width;
        self.height = height;
        self.gravity = gravity;
        self.weight = 0;
    }
    return self;
}

- (id)initWithWidth:(CGFloat)width withHeight:(CGFloat)height withWeight:(int)weight {
    if(self = [super init]){
        self.width = width;
        self.height = height;
        self.gravity = GRAVITY_START;
        self.weight = weight;
    }
    return self;
}

- (id)initWithWidth:(CGFloat)width withHeight:(CGFloat)height withGravity:(enum Gravity)gravity withWeight:(int)weight {
    if(self = [super init]){
        self.width = width;
        self.height = height;
        self.gravity = gravity;
        self.weight = weight > 0 ? weight : 0;
    }
    return self;
}


+ (CGFloat)MATCH_PARENT {
    return -1;
}

@end

@implementation LinearLayoutView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //初始化
        self.orientation = VERTICAL;
        self.weightSum = -1;
        subViews = [[NSMutableArray alloc] init];
        layoutParams = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if([subViews count] != [layoutParams count])
        return;
    //给subViews布局
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;

    int totalSubWeight = 0;
    CGFloat totalLayoutHeight = 0;
    CGFloat totalLayoutWidth = 0;
    CGFloat remainSpace = 0;
    //给subview布局
    for(int i = 0; i < [subViews count]; i++){
        LinearLayoutParams *lp = ((LinearLayoutParams *)layoutParams[(NSUInteger) i]);
        totalSubWeight += lp.weight;
        //一旦有一个子空间的布局方向长度为MATCH_PARENT，就认为没有剩余空间了
        if((_orientation == VERTICAL && lp.height == [LinearLayoutParams MATCH_PARENT]) ||
                (_orientation == HORIZONTAL && lp.width == [LinearLayoutParams MATCH_PARENT]))
            remainSpace = -1;
        totalLayoutHeight += lp.height;
        totalLayoutWidth += lp.width;
    }
    if(remainSpace < 0){    //无剩余空间了
        remainSpace = 0;
    } else if(_orientation == VERTICAL){
        remainSpace = (height - totalLayoutHeight) > 0 ? (height - totalLayoutHeight) : 0;
    } else {
        remainSpace = (width - totalLayoutWidth) > 0 ? (width - totalLayoutWidth) : 0;
    }

    if(_orientation == VERTICAL){    //垂直布局
        CGFloat alreadyLayoutHeight = 0;
        for(NSUInteger i = 0; i < [subViews count]; i++){
            LinearLayoutParams * lp = (LinearLayoutParams *)layoutParams[i];
            CGFloat left = 0;
            CGFloat top = alreadyLayoutHeight;
            CGFloat mWidth = lp.width;
            CGFloat mHeight = lp.height;
            if(totalSubWeight > 0){
                mHeight += remainSpace * lp.weight / totalSubWeight;
            }
            if(lp.width == [LinearLayoutParams MATCH_PARENT])
                mWidth = width;
            else {
                switch (lp.gravity){
                    case GRAVITY_END:
                        left = width - lp.width;
                        break;
                    case GRAVITY_CENTER:
                        left = (width - lp.width) / 2;
                        break;
                    default:
                        break;
                }
            }
            if(lp.height == [LinearLayoutParams MATCH_PARENT])
                mHeight = (height - alreadyLayoutHeight) > 0? (height - alreadyLayoutHeight) : lp.height;
            ((UIView *)subViews[i]).frame =
                    CGRectMake(left, top, mWidth, mHeight);
            alreadyLayoutHeight += mHeight;
        }
    } else {    //水平布局
        CGFloat alreadyLayoutWidth = 0;
        for(NSUInteger i = 0; i < [subViews count]; i++){
            LinearLayoutParams * lp = (LinearLayoutParams *)layoutParams[i];
            CGFloat left = alreadyLayoutWidth;
            CGFloat top = 0;
            CGFloat mWidth = lp.width;
            CGFloat mHeight = lp.height;
            if(totalSubWeight > 0){
                mWidth += remainSpace * lp.weight / totalSubWeight;
            }
            if(lp.width == [LinearLayoutParams MATCH_PARENT])
                mWidth = (width - alreadyLayoutWidth) > 0? (width - alreadyLayoutWidth) : lp.width;
            if(lp.height == [LinearLayoutParams MATCH_PARENT])
                mHeight = height;
            else {
                switch (lp.gravity){
                    case GRAVITY_END:
                        top = height - lp.height;
                        break;
                    case GRAVITY_CENTER:
                        top = (height - lp.height) / 2;
                        break;
                    default:
                        break;
                }
            }
            ((UIView *)subViews[i]).frame =
                    CGRectMake(left, top, mWidth, mHeight);
            alreadyLayoutWidth += mWidth;
        }
    }

    if(totalSubWeight > _weightSum || _weightSum < 0){    //根据weight均分剩余空间
        //TODO 先留坑，待实现
    }


}

/**
 * add a sub view
 * @param subView
 * @param params
 */
- (void)addSubView:(UIView *)subView withLayoutParams:(LinearLayoutParams *)params {
    [self addSubview:subView];
    [subViews addObject:subView];
    [layoutParams addObject:params];
}


@end
