//
//  JYOperateManager.m
//  ddd
//
//  Created by 吴冬 on 16/8/19.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYOperateManager.h"
#import "AppDelegate.h"
#import "JYOperateBtn.h"
#import "LeftBtn.h"
#import "DownBtn.h"
#import "RightBtn.h"
#import "TopBtn.h"

static JYOperateManager *manager = nil;
@implementation JYOperateManager

{
    CGFloat _btnWidth;
    CGFloat _btnHeight;
    
    JYOperateBtn *_top;
    JYOperateBtn *_down;
    JYOperateBtn *_left;
    JYOperateBtn *_right;
    
    UIButton     *_confirm;
    UIButton     *_cancel;
    
    UIButton     *_system;
    UIButton     *_blood;
    UIButton     *_article;
    
    
    UIButton     *_openSystemBtn;
    UIButton     *_closeSystemBtn;
    
    UIImageView  *_imageView; //装载系统按钮
    
    NSArray      *_openImageArr;
    NSArray      *_closeImageArr;
}

+ (JYOperateManager *)manager
{
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[JYOperateManager alloc] init];
        }
    });
    
    return manager;
}


+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [super allocWithZone:zone];
        }
    });
    
    return manager;
}


- (void)createOperateBtn
{
    _speed = 6.0;
    _operateType  = moveAttribute;
    //self.backgroundColor = [UIColor orangeColor];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:4];
    NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:4];
    for (int i = 1; i < 5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"卷轴%d",i]];
        UIImage *imageClose = [UIImage imageNamed:[NSString stringWithFormat:@"卷轴%d",5-i]];
        [arr addObject:image];
        [arr2 addObject:imageClose];
    }
    _openImageArr = arr;
    _closeImageArr = arr2;
    
    
