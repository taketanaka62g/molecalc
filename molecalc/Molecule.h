//
//  Molecule.h
//  MolCalc
//
//  Created by 田中 武則2 on 2013/10/08.
//  Copyright (c) 2013年 takenori tanaka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Molecule : NSObject
// 分子量計算用
- (void)readPListFile;
- (NSInteger)getListCount;
- (NSString*)getCode:(NSInteger)id;
- (NSString*)getEnName:(NSInteger)id;
- (NSString*)getJpName:(NSInteger)id;
- (float)getWeight:(NSInteger)id;
- (float)checkCode:(NSString*)code;
- (int)getCodeIndex:(NSString*)code;
- (NSString*)getNumber:(int)argIndex andExpression:(NSString*)argStr;
- (float)execCalc:(NSString *)expression;
- (float)subCalc:(int)index andRc:(float)rc andWeigth:(float)weight andNumStr:(NSString*)numStr andExpression:(NSString*)expression;

// モル濃度計算用
- (float)calcContent:(NSString*)molecure andBalk:(NSString*)balk andConcentration:(NSString*)concentration;
- (float)calcBalk:(NSString*)content andMolecure:(NSString*)molecure andConcentration:(NSString*)concentration;
- (float)calcConcentration:(NSString*)content andMolecure:(NSString*)molecure andBalk:(NSString*)balk;
- (void)setUnitValues:(float)argGram andLitter:(float)argLitter andMol:(float)argMol;
@end
