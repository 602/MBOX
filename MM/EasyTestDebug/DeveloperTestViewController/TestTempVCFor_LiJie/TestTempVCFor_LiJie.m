//
//  TestTempVCFor_LiJie.m
//  QQing
//
//  Created by Ben on 6/10/15.
//  Copyright (c) 2014 QQing. All rights reserved.
//

#import "TestTempVCFor_LiJie.h"
#import "TestUtil.h"

@interface TestTempVCFor_LiJie ()

@end

@implementation TestTempVCFor_LiJie

#pragma mark - View Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"XinZhang的临时测试页面";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
