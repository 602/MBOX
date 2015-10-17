//
//  EvaluateService.h
//  QQing
//
//  Created by Maceria on 15/4/13.
//
//

#import <Foundation/Foundation.h>
@interface EvaluateService : NSObject <UIAlertViewDelegate>

+ (EvaluateService *)sharedEvaluateService;

/**
 *  去评分
 */
- (void)showEvaluteAlertView;

@end
