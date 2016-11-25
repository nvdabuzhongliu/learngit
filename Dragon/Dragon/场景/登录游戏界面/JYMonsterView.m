//
//  JYMonsterView.m
//  Label
//
//  Created by 吴冬 on 16/10/10.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYMonsterView.h"
#import "JYMonsterCell.h"
#define RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

static NSString *monsterIdentifier = @"monsterIdentifier";

@implementation JYMonsterView
{
    NSArray *_monsterImageArr;
    NSMutableArray *_selectMonsters;
    
    bool _flag[20];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
   
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        _monsterImageArr = @[@"史莱姆1.png",@"德拉奇.png",@"史莱姆1.png",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
        _selectMonsters = [NSMutableArray array];
        [_selectMonsters addObject:@"史莱姆1.png"];
        [_selectMonsters addObject:@"德拉奇.png"];
        [_selectMonsters addObject:@"史莱姆1.png"];

        _flag[0] = YES;
        _flag[1] = YES;
        _flag[2] = YES;
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        
        [self registerNib:[UINib nibWithNibName:@"JYMonsterCell" bundle:nil] forCellWithReuseIdentifier:monsterIdentifier];
    }
    
    return self;
}

- (void)changeImageArr:(NSArray *)monsters
{
   
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    JYMonsterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:monsterIdentifier forIndexPath:indexPath];
    
    if (_flag[indexPath.row]) {
        
        cell.backgroundColor = [UIColor colorWithRed:0.238 green:0.277 blue:1.000 alpha:1.000];
        
    }else{
        cell.backgroundColor = [UIColor clearColor];
    }
   
    cell.Status.hidden = !_flag[indexPath.row];
    cell.Pic.image = [UIImage imageNamed:_monsterImageArr[indexPath.row]];
    cell.Name.text = _monsterImageArr[indexPath.row];
    
    return cell;
}

#pragma mark dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
    return 20;
}


#pragma mark delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = _monsterImageArr[indexPath.row];

    
    if (_selectMonsters.count == 3 && _flag[indexPath.row] == NO) {
        BLOCK_EXEC(_selectMonsterBlock,indexPath.row,@"您最多只可以选择3个怪兽出战");
    }else if(_selectMonsters.count == 1 && _flag[indexPath.row] == YES){
        BLOCK_EXEC(_selectMonsterBlock,indexPath.row,@"您必须保留一直怪兽出战");
    }else{
       
        BLOCK_EXEC(_selectMonsterBlock,3,@"确定");
        _flag[indexPath.row] = !_flag[indexPath.row];
        
        if (_flag[indexPath.row]) {
            
            [_selectMonsters addObject:name];
            
        }else{
        
            int index = 0;
            for (int i = 0; i < _selectMonsters.count; i++) {
                NSString *sName = _selectMonsters[i];
                if ([sName isEqualToString:name]) {
                    index = i;
                    break;
                }
            }
            
            [_selectMonsters removeObjectAtIndex:index];
        }
       
        
        [self reloadData];
    }
    
    
    
    
    NSLog(@"%ld",indexPath.row);
}



@end
