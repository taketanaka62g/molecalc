//
//  UnitSelectViewController.h
//  MoleCalc
//
//  Created by 田中 武則2 on 2013/10/25.
//  Copyright (c) 2013年 takenori tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnitSelectViewController : UIViewController<UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerUnit;

- (IBAction)returnValue:(UIButton *)sender;
- (void)initPicker;
- (IBAction)cancel:(UIButton *)sender;
@end
