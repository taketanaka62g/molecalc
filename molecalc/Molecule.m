//
//  Molecule.m
//  MolCalc
//
//  Created by 田中 武則2 on 2013/10/08.
//  Copyright (c) 2013年 takenori tanaka. All rights reserved.
//

#import "Molecule.h"

@implementation Molecule
NSString *p;
NSArray *ar;

// 各値の単位
float mol = 1;
float gram = 1;
float litter = 1;

// pfileから元素リストを読む
-(void)readPListFile
{
    p = [[NSBundle mainBundle] pathForResource:@"Molecule" ofType:@"plist"];
    ar = [NSArray arrayWithContentsOfFile:p];
    
    NSSortDescriptor *sortDescString;
    sortDescString = [[NSSortDescriptor alloc] initWithKey:@"code" ascending:YES];
    
    // NSSortDescriptorは配列に入れてNSArrayに渡す
    NSArray *sortDescArray;
    sortDescArray = [NSArray arrayWithObjects:sortDescString, nil];
    
    // ソートの実行
    //NSArray *sortArray;
    ar = [ar sortedArrayUsingDescriptors:sortDescArray];
    
    /** for debug
    // NSArrayの中身を取り出す
    for(NSDictionary *d in ar){
        NSLog(@"jpName:%@", [d objectForKey:@"jpName"]);
        NSLog(@"enName:%@", [d objectForKey:@"enName"]);
        NSLog(@"code:%@", [d objectForKey:@"code"]);
        NSLog(@"weight:%@", [d objectForKey:@"weight"]);
        
    }
**/
}
// 読み込んだリストの行数を返す
- (NSInteger)getListCount
{
    return [ar count];
}
// idで指定された行のcodeを返す
- (NSString*)getCode:(NSInteger)id
{
    NSDictionary *d = [ar objectAtIndex:id];
    NSString *str  = [NSString stringWithFormat:@"%@",[d objectForKey:@"code"]];
    return str;
}
// idで指定された行の英語名を返す
- (NSString*)getEnName:(NSInteger)id
{
    NSDictionary *d = [ar objectAtIndex:id];
    NSString *str  = [NSString stringWithFormat:@"%@",[d objectForKey:@"enName"]];
    return str;
}
// idで指定された行の日本語名を返す
- (NSString*)getJpName:(NSInteger)id
{
    NSDictionary *d = [ar objectAtIndex:id];
    NSString *str  = [NSString stringWithFormat:@"%@",[d objectForKey:@"jpName"]];
    return str;
}
- (float)getWeight:(NSInteger)id
{
    float w = 0;
    if (id >= 0 && id < [ar count])
    {
        NSDictionary *d = [ar objectAtIndex:id];
        w  = [[d objectForKey:@"weight"] floatValue];
    }
    return w;
    
}
// 入力された式からコード名を取り出す
- (float)checkCode:(NSString*)argCode
{
    float rc = 0;
//    NSInteger index = [[ar valueForKey:@"code"] indexOfObject:argCode];
    for(NSDictionary *d in ar){
        NSString *code = [d objectForKey:@"code"];
        if ([code compare :argCode] == 0) {
            rc = [[d objectForKey:@"weight"] floatValue];
            break;
        };
    }
    //if (index > 0) {
    //    rc = [self getWeight:index];
    //}
    return rc;
}

// 
- (int)getCodeIndex:(NSString*)argCode;
{
    //NSInteger index = [[ar valueForKey:@"code"] indexOfObject:argCode];
    int index = -1;
    for(int i = 0;i < [ar count];i++){
        NSDictionary *d = ar[i];
        NSString *code = [d objectForKey:@"code"];
        NSRange range = [code rangeOfString:argCode];
        if (range.location != NSNotFound) {
            index = i;
            break;
            
        }
    }

    return index;
}
// コード名に続く数値を取り出す
- (NSString*)getNumber:(int)argIndex andExpression:(NSString*)argStr
{
    int i;
    int count = 0;
    NSString *str = @"";
    for (i = argIndex; i < argStr.length; i++) {
        char c0 = [argStr characterAtIndex:i];
        if (c0 >= '0' && c0 <= '9')
        {
            count++;
        }
        else
        {
            break;
        }
    }
    if (count > 0) {
        str = [argStr substringWithRange:NSMakeRange(argIndex, count)];
//        rc = str.floatValue;
    }
    return str;
}

