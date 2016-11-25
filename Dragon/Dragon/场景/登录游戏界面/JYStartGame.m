//
//  JYStartGame.m
//  ddd
//
//  Created by 吴冬 on 16/8/23.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYStartGame.h"
#import "JYMonsterView.h"

@interface JYStartGame ()
{
    UITextField *_nameTextField;
    UIScrollView *_selectHumScroll;
    UIButton *_selectHumBtn;
    UIButton *_continueBtn;
    UIScrollView *scrollV;
    
    
    JYSceneManager *_sceneManager;
    UIImageView    *_buttonImage;
    UILabel        *_textLabel;
    UIButton       *_confirm;
    JYMonsterView  *_monsterView;
    
    int _page;
    BOOL _save;
}
@end

@implementation JYStartGame

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self _createMonsterView];
    [self _createDialogueLabel];
    [self _createMonsterScrollView];
    [self createLogin];

    
    [JYPlayerManager selectPlayer:1];
    
//    [JYPlayerManager selectPlayer:1];
//    
    JYPlayerModel *model = [[JYPlayerModel alloc] init];
    model.name = _nameTextField.text;
    model.head = [NSString stringWithFormat:@"player%d_",1];
    model.uid  = 1;
    
    [JYPlayerManager insertData:model complete:^(BOOL com) {
        if (com) {
            NSLog(@"存储成功");
        }else{
            NSLog(@"存储失败");
        }
    }];


    //之前记录
    //JYPlayerModel *model = [JYPlayerManager selectPlayer:1];
    //赋值Model
    self.model = model;
    //初始化场景存储器
    _sceneManager = [JYSceneManager manager];
    _sceneManager.sceneDic = [NSMutableDictionary dictionary];
    //初始化主角图片
    _playerDic = [self setPlayerDic];
    
 
    SKView *skView = (SKView *)self.view;
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.ignoresSiblingOrder = YES;
    
    self.skView = skView;
    
    //设置按钮管理者
    [self setSpeed:5.0];
    _systemSpeed = 5.0;
    
    
    BeginGameScene *scene1 = [[BeginGameScene alloc] initWithSize:CGSizeMake(kScreenWidth, kScreenHeight)];
    scene1.scaleMode = SKSceneScaleModeAspectFill;
    
    
    scene1.model = self.model; //人物
    scene1.dic_player = _playerDic;
    self.scene = scene1;
    [_sceneManager.sceneDic setObject:scene1 forKey:kSence_startGame];
    
    [self.skView presentScene:scene1];
    [self _setOperationBlock:self.scene];
    
    
  
}


//怪物选择
- (void)_createMonsterView
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc ] init];
    layout.itemSize = CGSizeMake(100, 150);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    CGFloat width = 100 * 5 + 6 * 10;
    CGFloat height =  150 * 2 + 10 * 3;
    _monsterView = [[JYMonsterView alloc] initWithFrame:CGRectMake((kScreenWidth - width) / 2.0, (kScreenHeight - height) / 2.0, 100 * 5 + 6 * 10, 150 * 2 + 10 * 3) collectionViewLayout:layout];
    _monsterView.hidden = YES;
    _monsterView.layer.borderColor = [UIColor blackColor].CGColor;
    _monsterView.layer.borderWidth = 5.f;
    [self.view addSubview:_monsterView];
    
    __weak typeof (self) weekSelf = self;
    [_monsterView setSelectMonsterBlock:^(NSInteger indexPath, NSString *text) {
        
        [weekSelf changeLabel:text hidden:NO font:[UIFont systemFontOfSize:25] frame:CGRectZero];
    }];
}

//对话框
- (void)_createDialogueLabel
{
    _textLabel = [UILabel new];
    
    _textLabel.font = [UIFont systemFontOfSize:25];
    _textLabel.textColor = [UIColor grayColor];
    _textLabel.text = @"hahahaha";
    _textLabel.hidden = YES;
    _textLabel.numberOfLines = 0;
    [self.view addSubview:_textLabel];
    
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.backgroundColor = RGB_COLOR(252, 250, 214);
    _textLabel.layer.borderWidth = 3.0;
    _textLabel.layer.borderColor = [UIColor blackColor].CGColor;
    _textLabel.layer.cornerRadius = 8.0;
    _textLabel.layer.masksToBounds = YES;
    _textLabel.userInteractionEnabled = YES;
   
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20.f);
        make.height.mas_equalTo(80.f);
        make.width.mas_equalTo(360.f);
        
    }];
    
    _confirm = [UIButton new];
    _confirm.userInteractionEnabled = NO;
    //_confirm.backgroundColor = [UIColor orangeColor];
    [_confirm addTarget:self action:@selector(hiddenMonsterList) forControlEvents:UIControlEventTouchUpInside];
    [_textLabel addSubview:_confirm];
    
    [_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textLabel.mas_top);
        make.bottom.equalTo(_textLabel.mas_bottom);
        make.left.equalTo(_textLabel.mas_left);
        make.right.equalTo(_textLabel.mas_right);
    }];
    
}

