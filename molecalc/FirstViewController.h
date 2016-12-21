//
//  FirstViewController.h
//  MoleCalc
//
//  Created by 田中 武則2 on 2013/10/10.
//  Copyright (c) 2013年 takenori tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Molecule.h"
#import "UIViewController+UIViewControllerForIOS6.h"

@interface FirstViewController : UIViewController
<UIPickerViewDelegate,UITextFieldDelegate,UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;    //今回はスクロールビューにテキストフィールドを載せているので
    UITextField *activeField;    //選択されたテキストフィールドを入れる
}
@property (weak, nonatomic) IBOutlet UITextField *expressionText;
@property (weak, nonatomic) IBOutlet UIPickerView *pickupAtom;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UITextField *figureText;

- (IBAction)addExpression:(UIButton *)sender;
- (IBAction)calcExecute:(UIButton *)sender;
- (IBAction)clearExpression:(UIButton *)sender;
- (void)closeKeyboard:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *contentsView;
@property (weak, nonatomic) IBOutlet UILabel *japaneseLabel;

@end
