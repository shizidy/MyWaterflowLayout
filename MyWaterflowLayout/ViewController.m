//
//  ViewController.m
//  MyWaterflowLayout
//
//  Created by wdyzmx on 2020/1/12.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import "ViewController.h"
#import "WaterFlowViewController.h"
#import "TagsLabelViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    [self.view addSubview:button1];
    button1.backgroundColor = [UIColor redColor];
    button1.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2 - 100);
    [button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"WaterFlow" forState:UIControlStateNormal];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    [self.view addSubview:button2];
    button2.backgroundColor = [UIColor redColor];
    button2.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2 + 100);
    [button2 addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"TagsLabel" forState:UIControlStateNormal];

    // Do any additional setup after loading the view.
}
/*
 UIModalPresentationFullScreen = 0,
 UIModalPresentationPageSheet API_AVAILABLE(ios(3.2)) API_UNAVAILABLE(tvos),
 UIModalPresentationFormSheet API_AVAILABLE(ios(3.2)) API_UNAVAILABLE(tvos),
 UIModalPresentationCurrentContext API_AVAILABLE(ios(3.2)),
 UIModalPresentationCustom API_AVAILABLE(ios(7.0)),
 UIModalPresentationOverFullScreen API_AVAILABLE(ios(8.0)),
 UIModalPresentationOverCurrentContext API_AVAILABLE(ios(8.0)),
 UIModalPresentationPopover API_AVAILABLE(ios(8.0)) API_UNAVAILABLE(tvos),
 UIModalPresentationBlurOverFullScreen API_AVAILABLE(tvos(11.0)) API_UNAVAILABLE(ios) API_UNAVAILABLE(watchos),
 UIModalPresentationNone API_AVAILABLE(ios(7.0)) = -1,
 UIModalPresentationAutomatic API_AVAILABLE(ios(13.0)) = -2,
 */
- (void)button1Action:(UIButton *)btn {
    WaterFlowViewController *viewController = [[WaterFlowViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)button2Action:(UIButton *)btn {
    TagsLabelViewController *viewController = [[TagsLabelViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}




@end
