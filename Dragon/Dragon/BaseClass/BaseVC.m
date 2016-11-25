//
//  BaseVC.m
//  ddd
//
//  Created by 吴冬 on 16/8/24.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import "BaseVC.h"
#import <objc/runtime.h>
@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];

     //创建控制者
    [self _createOperateManager];
    
   
}

- (void)loadSKView
{
    _skView = [[SKView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_skView];
    
    // Configure the view.
    SKView *skView = (SKView *)self.view;
    
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.ignoresSiblingOrder = YES;
    _skView = skView;

}



- (void)move:(CGFloat )x
           y:(CGFloat )y
        type:(DirectionType )type
{
 
    
}

- (void)selectUpDownLeftAndRight:(DirectionType )type
{

}

- (void)confirm
{
  
    
}

- (void)cancel
{

}

- (void)stopMove
{

}

- (void)setSpeed:(CGFloat)speed
{
    JYOperateManager *operateManager = [JYOperateManager manager];
    [operateManager setSpeed:speed];
}

- (void)_createOperateManager
{
 
    JYOperateManager *operateManager;
    
    if (!operateManager) {
       operateManager = [JYOperateManager manager];
        operateManager.backgroundColor = [UIColor clearColor];
        [self.view insertSubview:operateManager atIndex:10000];
        
        CGFloat width = kScreenWidth;
        if (kScreenWidth < kScreenHeight) {
            width = kScreenHeight;
        }
        
        [operateManager mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.view.mas_bottom);
            make.left.equalTo(self.view.mas_left);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(180.f);
            
        }];
        
        [operateManager createOperateBtn];
    }
   
    __weak typeof(self) weekSelf = self;
    //移动
    [operateManager setMoveBlock:^(CGFloat x, CGFloat y, DirectionType type) {
        
        [weekSelf move:x y:y type:type];
    }];
    
    //选择
    [operateManager setSelectBlock:^(DirectionType type) {
        
        [weekSelf selectUpDownLeftAndRight:type];
    }];
    
    //确定
    [operateManager setConfirmBlock:^{
        
        [weekSelf confirm];
    }];
    
    //取消
    [operateManager setCancelBlock:^{
        
        [weekSelf cancel];
    }];
    
    //停止移动
    [operateManager setStopMoveBlock:^{
        
        [weekSelf stopMove];
    }];
}

- (NSMutableDictionary *)setPlayerDic
{
    NSString *picName = [_model.head substringWithRange:NSMakeRange(0, _model.head.length - 1)];
    UIImage *image = [UIImage imageNamed:picName];
    NSMutableArray *imageArr = [JYTool image:image size:CGSizeMake(32, 32) line:4 arrange:3];
    return [JYTool images:imageArr arrange:3 line:4];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