// 入力された式から分子量を計算する
- (float)execCalc:(NSString *)expression
{
    float rc = 0;
    for (int i = 0; i < expression.length; ) {
        NSString *code1 = [expression substringWithRange:NSMakeRange(i, 1)];
        NSString *code2 = @"";
        if (i + 1 < expression.length)
        {
            code2 = [expression substringWithRange:NSMakeRange(i, 2)];
        }
        float weight = [self checkCode:code2];
        if (weight > 0) {
            // 2文字の元素記号
            i += 2;
            NSString *numStr = [self getNumber:i andExpression:expression];
            float wrc = [self subCalc:i andRc:rc andWeigth:weight andNumStr:numStr andExpression:expression];
            if (wrc >= 0) {
                rc = wrc;
            }
            else
            {
                rc = -1;
                break;
            }
            if (numStr.length > 0) {
                i += numStr.length;
            }
            /**
            NSString *numStr = [self getNumber:i andExpression:expression];
            if (numStr.length > 0) {
                float n =numStr.floatValue;
                if (n <= 0)
                {
                    rc = -1;
                    break;
                }
                rc += weight * n;
                i += numStr.length;
            }
            else
            {
                rc += weight;
            }
             **/
        }
        else
        {
            weight = [self checkCode:code1];
            if (weight > 0) {
                // 1文字の元素記号
                i++;
                NSString *numStr = [self getNumber:i andExpression:expression];
                float wrc = [self subCalc:i andRc:rc andWeigth:weight andNumStr:numStr andExpression:expression];
                if (wrc >= 0) {
                    rc = wrc;
                }
                else
                {
                    rc = -1;
                    break;
                }
                if (numStr.length > 0) {
                    i += numStr.length;
                }
                /**
                NSString *numStr = [self getNumber:i andExpression:expression];
                if (numStr.length > 0) {
                    float n =numStr.floatValue;
                    if (n <= 0)
                    {
                        rc = -1;
                        break;
                    }
                    rc += weight * n;
                    i += numStr.length;
                }
                else
                {
                    rc += weight;
                }
                 **/
            }
            else
            {
                rc = -1;
                break;
            }
        }
    }
    return rc;
}
- (float)subCalc:(int)index andRc:(float)rc andWeigth:(float)weight andNumStr:(NSString*)numStr andExpression:(NSString*)expression
{
    //
    //NSString *numStr = [self getNumber:index andExpression:expression];
    if (numStr.length > 0)
    {
        float n =numStr.floatValue;
        if (n <= 0)
        {
            rc = -1;
        }
        else
        {
            rc += weight * n;
        }
    }
    else
    {
        rc += weight;
    }
    return rc;
}
// ここから濃度計算用
// 含有量計算 含有量 ＝ モル濃度 ＊ 分子量 ＊ 容量
- (float)calcContent:(NSString*)molecure andBalk:(NSString*)balk andConcentration:(NSString*)concentration
{
    float rc = -1;
    if (molecure.length > 0 && balk.length > 0 && concentration.length > 0) {
        float c = [concentration floatValue] / mol;   // モル濃度
        float m = [molecure floatValue];        // 分子量
        float b = [balk floatValue];            // 容量
        b = b / litter;
        rc = c * m * b * gram;
    }
    return rc;
}

// 容量計算　容量＝含有量 / 分子量 / モル濃度
- (float)calcBalk:(NSString*)content andMolecure:(NSString*)molecure andConcentration:(NSString*)concentration
{
    float rc = -1;
    if (molecure.length > 0 && content.length > 0 && concentration.length > 0) {
        float conc = [concentration floatValue] / mol;    // モル濃度
        float m = [molecure floatValue];            // 分子量
        float c = [content floatValue];             // 含有量
        //rc = conc * m * c;
        rc = c / m / conc * litter;
    }
    return rc;
    
}

// モル濃度計算 モル濃度 ＝ 含有量 ／ 分子量 ／ 容量
- (float)calcConcentration:(NSString*)content andMolecure:(NSString*)molecure andBalk:(NSString*)balk
{
    float rc = -1;
    if (molecure.length > 0 && content.length > 0 && balk.length > 0) {
        float c = [content floatValue] / gram;         // 含有量
        float m = [molecure floatValue];        // 分子量
        float b = [balk floatValue];            // 容量
        rc = c / m / b * litter * mol;
    }
    return rc;
    
}

// 各値の単位を設定
- (void)setUnitValues:(float)argGram andLitter:(float)argLitter andMol:(float)argMol
{
    gram = argGram;
    mol = argMol;
    litter =argLitter;
}
@end
