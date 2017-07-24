//
//  UserItem.m
//  Simple_6.30
//
//  Created by 程彦博 on 2017/7/3.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import "UserItem.h"

@implementation UserItem

- (instancetype)initWithItemName:(NSString *)name{
    self = [super init];
    
    if(self){
        _name = name;
        NSUUID *uuid = [[NSUUID alloc] init];
        NSString *key = [uuid UUIDString];
        _itemKey = key;
    }
    return self;
}

#pragma mark - NSCoding
//-----------归档------------
// 将self中所有属性的名称和值加入NSCoder   提供编码方法
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.itemKey forKey:@"itemKey"];
    [aCoder encodeObject:self.thunbNail forKey:@"thunbNail"];
}

//  还原通过encodeWithCoder编码的对象，然后把对象赋给属性   提供解码方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        _name = [aDecoder decodeObjectForKey:@"name"];
        _itemKey = [aDecoder decodeObjectForKey:@"itemKey"];
        _thunbNail = [aDecoder decodeObjectForKey:@"thunbNail"];
        
        //如果不是对象而是变量类型的属性 要用decodeIntForKey
    }
    
    return self;
}
//-------------------------

-(void)setThunbNailFormImage:(UIImage *)image{
    CGSize originImageSize = image.size;
    
    CGRect newRect =CGRectMake(0,0,40,40);
    
    //根据当前屏幕scaling factor创建一个透明的位图图形上下文(此处不能直接从UIGraphicsGetCurrentContext获取,原因是UIGraphicsGetCurrentContext获取的是上下文栈的顶,在drawRect:方法里栈顶才有数据,其他地方只能获取一个nil.详情看文档)
    UIGraphicsBeginImageContextWithOptions(newRect.size,NO,0.0);
    
    //保持宽高比例,确定缩放倍数
    //(原图的宽高做分母,导致大的结果比例更小,做MAX后,ratio*原图长宽得到的值最小是40,最大则比40大,这样的好处是可以让原图在画进40*40的缩略矩形画布时,origin可以取=(缩略矩形长宽减原图长宽*ratio)/2 ,这样可以得到一个可能包含负数的origin,结合缩放的原图长宽size之后,最终原图缩小后的缩略图中央刚好可以对准缩略矩形画布中央)
    float ratio =MAX(newRect.size.width/ originImageSize.width, newRect.size.height/ originImageSize.height);
    
    //创建一个圆角的矩形UIBezierPath对象
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    
    //用Bezier对象裁剪上下文
    [path addClip];
    
    //让image在缩略图范围内居中()
    CGRect projectRect;
    projectRect.size.width= originImageSize.width* ratio;
    projectRect.size.height= originImageSize.height* ratio;
    projectRect.origin.x= (newRect.size.width- projectRect.size.width) /2;
    projectRect.origin.y= (newRect.size.height- projectRect.size.height) /2;
    
    //在上下文中画图
    [image drawInRect:projectRect];
    
    //从图形上下文获取到UIImage对象,赋值给thumbnai属性
    UIImage*smallImg =UIGraphicsGetImageFromCurrentImageContext();
    
    self.thunbNail= smallImg;
    
    //清理图形上下文(用了UIGraphicsBeginImageContext需要清理)
    UIGraphicsEndImageContext();
        
//        作者：Cocos543
//        链接：http://www.jianshu.com/p/f100c0e5f05a
//        來源：简书
//        著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
    
}

@end
