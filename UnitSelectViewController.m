//
//  UnitSelectViewController.m
//  MoleCalc
//
//  Created by 田中 武則2 on 2013/10/25.
//  Copyright (c) 2013年 takenori tanaka. All rights reserved.
//

#import "UnitSelectViewController.h"
#import "AppDelegate.h"

@interface UnitSelectViewController (UIViewControllerForIOS6)

@end

@implementation UnitSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    [self initPicker];
}
- (void)initPicker
{
    // 分子量計算のviewで設定した分子量をAppDelegateから取得する
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *gram = appDelegate.gram_unit;
    NSString *litter = appDelegate.litter_unit;
    NSString *mol = appDelegate.mol_unit;
    // gram
    if ([gram isEqualToString:@"μg"])
    {
        [self.pickerUnit selectRow:0 inComponent:0 animated:NO];
    } else if ([gram isEqualToString:@"mg"])
    {
        [self.pickerUnit selectRow:1 inComponent:0 animated:NO];
    } else if ([gram isEqualToString:@"g"])
    {
        [self.pickerUnit selectRow:2 inComponent:0 animated:NO];
    }
    
    // litter
    if ([litter compare:@"μL"] == 0)
    {
        [self.pickerUnit selectRow:0 inComponent:1 animated:NO];
    } else if ([litter compare:@"mL"] == 0)
    {
        [self.pickerUnit selectRow:1 inComponent:1 animated:NO];
    } else if ([litter compare:@"L"] == 0)
    {
        [self.pickerUnit selectRow:2 inComponent:1 animated:NO];
    }
    
    // mol
    if ([mol compare:@"mM"] == 0)
    {
        [self.pickerUnit selectRow:0 inComponent:2 animated:NO];
    } else if ([mol compare:@"M"] == 0)
    {
        [self.pickerUnit selectRow:1 inComponent:2 animated:NO];
    }
    
}

- (IBAction)cancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.pickerUnit.delegate = self;
    //[self initPicker];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnValue:(UIButton *)sender {
    // モル濃度計算のviewで参照するためにAppDelegateの変数に送る
    NSString *unit = @"";
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSInteger row = [self.pickerUnit selectedRowInComponent:0];
    switch (row) {
        case 0:
            unit = @"μg";
            break;
        case 1:
            unit = @"mg";
            break;
        case 2:
            unit = @"g";
            break;
            
        default:
            break;
    }
    appDelegate.gram_unit = unit;
    
    row = [self.pickerUnit selectedRowInComponent:1];
    switch (row) {
        case 0:
            unit = @"μL";
            break;
        case 1:
            unit = @"mL";
            break;
        case 2:
            unit = @"L";
            break;
            
        default:
            break;
    }
    appDelegate.litter_unit = unit;
    row = [self.pickerUnit selectedRowInComponent:2];
    switch (row) {
        case 0:
            unit = @"mM";
            break;
        case 1:
            unit = @"M";
            break;
        default:
            break;
    }
    appDelegate.mol_unit = unit;
    [self dismissViewControllerAnimated:YES completion:nil];
}

//区切りの数（コンポーネント）
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

//コンポーネントの行数を返す
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return 3;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 2;
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
            rc = 83;
            break;
        case 1:
            rc = 83;
            break;
        case 2:
            rc = 83;
            break;
        default:
            rc = 20;
            break;
    }
    return rc;
    
}

// Pickerに表示する文字列を返す
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0)
    {
        switch (row) {
            case 0:
                return @"μg";
                break;
            case 1:
                return @"mg";
                break;
            case 2:
                return @"g";
                break;
                
            default:
                break;
        }
    }
    else if (component == 1)
    {
        switch (row) {
            case 0:
                return @"μL";
                break;
            case 1:
                return @"mL";
                break;
            case 2:
                return @"L";
                break;
                
            default:
                break;
        }
    }
    else if (component == 2)
    {
        switch (row) {
            case 0:
                return @"mM";
                break;
            case 1:
                return @"M";
                break;
            default:
                break;
        }
    }
    return @"";
}

//選択完了時に呼ばれる
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
}

@end