//    CGFloat page = (kScreenWidth - (3 * 60 + 10) * 2 - 50 * 3) / 3.0;
    
    NSMutableAttributedString *AStr = [[NSMutableAttributedString alloc]initWithString:@"A" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:40],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    NSMutableAttributedString *BStr = [[NSMutableAttributedString alloc]initWithString:@"B" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:40],NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
    _imageView = [UIImageView new];
    _imageView.image = _openImageArr[3];
    _imageView.hidden = YES;
    _imageView.userInteractionEnabled = YES;
    [self addSubview:_imageView];
    
    
    _blood = [UIButton buttonWithType:UIButtonTypeCustom];
    _blood.alpha = 0;
    [_blood setImage:[UIImage imageNamed:@"血量.png"] forState:UIControlStateNormal];
    [_blood addTarget:self action:@selector(bloodAction:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:_blood];
    
    _article = [UIButton buttonWithType:UIButtonTypeCustom];
    _article.alpha = 0;
    [_article setImage:[UIImage imageNamed:@"金钱物品.png"] forState:UIControlStateNormal];
    [_article addTarget:self action:@selector(articleAction:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:_article];
    
    
    _system = [UIButton buttonWithType:UIButtonTypeCustom];
    _system.alpha = 0;
    [_system setImage:[UIImage imageNamed:@"系统设置.png"] forState:UIControlStateNormal];
    [_system addTarget:self action:@selector(systemAction:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:_system];
    
    
    //打开系统按钮
    _openSystemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_openSystemBtn setImage:[UIImage imageNamed:@"卷轴1.png"] forState:UIControlStateNormal];
    [_openSystemBtn addTarget:self action:@selector(openSystemAction:) forControlEvents:UIControlEventTouchUpInside];
    _openSystemBtn.alpha = 0.5;
    [self addSubview:_openSystemBtn];
    
    //关闭系统按钮
    _closeSystemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeSystemBtn.alpha = 0;
    [_closeSystemBtn setImage:[UIImage imageNamed:@"右按钮.png"] forState:UIControlStateNormal];
    [_closeSystemBtn addTarget:self action:@selector(closeSystemAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_closeSystemBtn];

    
    _confirm = [UIButton new];
    _confirm.backgroundColor = [UIColor blackColor];
    _confirm.alpha = 0.1;
    [_confirm addTarget:self action:@selector(_confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [_confirm setAttributedTitle:AStr forState:UIControlStateNormal];
    [self addSubview:_confirm];
    
    
    
    _cancel = [UIButton new];
    _cancel.backgroundColor = [UIColor blackColor];
    _cancel.alpha = 0.1;
    [_cancel addTarget:self action:@selector(_cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [_cancel setAttributedTitle:BStr forState:UIControlStateNormal];
    [self addSubview:_cancel];

    
    _top = [TopBtn new];
    [self addSubview:_top];
    UIImageView *topImage = [UIImageView new];
    topImage.image = [UIImage imageNamed:@"up.png"];
    [_top addSubview:topImage];
    
    _down = [DownBtn new];
    [self addSubview:_down];
    UIImageView *bottomImage = [UIImageView new];
    bottomImage.image = [UIImage imageNamed:@"down"];
    [_down addSubview:bottomImage];
    
    _left = [LeftBtn new];
    [self addSubview:_left];
    UIImageView *leftImage = [UIImageView new];
    leftImage.image = [UIImage imageNamed:@"left"];
    [_left addSubview:leftImage];

    _right = [RightBtn new];
    [self addSubview:_right];
    UIImageView *rightImage = [UIImageView new];
    rightImage.image = [UIImage imageNamed:@"right"];
    [_right addSubview:rightImage];
    
    
    _btnWidth = 50.f;
    _btnHeight = 50.f;
    
    //self.backgroundColor = [UIColor orangeColor];
    

    //7方向适配问题
    CGFloat width = kScreenWidth;
    CGFloat heigth = kScreenHeight;
    if (kScreenHeight > kScreenWidth) {
        width = kScreenHeight;
        heigth = kScreenWidth;
    }
    
    [_left mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX).offset(- width / 2.0 + 5 + _btnWidth / 2.0);
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.width.mas_equalTo(_btnWidth);
        make.height.mas_equalTo(_btnHeight);
    }];
    

    
    [_down mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX).offset(-width / 2.0 + 5 + _btnWidth + _btnWidth / 2.0);
        make.centerY.equalTo(self.mas_centerY).offset(_btnWidth );
        make.width.mas_equalTo(_btnWidth);
        make.height.mas_equalTo(_btnHeight);
        
    }];
    
    
    [_right mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX).offset(- width / 2.0 + 5 + _btnWidth + _btnWidth + _btnWidth / 2.0);
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.width.mas_equalTo(_btnWidth);
        make.height.mas_equalTo(_btnHeight);
        
    }];
    
    [_top mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX).offset(-width / 2.0 + 5 + _btnWidth + _btnWidth / 2.0);
        make.centerY.equalTo(self.mas_centerY).offset(- _btnWidth  );
        make.width.mas_equalTo(_btnWidth);
        make.height.mas_equalTo(_btnHeight);
        
    }];
    
    [_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.right.equalTo(self.mas_right).offset(-25.0);
        make.width.mas_equalTo(_btnWidth);
        make.height.mas_equalTo(_btnHeight);
        
    }];
    
    [_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.right.equalTo(_confirm.mas_left).offset(-30);
        make.width.mas_equalTo(_btnWidth);
        make.height.mas_equalTo(_btnHeight);
        
    }];
    
    [_article mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_imageView.mas_bottom).offset(-3.0);
        make.centerX.equalTo(_imageView.mas_centerX);
        
        make.width.mas_equalTo(50.f);
        make.height.mas_equalTo(50.f);
    }];
    
    
    [_blood mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_article.mas_left).offset(-7);
        make.bottom.equalTo(_imageView.mas_bottom).offset(-3.0);
        make.width.mas_equalTo(50.f);
        make.height.mas_equalTo(50.f);
    }];
    
    [_system mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_article.mas_right).offset(7);
        make.bottom.equalTo(_imageView.mas_bottom).offset(-3.0);
        make.width.mas_equalTo(50.f);
        make.height.mas_equalTo(50.f);
    }];
    
    [_openSystemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-7.5);
        make.bottom.equalTo(self.mas_bottom).offset(-4.0);
        
        make.width.mas_equalTo(186.f);
        make.height.mas_equalTo(58.f);
        
    }];
    
    
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-7.5);
        make.bottom.equalTo(self.mas_bottom).offset(-4.0);
        
        make.width.mas_equalTo(186.f);
        make.height.mas_equalTo(58.0);

    }];
    
    [_closeSystemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_imageView.mas_left).offset(-10.f - 15);
        make.centerY.equalTo(_imageView.mas_centerY);
        
        make.width.mas_equalTo(74.f);
        make.height.mas_equalTo(49.f);
    }];
    
    
    [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_left.mas_top);
        make.bottom.equalTo(_left.mas_bottom);
        make.right.equalTo(_left.mas_right);
        make.left.equalTo(_left.mas_left);
    }];
    
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_right.mas_top);
        make.bottom.equalTo(_right.mas_bottom);
        make.right.equalTo(_right.mas_right);
        make.left.equalTo(_right.mas_left);
    }];
    
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_top.mas_top);
        make.bottom.equalTo(_top.mas_bottom);
        make.right.equalTo(_top.mas_right);
        make.left.equalTo(_top.mas_left);
    }];
    
    [bottomImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_down.mas_top);
        make.bottom.equalTo(_down.mas_bottom);
        make.right.equalTo(_down.mas_right);
        make.left.equalTo(_down.mas_left);
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _confirm.layer.masksToBounds = YES;
        _confirm.layer.cornerRadius = _confirm.frame.size.width / 2.0;
        
        _cancel.layer.masksToBounds = YES;
        _cancel.layer.cornerRadius = _cancel.frame.size.width / 2.0;
    });
   
    
    _left.userInteractionEnabled = NO;
    _right.userInteractionEnabled = NO;
    _top.userInteractionEnabled = NO;
    _down.userInteractionEnabled = NO;
    
    [self _setBlock:_left];
    [self _setBlock:_right];
    [self _setBlock:_top];
    [self _setBlock:_down];
}

