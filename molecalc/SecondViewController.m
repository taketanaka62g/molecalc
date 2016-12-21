//
//  SecondViewController.m
//  MoleCalc
//
//  Created by 田中 武則2 on 2013/10/10.
//  Copyright (c) 2013年 takenori tanaka. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"

@interface SecondViewController (UIViewControllerForIOS6)

@end

@implementation SecondViewController
Molecule *molecure_2;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    molecure_2 = [Molecule alloc];
    self.contentText.delegate = self;
    self.molecureText.delegate = self;
    self.balkText.delegate = self;
    self.concentrationText.delegate = self;
    
    UIView* accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,50)];
    accessoryView.backgroundColor = [UIColor lightGrayColor];
    
    // ボタンを作成する。
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeButton.frame = CGRectMake(210,10,100,30);
    [closeButton setTitle:@"閉じる" forState:UIControlStateNormal];
    
    // ボタンを押したときによばれる動作を設定する。
    [closeButton addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    // ボタンをViewに貼る
    [accessoryView addSubview:closeButton];
    
    self.contentText.inputAccessoryView = accessoryView;
    self.molecureText.inputAccessoryView = accessoryView;
    self.balkText.inputAccessoryView = accessoryView;
    self.concentrationText.inputAccessoryView = accessoryView;

}
-(void)keyboardWillShow:(NSNotification*)note
{
    // キーボードの表示完了時の場所と大きさを取得。
    CGRect keyboardFrameEnd = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    float screenHeight = screenBounds.size.height;
    
    if((activeField.frame.origin.y + activeField.frame.size.height)>(screenHeight - keyboardFrameEnd.size.height - 20)){
    	// テキストフィールドがキーボードで隠れるようなら
        // 選択中のテキストフィールドの直ぐ下にキーボードの上端が付くように、スクロールビューの位置を上げる
        [UIView animateWithDuration:0.3
                         animations:^{
                             scrollView.frame = CGRectMake(0, screenHeight - activeField.frame.origin.y - activeField.frame.size.height - keyboardFrameEnd.size.height - 20, scrollView.frame.size.width,scrollView.frame.size.height);
                         }];
    }
    
}
-(void)keyboardWillHide:(NSNotification*)note
{
    // キーボードの表示完了時の場所と大きさを取得。
    CGRect keyboardFrameEnd = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    float screenHeight = screenBounds.size.height;
    
    if((activeField.frame.origin.y + activeField.frame.size.height)>(screenHeight - keyboardFrameEnd.size.height - 20)){
    	// テキストフィールドがキーボードで隠れるようなら
        // 選択中のテキストフィールドの直ぐ下にキーボードの上端が付くように、スクロールビューの位置を上げる
        [UIView animateWithDuration:0.3
                         animations:^{
                             scrollView.frame = CGRectMake(0, 0, scrollView.frame.size.width,scrollView.frame.size.height);
                         }];
    }
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    // メンバ変数activeFieldに選択されたテキストフィールドを代入
    activeField = self.concentrationText;//textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // viewのy座標を元に戻してキーボードをしまう
    [UIView animateWithDuration:0.2
                     animations:^{
                         scrollView.frame = CGRectMake(0, 0, scrollView.frame.size.width,scrollView.frame.size.height);
                     }];
    
    [textField resignFirstResponder];
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    // 分子量計算のviewで設定した分子量をAppDelegateから取得する
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.molecureText.text = appDelegate.moleText;
    self.gram_unit_label.text = appDelegate.gram_unit;
    self.litter_unit_label.text = appDelegate.litter_unit;
    self.mol_unit_label.text = appDelegate.mol_unit;
    
    //キーボード表示・非表示の通知の開始
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)closeKeyboard:(id)sender{
    [self.contentText resignFirstResponder];
    [self.molecureText resignFirstResponder];
    [self.balkText resignFirstResponder];
    [self.concentrationText resignFirstResponder];
}

- (IBAction)clear:(UIButton *)sender {
    self.contentText.text = @"";
    self.balkText.text = @"";
    self.concentrationText.text = @"";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 単位の解析と計算クラスへのセット
- (void)parseUnits
{
    float g = 1;
    float l = 1;
    float m = 1;
    if ([self.gram_unit_label.text compare:@"μg"] == 0)
    {
        g = 1000000;
    }
    else if ([self.gram_unit_label.text compare:@"mg"] == 0)
    {
        g = 1000;
    }
    if ([self.litter_unit_label.text compare:@"μL"] == 0)
    {
        l = 1000000;
    }
    else if ([self.litter_unit_label.text compare:@"mL"] == 0)
    {
        l= 1000;
    }
    if ([self.mol_unit_label.text compare:@"mM"] == 0)
    {
        m = 1000;
    }
    [molecure_2 setUnitValues:g andLitter:l andMol:m];
}
// 分子量の入力終了イベントで値をAppDelegateに入れておく
- (IBAction)molecureEditEnd:(UITextField *)sender {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.moleText = self.molecureText.text;
}

- (IBAction)calcContent:(UIButton *)sender {
    NSString *mol = self.molecureText.text;
    NSString *balk = self.balkText.text;
    NSString *concentration = self.concentrationText.text;
    float value = 0;
    if (mol.length > 0) {
        [self parseUnits];  // 単位セット
        // 計算実行
        value = [molecure_2 calcContent:mol andBalk:balk andConcentration:concentration];
    }
    self.contentText.text = [NSString stringWithFormat:@"%.2f",value];
}
- (IBAction)calcBalk:(UIButton *)sender {
    NSString *mol = self.molecureText.text;
    NSString *content = self.contentText.text;
    NSString *concentration = self.concentrationText.text;
    float value = 0;
    if (mol.length > 0) {
        [self parseUnits]; // 単位セット
        // 計算実行
        value = [molecure_2 calcBalk:content andMolecure:mol andConcentration:concentration];
    }
    self.balkText.text = [NSString stringWithFormat:@"%.2f",value];
}
- (IBAction)calcConcentration:(UIButton *)sender {
    NSString *mol = self.molecureText.text;
    NSString *content = self.contentText.text;
    NSString *balk = self.balkText.text;
    float value = 0;
    if (mol.length > 0) {
        [self parseUnits]; // 単位セット
        // 計算実行
        value = [molecure_2 calcConcentration:content andMolecure:mol andBalk:balk];
    }
    self.concentrationText.text = [NSString stringWithFormat:@"%.2f",value];
}
@end
