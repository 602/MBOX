//
//  EvaluateService.m
//  QQing
//
//  Created by Maceria on 15/4/13.
//
//

#import "EvaluateService.h" 

#define EVALUATE_URL @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=803163099&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"

@implementation EvaluateService

SINGLETON_GCD(EvaluateService);

- (void)showEvaluteAlertView{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSInteger iKnow = [df integerForKey:@"iKnow"];
    BOOL ret = [df objectForKey:@"neverEvalute"];
    if (ret) {//永不提醒
        return;
    }else{
        if (iKnow>0) {//知道了谢谢
            NSInteger count = arc4random()%25+1;
            QQLog(@"count:%ld",count);
            if (count == iKnow) {
                [[[UIAlertView alloc]initWithTitle:nil message:@"如果您觉得app好用\n就去评个分吧" delegate:self cancelButtonTitle:nil otherButtonTitles:@"去评分",@"我知道了,谢谢",@"永不提醒",nil] show];
            }
        }else{//第一次打分
            [[[UIAlertView alloc]initWithTitle:nil message:@"如果您觉得app好用\n就去评个分吧" delegate:self cancelButtonTitle:nil otherButtonTitles:@"去评分",@"我知道了,谢谢",@"永不提醒",nil] show];
        }
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0: //去评分
        {
            NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
            [df setBool:YES forKey:@"neverEvalute"];
            [df synchronize];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:EVALUATE_URL]];
        }
            break;
        case 1://知道了谢谢
        {
            NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
            [df setInteger:5 forKey:@"iKnow"];
            [df synchronize];
        }
            break;
        case 2://永不提醒
        {
            NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
            [df setBool:YES forKey:@"neverEvalute"];
            [df synchronize];
        }
            break;
        default:
            break;
    }
}

@end