//设置Block
- (void)_setBlock:(JYOperateBtn *)operationBtn
{
    operationBtn.speed = _speed;
    operationBtn.operateType  = _operateType;
    
    [self _moveBlock:operationBtn];
    [self _clickBlock:operationBtn];
    [self _stopMoveBlock:operationBtn];
}


- (void)_stopMoveBlock:(JYOperateBtn *)operationBtn
{
//    __block JYOperateBtn *_weekOperationBtn = operationBtn;
//    __weak typeof(self) weekSelf = self;
//    [operationBtn setStopMoveBlock:^{
//       
//        _weekOperationBtn.alpha = _weekOperationBtn.normalAlpha;
//
//        if (weekSelf.stopMoveBlock) {
//            weekSelf.stopMoveBlock();
//        }
//    }];
}

//移动
- (void)_moveBlock:(JYOperateBtn *)operationBtn
{
    
    __block JYOperateBtn *_weekOperationBtn = operationBtn;
    __weak typeof (self) weekSelf = self;
   [operationBtn setMoveBlock:^(CGFloat x, CGFloat y ,DirectionType type) {
      
       _weekOperationBtn.alpha = _weekOperationBtn.selectAlpha;

       weekSelf.directionType = type;
       if (weekSelf.moveBlock) {
           weekSelf.moveBlock(x,y,type);
       }
   }];
    
}


//选择
- (void)_clickBlock:(JYOperateBtn *)operationBtn
{
    __weak typeof (self) weekSelf = self;
    [operationBtn setSelectBlock:^(DirectionType type) {
      
        if (weekSelf.selectBlock) {
            weekSelf.selectBlock(type);
        }
    }];
}




//确定
- (void)_confirmAction:(UIButton *)sender
{
    
    //NSLog(@"确定");
    BLOCK_EXEC(_confirmBlock);
}