//场景
- (void)_createMonsterScrollView
{
    
}

- (void)createLogin
{
    JYPlayerModel *model = [[JYPlayerModel alloc] init];
    model.name = @"haha";
    model.head = [NSString stringWithFormat:@"player%d_",1];
    model.uid  = 1;
    
    [JYPlayerManager insertData:model complete:^(BOOL com) {
        if (com) {
            NSLog(@"存储成功");
        }else{
            NSLog(@"存储失败");
        }
    }];
}



#pragma mark 游戏场景相关
//移动
- (void)move:(CGFloat)x y:(CGFloat)y type:(DirectionType)type
{
    NSString *key;
    switch (type) {
        case upOperate:
        {
            key = @"up";
        }
            break;
        case downOperate:
        {
            key = @"down";
        }
            break;
        case leftOperate:
        {
            key = @"left";
            
        }
            break;
        case rightOperate:
        {
            key = @"right";
            
        }
            break;
        default:
            break;
    }
    
//    NSLog(@"%@",key);
    if (key == NULL) {
        return;
    }
    [self.scene moveActionWithkey:key x:x y:y];
    
}

//停止
- (void)stopMove
{
    [self.scene stopMove];

}

- (void)selectUpDownLeftAndRight:(DirectionType)type
{
    
}

//确认
- (void)confirm
{
    if (!_save) {
          
        //pressnt
        [self.scene presentSceneWithPosition:CGPointMake(667 + 440, 120) scenePosition:CGPointMake(0, 0) texture:self.scene.dic_player[@"left"][0] key:kSence_monsterPastureland tra:nil];
     
        _save = YES;
    }
    
    [self.scene confirm];
}

//取消
- (void)cancel
{
    [self.scene cancel];
}

//操作回调block
- (void)_setOperationBlock:(BaseScene *)scene
{
    JYOperateManager *operateManager = [JYOperateManager manager];
    __weak typeof (self) weekSelf = self;
   
    //禁止移动
    [scene setBeginOrEndGameBlock:^(BOOL canMove) {
        [operateManager canMove:canMove];
    }];
   
    //禁止选择
    [scene setBeginOrEndOperateBlock:^(BOOL canSelect) {
        [operateManager canSelect:canSelect];
    }];
   
    //切换场景
    [scene setPresentSceneBlock:^(BaseScene *passScene,SKTransition *tra,CGPoint playerPosition,SKTexture *texture) {

        [weekSelf changeScene:passScene transition:tra position:playerPosition texture:texture];
        
     }];
  
    //show cancel Prompt
    [scene setShowCancelPrompt:^(NSString *text, BOOL isHidden,UIFont *font,CGRect frame) {
        
        [weekSelf changeLabel:text hidden:isHidden font:font frame:frame];
    }];
    
    //show confirm Prompt
    [scene setShowConfirmPrompt:^(NSString *text, BOOL isHidden, UIFont *font ,CGRect frame) {
        
        [weekSelf changeLabel:text hidden:isHidden font:font frame:frame];
    }];
    
    //show monsterList
    [scene setShowMonsterList:^{
        [weekSelf showMonsterList];
    }];
}


//显示怪物列表
- (void)showMonsterList
{
    _monsterView.hidden = NO;
}

//隐藏怪物列表
- (void)hiddenMonsterList
{
    _monsterView.hidden = YES;
    _textLabel.hidden = YES;
}

//改变Label
- (void)changeLabel:(NSString *)text hidden:(BOOL)isHidden font:(UIFont *)font frame:(CGRect )frame
{
    _textLabel.text = text;
    _textLabel.hidden = isHidden;
    _textLabel.font = font;
    
    if ([text isEqualToString:@"确定"]) {
        _confirm.userInteractionEnabled = YES;
    }else{
        _confirm.userInteractionEnabled = NO;
    }
    
    if (frame.size.width == 0) {
       
        [_textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view.mas_bottom).offset(-20.f);
            make.height.mas_equalTo(80.f);
            make.width.mas_equalTo(360.f);
            
        }];

    }else{
        [_textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view.mas_bottom).offset(-(kScreenHeight - 80 - 20));
            make.height.mas_equalTo(80.f);
            make.width.mas_equalTo(360.f);
            
        }];

    }
}


//跳转指定scene
- (void)changeScene:(BaseScene *)scene
                transition:(SKTransition *)tra
                  position:(CGPoint)playerPostion
                   texture:(SKTexture *)texture

{
    //重新设置block
    [self _setOperationBlock:scene];
  

    _scene = scene;
  
    scene.model = self.model;
    scene.dic_player = _playerDic;
    scene.playerPosition = playerPostion;
    scene.playerTexture = texture;

    
    //存储场景
    [self.skView presentScene:scene transition:tra];
    JYOperateManager *operateManager = [JYOperateManager manager];
    
    operateManager.speed = 0;
    
    [self performSelector:@selector(changeSpeed:) withObject:operateManager afterDelay:1];
}

//控制人物速度
- (void)changeSpeed:(JYOperateManager *)manager
{
    manager.speed = _systemSpeed;
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
