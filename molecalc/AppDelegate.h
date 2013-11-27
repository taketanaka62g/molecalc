//
//  AppDelegate.h
//  MoleCalc
//
//  Created by 田中 武則2 on 2013/10/10.
//  Copyright (c) 2013年 takenori tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,retain)NSString *moleText; // 分子量計算のviewからモル濃度計算のviewへ分子量を送るための変数
@property (nonatomic,retain)NSString *gram_unit;   // 単位選択viewからモル濃度計算のviewへ単位を送るための変数
@property (nonatomic,retain)NSString *litter_unit;   // 単位選択viewからモル濃度計算のviewへ単位を送るための変数
@property (nonatomic,retain)NSString *mol_unit;   // 単位選択viewからモル濃度計算のviewへ単位を送るための変数
@end
