//
//  JYRect.h
//  ddd
//
//  Created by 吴冬 on 16/8/19.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#ifndef JYRect_h
#define JYRect_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kDeviceVersion [[UIDevice currentDevice] systemVersion]


//宏定义检测BLOCK
#define BLOCK_EXEC(block,...) if(block){block(__VA_ARGS__);}

//rgb
#define RGB_COLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define kZposition_player 1000.f
#define kZposition_boder  0.f
#define kZposition_ground 1.f

#define kZposition_object 2.f

#endif /* JYRect_h */
