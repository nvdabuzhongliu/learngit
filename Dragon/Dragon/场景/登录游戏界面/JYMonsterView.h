//
//  JYMonsterView.h
//  Label
//
//  Created by 吴冬 on 16/10/10.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYMonsterView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

- (void)changeImageArr:(NSArray *)monsters;

@property (nonatomic ,copy)void (^selectMonsterBlock)(NSInteger index,NSString *text);

@end