//取消
- (void)_cancelAction:(UIButton *)sender
{
    //NSLog(@"取消");
    BLOCK_EXEC(_cancelBlock);
}

//设置按钮是否透明
- (void)setBtnColor:(UIColor *)btnColor
{
    if (![btnColor isEqual: btnColor]) {
        btnColor = btnColor;
        _left.backgroundColor = btnColor;
        _right.backgroundColor = btnColor;
        _top.backgroundColor = btnColor;
        _down.backgroundColor = btnColor;
        
    }
}

//设置控制属性
- (void)setType:(OperateType)type
{
    if (_operateType != type) {
        
        _operateType = type;
        
        _left.operateType = _operateType;
        _right.operateType = _operateType;
        _top.operateType = _operateType;
        _down.operateType = _operateType;
       
    }
}

//设置移动速度
- (void)setSpeed:(CGFloat)speed
{
    if (_speed != speed) {
        _speed = speed;
        
        _left.speed = speed;
        _right.speed = speed;
        _top.speed = speed;
        _down.speed = speed;
    }
}

- (void)canMove:(BOOL)canMove
{
    
   
}


- (void)canSelect:(BOOL)canSelect
{
    _confirm.userInteractionEnabled = canSelect;
    _cancel.userInteractionEnabled = canSelect;
}


/**
 *  移除定时器
 */
- (void)stopMove{
 
    /*
    switch (self.directionType) {
        case upOperate:
        {
            [_top.moveTimer invalidate];
        }
            break;
            case leftOperate:
        {
            [_left.moveTimer invalidate];
        }
            break;
            case rightOperate:
        {
            [_right.moveTimer invalidate];
        }
            break;
            case downOperate:
        {
            [_down.moveTimer invalidate];
        }
            
        default:
            break;
    }
     */
    
    [_moveTimer invalidate];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    for (UITouch *touch in touches) {
        
        CGPoint point = [touch locationInView:self];
        
        DirectionType type = 0;
        
        //left
        if (point.x > 5 && point.x < 5 + 50 && point.y > 50 + 5 && point.y < 50 + 50 + 5) {
           
            type = leftOperate;
        }
       
        //right
        else if(point.x > 5 + 50 + 50 && point.x < 5 + 50 + 50 + 50 && point.y > 50 + 5 && point.y < 50 + 50 + 5){
            

            type = rightOperate;
        }
       
        
        //top
        else if(point.x > 5 + 50 && point.x < 5 + 50 + 50 && point.y > 5 && point.y < 5 + 50){
            
            type = upOperate;
            
        }
        
        //bottom
        else if(point.x > 5 + 50 && point.x < 5 + 50 + 50 && point.y > 5 + 50 + 50 && point.y < 5 + 50 + 50 + 50){
            
            type = downOperate;
            
        }
        
        if (type != _directionType) {
            //停止行走动画
            BLOCK_EXEC(_stopMoveBlock);
            _directionType = type;
            
            [self setAlphaWithType:_directionType];
        }
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    for (UITouch *touch in touches) {
        
        CGPoint point = [touch locationInView:self];
        
        //left
        if (point.x > 5 && point.x < 5 + 50 && point.y > 50 + 5 && point.y < 50 + 50 + 5) {
            
        
            _left.alpha = _left.selectAlpha;
            _directionType = leftOperate;
            [self _createTimer];
        }
        
        //right
        else if(point.x > 5 + 50 + 50 && point.x < 5 + 50 + 50 + 50 && point.y > 50 + 5 && point.y < 50 + 50 + 5){
           
            
            _right.alpha = _right.selectAlpha;
            _directionType = rightOperate;
            [self _createTimer];
        }
        
        //top
        else if(point.x > 5 + 50 && point.x < 5 + 50 + 50 && point.y > 5 && point.y < 5 + 50){
        
            _top.alpha = _top.selectAlpha;
            _directionType = upOperate;
            [self _createTimer];
        }
       
        //bottom
        else if(point.x > 5 + 50 && point.x < 5 + 50 + 50 && point.y > 5 + 50 + 50 && point.y < 5 + 50 + 50 + 50){
        
            _down.alpha = _down.selectAlpha;
            _directionType = downOperate;
            [self _createTimer];
        }
        
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //停止走动动画
    
    [self setAlphaWithType:0];
    
    BLOCK_EXEC(_stopMoveBlock);
    [_moveTimer invalidate];
}

- (void)_createTimer
{
    //停止走动动画
    [_moveTimer invalidate];
    [self setAlphaWithType:_directionType];
    _moveTimer = [NSTimer scheduledTimerWithTimeInterval:0.015 target:self selector:@selector(move) userInfo:nil repeats:YES];
}

- (void)move
{
    CGFloat x = 0;
    CGFloat y = 0;
    
    switch (self.directionType) {
        case upOperate:
        {
            x = 0 ; y = _speed;
        }
            break;
        case downOperate:
        {
            x = 0 ; y = -_speed;
        }
            break;
        case leftOperate:
        {
            x = - _speed ; y = 0;
            
        }
            break;
        case rightOperate:
        {
            x = _speed ; y = 0;
            
        }
            break;
            
        default:
            break;
    }
    
    BLOCK_EXEC(_moveBlock,x,y,self.directionType);

}

//设置按键alpha
- (void)setAlphaWithType:(DirectionType )type
{
    _top.alpha = 1;
    _down.alpha = 1;
    _left.alpha = 1;
    _right.alpha = 1;
    
    switch (type) {
        case upOperate:
        {
            _top.alpha = _top.selectAlpha;
        }
            break;
        case downOperate:
        {
            _down.alpha = _down.selectAlpha;
        }
            break;
            case leftOperate:
        {
            _left.alpha = _left.selectAlpha;
        }
            break;
            case rightOperate:
        {
            _right.alpha = _right.selectAlpha;
        }
            break;
            
        default:
            break;
    }
}


#pragma mark 卷轴相关
- (void)closeSystemAction:(UIButton *)sender
{
    sender.alpha = 0;
    [_imageView setAnimationImages:_closeImageArr];
    [_imageView setAnimationRepeatCount:1];
    [_imageView setAnimationDuration:0.25];
    [_imageView startAnimating];
    _blood.alpha = 0;
    _article.alpha = 0;
    _system.alpha = 0;
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        
        _openSystemBtn.alpha = .5;
    }];
    
    [self performSelector:@selector(hiddenImage) withObject:nil afterDelay:0.25];
}

