//
//  FirstViewController.m
//  MoleCalc
//
//  Created by 田中 武則2 on 2013/10/10.
//  Copyright (c) 2013年 takenori tanaka. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"

@interface FirstViewController (UIViewControllerForIOS6)

@end

@implementation FirstViewController
Molecule *molecure;
NSArray *arrayNameIndex;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    arrayNameIndex =
    [NSArray arrayWithObjects:@"A", @"B", @"C", @"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];

    self.pickupAtom.delegate = self;
    molecure = [Molecule alloc];
    [molecure readPListFile];
    self.expressionText.delegate = self;
    self.figureText.delegate = self;
    self.bannerView.delegate = self;

    [scrollView setContentSize:self.contentsView.bounds.size];
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
    self.expressionText.inputAccessoryView = accessoryView;
    self.figureText.inputAccessoryView = accessoryView;
    
}
- (void)viewDidUnLoad
{
    self.pickupAtom.delegate = nil;
}
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
//    float h2 = 0;
//    if ([[[[UIDevice currentDevice] systemVersion]
//          componentsSeparatedByString:@"."][0] intValue] >= 7) //iOS7
//    {
//        h2 = 0;
//    }
    // 広告を出す位置を計算する
    CGRect bannerFrame = banner.frame;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    float screenHeight = screenBounds.size.height;
    float y2 = screenHeight - self.tabBarController.tabBar.frame.size.height;
    float y3 = self.weightLabel.frame.origin.y + self.weightLabel.frame.size.height;
    bannerFrame.origin.y = y2 - bannerFrame.size.height;
    if (bannerFrame.origin.y < y3) {
        bannerFrame.origin.y = y3;
    }
    [UIView animateWithDuration:1.0 animations:^{banner.frame = bannerFrame;}];
    float y1 = banner.frame.origin.y + banner.frame.size.height;
    if (y1 > y2) {
        float hh = y1 - y2;
        [UIView animateWithDuration:0.3
                         animations:^{
                             scrollView.frame = CGRectMake(0, -hh, scrollView.frame.size.width,scrollView.frame.size.height + hh);
                         }];
        
        
    }
}
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    CGRect bannerFrame = self.bannerView.frame;
    bannerFrame.origin.y = self.view.frame.size.height;
    
        [UIView animateWithDuration:1.0 animations:^{banner.frame = bannerFrame;}];
        [UIView animateWithDuration:0.3
                         animations:^{
                             scrollView.frame = CGRectMake(0, 0, scrollView.frame.size.width,scrollView.frame.size.height);
                         }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // iAD
    
    CGRect bannerFrame = self.bannerView.frame;
    bannerFrame.origin.y = self.view.frame.size.height;
    self.bannerView.frame = bannerFrame;
}
-(void)viewWillAppear:(BOOL)animated
{
    //キーボード表示・非表示の通知の開始
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
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
    activeField = self.expressionText;//textField;
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
-(void)closeKeyboard:(id)sender{
    [self.expressionText resignFirstResponder];
    [self.figureText resignFirstResponder];
}

// 選択した元素と数量を式に追加する
- (IBAction)addExpression:(UIButton *)sender {
    NSInteger id = [self.pickupAtom selectedRowInComponent:1];
    NSString *str;
    if (id >= 0) {
        str  = [molecure getCode:id];
    }
//    NSInteger no1 = [self.pickupAtom selectedRowInComponent:1];
//    NSInteger no2 = [self.pickupAtom selectedRowInComponent:2];
//    no1 = (no1 * 10) + no2;
    if (str.length > 0) {
        NSInteger no1 = 1;
        NSString *num = self.figureText.text;
        NSString *expression = self.expressionText.text;
        if (expression == nil)
        {
            expression = @"";
        }
        if (num.length > 0)
        {
            no1 = [num integerValue];
        }
        if (no1 <= 1)
        {
            // 数量が１の時は記号のみ追加する
            self.expressionText.text  =  [ NSString stringWithFormat : @"%@%@", expression,str];
        }
        else
        {
            self.expressionText.text  =  [ NSString stringWithFormat : @"%@%@%d", expression,str, (int)no1];
        }
        // 追加したらクリアする
        self.figureText.text = @"";
    }
}

// 分子式を解析して分子量を計算して表示する
- (IBAction)calcExecute:(UIButton *)sender {
    float w = [molecure execCalc:self.expressionText.text];
    if (w >= 0)
    {
        self.weightLabel.text = [NSString stringWithFormat:@"%.2f",w];
        // モル濃度計算のviewで参照するためにAppDelegateの変数に送る
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        appDelegate.moleText = self.weightLabel.text;
    }
    else
    {
        self.weightLabel.text = @"分子式が不正です";
    }
}

// 式のクリア
- (IBAction)clearExpression:(UIButton *)sender {
    self.expressionText.text = @"";
    self.weightLabel.text = @"0.00";
    self.figureText.text = @"";
}

//区切りの数（コンポーネント）
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    // 1列目はアルファベットA-Z
    // 2列目は周期律表の記号名
    return 2;
}

//コンポーネントの行数を返す
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return 26;
            break;
        case 1:
            return [molecure getListCount];
            break;
        default:
            return 0;
            break;
    }
    return 0;
}
- (CGFloat)pickerView:(UIPickerView*)pickerView widthForComponent:(NSInteger)component
{
    CGFloat rc = 20;
    switch (component) {
        case 0:
            rc = 50;
            break;
        case 1:
            rc = 250;
            break;
        default:
            rc = 20;
            break;
    }
    return rc;
    
}

// Pickerに表示する文字列を返す
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 1)
    {
        if (row >= 0)
        {
            
            NSString *code =  [molecure getCode:row];
            NSString *jp =  [molecure getJpName:row];
            NSString *str = [NSString stringWithFormat:@"%@ (%@)",code,jp];
            return str;
        }
        else
        {
            return @"";
        }
    }
    else
    {
        return [arrayNameIndex objectAtIndex:row];
    }
}

//選択完了時に呼ばれる
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        // 1列目のアルファベットを選択したらその文字から始まる記号が表示されるように
        // 2列目の選択位置を変更する
        NSString *indexStr =[arrayNameIndex objectAtIndex:row];
        int objectIndex = [molecure getCodeIndex:indexStr];
        if (objectIndex >= 0) {
            [self.pickupAtom selectRow:objectIndex inComponent:1 animated:YES];
        }
    }
}
@end
