//
//  UITextField+JRBlock.m
//  JRKit
//
//  Created by lujianrong on 16/6/16.
//  Copyright © 2016年 lujianrong. All rights reserved.
//


#import "UITextField+JRBlock.h"
#import <objc/runtime.h>

static const NSString *UITextFieldDelegateKey;
static const NSString *UITextFieldShouldBeginEditingBlockKey;
static const NSString *UITextFieldDidBeginEditingBlockKey;
static const NSString *UITextFieldShouldEndEditingBlockKey;
static const NSString *UITextFieldDidEndEditingBlockKey;
static const NSString *UITextFieldChangeCharactersBlockKey;
static const NSString *UITextFieldShouldClearBlockKey;
static const NSString *UITextFieldShouldReturnBlockKey;

@implementation UITextField (JRBlock)
#pragma mark
#pragma mark - Set - Delegate If No Delegate
- (void)setDelegateIfNoDelegateSet {
    if (self.delegate != (id<UITextFieldDelegate>)[self class]) {
        objc_setAssociatedObject(self, &UITextFieldDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UITextFieldDelegate>)[self class];
    }
}
#pragma mark
#pragma mark - Method -M
+ (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    BOOL (^kShouldBeginEditingBlock)() =   textField.shouldBeginEditingBlock;
    if (kShouldBeginEditingBlock) return kShouldBeginEditingBlock(textField);

    id delegate = objc_getAssociatedObject(self, &UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [delegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}
+ (void)textFieldDidBeginEditing:(UITextField *)textField {
    void (^kDidBeginEditingBlock)() =  textField.didBeginEditingBlock;
    if (kDidBeginEditingBlock)  kDidBeginEditingBlock(textField);
    
    id delegate = objc_getAssociatedObject(self, &UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}

+ (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    BOOL (^kShouldEndEditingBlock)() = textField.shouldEndEditingBlock;
    if (kShouldEndEditingBlock) return kShouldEndEditingBlock(textField);
    
    id delegate = objc_getAssociatedObject(self, &UITextFieldDelegateKey);
    if (delegate && [delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [delegate textFieldShouldEndEditing: textField];
    }
    return YES;
}

+ (void)textFieldDidEndEditing:(UITextField *)textField {
    void (^kDidEndEditingBlock)() = textField.didEndEditingBlock;
    if (kDidEndEditingBlock)  kDidEndEditingBlock(textField);
    
    id delegate = objc_getAssociatedObject(self, &UITextFieldDelegateKey);
    if (delegate && [delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [delegate textFieldDidEndEditing: textField];
    }
}

+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL (^kChangeCharactersBlock)() = textField.changeCharactersBlock;
    
    if (kChangeCharactersBlock) return kChangeCharactersBlock(textField, range, string);
    id delegate = objc_getAssociatedObject(self, &UITextFieldDelegateKey);
    if (delegate && [delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

+ (BOOL)textFieldShouldClear:(UITextField *)textField {
    BOOL (^kShouldClearBlock)() = textField.shouldClearBlock;
    if (kShouldClearBlock)  return kShouldClearBlock(textField);
    
    id delegate = objc_getAssociatedObject(self, &UITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [delegate textFieldShouldClear:textField];
    }
    return YES;
}

+ (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL (^kShouldReturnBlock)() = textField.shouldReturnBlock;
    if (kShouldReturnBlock)  return kShouldReturnBlock(textField);
    id delegate = objc_getAssociatedObject(self, &UITextFieldDelegateKey);

    if (delegate && [delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [delegate textFieldShouldReturn:textField];
    }
    return YES;
}

#pragma mark
#pragma mark - Setter & Getter -M
- (void)setShouldBeginEditingBlock:(BOOL (^)(UITextField *))shouldBeginEditingBlock {
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, &UITextFieldShouldBeginEditingBlockKey, shouldBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UITextField *))shouldBeginEditingBlock {
     return objc_getAssociatedObject(self, &UITextFieldShouldBeginEditingBlockKey);
}

- (void)setDidBeginEditingBlock:(void (^)(UITextField *))didBeginEditingBlock {
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, &UITextFieldDidBeginEditingBlockKey, didBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UITextField *))didBeginEditingBlock {
    return objc_getAssociatedObject(self, &UITextFieldDidBeginEditingBlockKey);
}

- (void)setShouldEndEditingBlock:(BOOL (^)(UITextField *))shouldEndEditingBlock {
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, &UITextFieldShouldEndEditingBlockKey, shouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UITextField *))shouldEndEditingBlock {
    return objc_getAssociatedObject(self, &UITextFieldShouldEndEditingBlockKey);
}

- (void (^)(UITextField *))didEndEditingBlock {
    return objc_getAssociatedObject(self, &UITextFieldDidEndEditingBlockKey);
}

- (void)setDidEndEditingBlock:(void (^)(UITextField *))didEndEditingBlock {
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, &UITextFieldDidEndEditingBlockKey, didEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UITextField *, NSRange, NSString *))changeCharactersBlock {
    return objc_getAssociatedObject(self, &UITextFieldChangeCharactersBlockKey);
}

- (void)setChangeCharactersBlock:(BOOL (^)(UITextField *, NSRange, NSString *))changeCharactersBlock {
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, &UITextFieldChangeCharactersBlockKey, changeCharactersBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UITextField *))shouldClearBlock {
    return objc_getAssociatedObject(self, &UITextFieldShouldClearBlockKey);
}

- (void)setShouldClearBlock:(BOOL (^)(UITextField *))shouldClearBlock {
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, &UITextFieldShouldClearBlockKey, shouldClearBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UITextField *))shouldReturnBlock {
    return objc_getAssociatedObject(self, &UITextFieldShouldReturnBlockKey);
}

- (void)setShouldReturnBlock:(BOOL (^)(UITextField *))shouldReturnBlock {
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, &UITextFieldShouldReturnBlockKey, shouldReturnBlock, OBJC_ASSOCIATION_COPY);
}
@end


@implementation UITextField (LJRAddTargetBlock)

static const NSString *UITextFieldAddTargetBlockKey;

- (void)addTargetBlock:(void (^)(UITextField *))block forControlEvents:(UIControlEvents)events {
    objc_setAssociatedObject(self, &UITextFieldAddTargetBlockKey, [block copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(_TextFieldEditingTarget:) forControlEvents:events];
}
- (void)_TextFieldEditingTarget:(UITextField *)textField {
    void (^LJRUITextFieldBlock)() = objc_getAssociatedObject(self, &UITextFieldAddTargetBlockKey);
    if (LJRUITextFieldBlock)  LJRUITextFieldBlock(textField);
}
@end