- (void)hiddenImage
{
    _imageView.hidden = YES;
    [_closeSystemBtn.layer removeAllAnimations];
}

//打开关闭卷轴
- (void)openSystemAction:(UIButton *)sender
{
    sender.alpha = 0;
    _imageView.hidden = NO;
    [_imageView setAnimationImages:_openImageArr];
    [_imageView setAnimationRepeatCount:1];
    [_imageView setAnimationDuration:0.25];
    [_imageView startAnimating];
    
    
    
    [UIView animateWithDuration:.5 animations:^{
        _blood.alpha = 1;
        _article.alpha = 1;
        _system.alpha = 1;
        _closeSystemBtn.alpha = 1;
    } completion:^(BOOL finished) {
        
        CGFloat x = _closeSystemBtn.layer.position.x;
        CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        moveAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(x, _closeSystemBtn.layer.position.y)];
        moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(x - 15, _closeSystemBtn.layer.position.y)];
        moveAnimation.autoreverses = YES;
        moveAnimation.repeatCount = MAXFLOAT;
        moveAnimation.duration = 0.5;
        
        [_closeSystemBtn.layer addAnimation:moveAnimation forKey:@"moveAnimation"];
        
    }];
    
    
}


//系统
- (void)systemAction:(UIButton *)sender
{
    NSLog(@"系统");
}

//血量
- (void)bloodAction:(UIButton *)sender
{
    NSLog(@"怪兽血量");
}

//物品
- (void)articleAction:(UIButton *)sender
{
    
    NSLog(@"物品");
}

@end
