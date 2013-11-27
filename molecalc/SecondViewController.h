//
//  SecondViewController.h
//  MoleCalc
//
//  Created by 田中 武則2 on 2013/10/10.
//  Copyright (c) 2013年 takenori tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Molecule.h"

@interface SecondViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;    //今回はスクロールビューにテキストフィールドを載せているので
    UITextField *activeField;    //選択されたテキストフィールドを入れる
}
@property (weak, nonatomic) IBOutlet UITextField *contentText; // 含有量
@property (weak, nonatomic) IBOutlet UITextField *molecureText; // 分子量
@property (weak, nonatomic) IBOutlet UITextField *balkText; // 容量
@property (weak, nonatomic) IBOutlet UILabel *gram_unit_label;
@property (weak, nonatomic) IBOutlet UILabel *litter_unit_label;
@property (weak, nonatomic) IBOutlet UILabel *mol_unit_label;
@property (weak, nonatomic) IBOutlet UITextField *concentrationText;    // モル濃度
- (IBAction)calcContent:(UIButton *)sender;
- (IBAction)calcBalk:(UIButton *)sender;
- (IBAction)calcConcentration:(UIButton *)sender;
-(void)closeKeyboard:(id)sender;
- (IBAction)clear:(UIButton *)sender;

@end
