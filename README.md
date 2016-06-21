# UITextField_JRBlock
把 UItextField 添加 block 并且在外边不需要遵守代理

[txtField setDidEndEditingBlock:^(UITextField *textField) {
    NSLog(@"\ntextField.text--> %@", textField.text);
 }];
 
 [txtField setShouldClearBlock:^BOOL(UITextField *textField) {
    NSLog(@"\n ShouldClearBlock");
    return YES;
 }];

