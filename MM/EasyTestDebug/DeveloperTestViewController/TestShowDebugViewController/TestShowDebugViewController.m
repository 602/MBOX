//
//  TestShowDebugViewController.m
//  QQing
//
//  Created by Ben on 6/10/15.
//  Copyright (c) 2014 QQing. All rights reserved.
//

#import "TestShowDebugViewController.h"
#import "TestUtil.h"

@interface TestShowDebugViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation TestShowDebugViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.deleteButton circularCorner];
    [self.saveButton circularCorner];
    self.textView.text = [TestUtil currentTestDebugLog];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];	
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)removeFile:(id)sender
{
    NSArray *pathes = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [pathes[0] stringByAppendingPathComponent:@"QQingTestDebugLog.txt"];
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

- (IBAction)writeToFile:(id)sender
{
    NSArray *pathes = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [pathes[0] stringByAppendingPathComponent:@"QQingTestDebugLog.txt"];
    
    NSData *contentData = [[TestUtil currentTestDebugLog] dataUsingEncoding:NSUTF8StringEncoding];
    [contentData writeToFile:filePath atomically:YES];
}

@end
