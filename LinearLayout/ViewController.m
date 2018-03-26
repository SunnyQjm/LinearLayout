//
//  ViewController.m
//  LinearLayout
//
//  Created by OurEDA on 2018/3/25.
//  Copyright © 2018 OurEDA. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat windowWidth = self.view.bounds.size.width;
    CGFloat windowHeight = self.view.bounds.size.height;
    LinearLayoutView *linearLayout = [[LinearLayoutView alloc] initWithFrame:
            CGRectMake(0, 20, windowWidth, windowHeight)];
    linearLayout.backgroundColor = [UIColor lightGrayColor];
//    linearLayout.orientation = HORIZONTAL;
    linearLayout.weightSum = 5;
    UITextView *tv = [[UITextView alloc]init];
    tv.text = @"sdafsd";
    tv.backgroundColor = [UIColor redColor];
    [linearLayout addSubView:tv withLayoutParams:[[LinearLayoutParams alloc] initWithWidth:[LinearLayoutParams MATCH_PARENT] withHeight:0 withGravity: GRAVITY_CENTER withWeight:2]];
    tv = [[UITextView alloc] init];
    tv.text = @"ndsfjksdnfkjsdnf";
    tv.backgroundColor = [UIColor greenColor];
    [linearLayout addSubView:tv withLayoutParams:[[LinearLayoutParams alloc] initWithWidth:200 withHeight:0 withGravity:GRAVITY_CENTER withWeight:2] ];
//    tv = [[UITextView alloc] init];
//    tv.text = @"sdafsd";
//    tv.backgroundColor = [UIColor redColor];
//    [linearLayout addSubView:tv withLayoutParams:[[LinearLayoutParams alloc] initWithWidth:[LinearLayoutParams MATCH_PARENT] withHeight:200]];
//
//    tv = [[UITextView alloc] init];
//    tv.text = @"ndsfjksdnfkjsdnf";
//    tv.backgroundColor = [UIColor greenColor];
//    [linearLayout addSubView:tv withLayoutParams:[[LinearLayoutParams alloc] initWithWidth:200 withHeight:200 withGravity:GRAVITY_END]];

    [self.view addSubview:linearLayout];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end