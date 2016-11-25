//
//  JYEnum.h
//  ddd
//
//  Created by 吴冬 on 16/8/22.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#ifndef JYEnum_h
#define JYEnum_h

typedef NS_ENUM(NSInteger ,OperateType){
    
    selectAttribute = 1000,
    moveAttribute   ,
    
};

typedef NS_ENUM(NSInteger ,DirectionType) {
    
    upOperate = 1000,
    downOperate ,
    leftOperate ,
    rightOperate,
    
};


static const uint32_t player_type = 0x1 << 0;
//static const uint32_t drawer_type = 0x1 << 1;
static const uint32_t objc_type    = 0x1 << 2;

#endif /* JYEnum_h */
