//
//  UITextField+JRBlock.h
//  JRKit
//
//  Created by lujianrong on 16/6/16.
//  Copyright © 2016年 lujianrong. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  学习大神代码 https://github.com/haaakon/UITextField-Blocks
 */
@interface UITextField (JRBlock)
@property (nonatomic,   copy) BOOL (^shouldBeginEditingBlock) (UITextField *textField);
@property (nonatomic,   copy) void (^didBeginEditingBlock) (UITextField *textField);
@property (nonatomic,   copy) BOOL (^shouldEndEditingBlock) (UITextField *textField);
@property (nonatomic,   copy) void (^didEndEditingBlock) (UITextField *textField);
@property (nonatomic,   copy) BOOL (^changeCharactersBlock) (UITextField *textField,NSRange range, NSString *string);
@property (nonatomic,   copy) BOOL (^shouldClearBlock) (UITextField *textField);
@property (nonatomic,   copy) BOOL (^shouldReturnBlock) (UITextField *textField);


/**
 ==========使用在外面不需要再遵循代理===========
 
 [txtField setDidEndEditingBlock:^(UITextField *textField) {
    NSLog(@"\ntextField.text--> %@", textField.text);
 }];
 
 [txtField setShouldClearBlock:^BOOL(UITextField *textField) {
    NSLog(@"\n ShouldClearBlock");
    return YES;
 }];
 */

#pragma mark
#pragma mark - 接口
- (void)setShouldBeginEditingBlock:(BOOL (^)(UITextField *textField))shouldBeginEditingBlock;
- (void)setDidBeginEditingBlock:(void (^)(UITextField *textField))didBeginEditingBlock;
- (void)setShouldEndEditingBlock:(BOOL (^)(UITextField *textField))shouldEndEditingBlock;
- (void)setDidEndEditingBlock:(void (^)(UITextField *textField))didEndEditingBlock;
- (void)setChangeCharactersBlock:(BOOL (^)(UITextField *textField,NSRange range, NSString *string))changeCharactersBlock;
- (void)setShouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock;
- (void)setShouldReturnBlock:(BOOL (^)(UITextField *textField))shouldReturnBlock;
@end

@interface UITextField (LJRAddTargetBlock)

- (void)addTargetBlock:(void (^)(UITextField *textField))block forControlEvents:(UIControlEvents)events;

@end
