//
//  YMUpdateView.m
//  Daiba
//
//  Created by YouMeng on 2017/9/18.
//  Copyright © 2017年 YouMeng. All rights reserved.
//

#import "YMUpdateView.h"


///alertView  宽
#define AlertW   0.8 * kScreenWidth
///各个栏目之间的距离
#define XLSpace 20.0
#define WhiteColor      [UIColor whiteColor]

#define Font(a)        [UIFont systemFontOfSize:a]


@interface YMUpdateView ()
//弹窗
@property (nonatomic,strong) UIView *alertView;
//title
@property (nonatomic,strong) UILabel *titleLbl;

//头部的图片
@property(nonatomic,strong)UIImageView* imgView;
//内容
@property (nonatomic,strong) UILabel *msgLbl;

//确认按钮
@property (nonatomic,strong) UIButton *sureBtn;
//取消按钮
@property (nonatomic,strong) UIButton *cancleBtn;


//横线线
@property (nonatomic,strong) UIView *lineView;
//竖线
@property (nonatomic,strong) UIView *verLineView;


@end

@implementation YMUpdateView

- (instancetype)initWithTitle:(NSString *)title imgStr:(NSString* )imgStr message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle
{
    if (self == [super init]) {
        
        
        self.frame = [UIScreen mainScreen].bounds;
        //背景
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
        
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = WhiteColor;
        self.alertView.layer.cornerRadius = 10;
        
        self.alertView.frame = CGRectMake(0, 0, AlertW, 305);
        self.alertView.layer.position = self.center;
        
        //标题
        if (title) {
            self.titleLbl = [self GetAdaptiveLable:CGRectMake(2*XLSpace, 2*XLSpace, AlertW-4*XLSpace, 20) AndText:title andIsTitle:YES];
            self.titleLbl.textAlignment = NSTextAlignmentCenter;
            
            [self.alertView addSubview:self.titleLbl];
            
            CGFloat titleW = self.titleLbl.bounds.size.width;
            CGFloat titleH = self.titleLbl.bounds.size.height;
            self.titleLbl.frame = CGRectMake(15, XLSpace, titleW, titleH);
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLbl.frame) + 10, self.alertView.frame.size.width, 1)];
            view.backgroundColor = UIColorFromRGB(0xbbbbbb);
            [self.alertView addSubview:view];
            
        }
        // 头部图片
        if (imgStr) {
            UIImage* img = [UIImage imageNamed:imgStr];
            CGFloat rate = img.size.height / img.size.width;
            _imgView = [[UIImageView alloc]initWithImage:img];
            _imgView.contentMode = UIViewContentModeScaleToFill;
           // _imgView.backgroundColor = WhiteColor;
            
            //部分界面在外面
            _imgView.frame = CGRectMake(0, -30, AlertW, AlertW * rate);
            [self.alertView addSubview:_imgView];
        }
        
        if (message) {
            
            self.msgLbl = [self GetAdaptiveLable:CGRectMake(XLSpace, CGRectGetMaxY(_imgView.frame) +CGRectGetMaxY(self.titleLbl.frame)+XLSpace, AlertW - 2 * XLSpace, 20) AndText:message andIsTitle:YES];
            self.msgLbl.textAlignment = NSTextAlignmentLeft;
            self.msgLbl.textColor = RGBA(51, 51, 51, 1);
            self.msgLbl.font = Font(15);
            [self.alertView addSubview:self.msgLbl];
            
            CGFloat msgW = self.msgLbl.bounds.size.width;
            CGFloat msgH = self.msgLbl.bounds.size.height;
            
            self.msgLbl.frame = _imgView ? CGRectMake((AlertW-msgW)/2, CGRectGetMaxY(_imgView.frame)+XLSpace, msgW, msgH):CGRectMake(15, CGRectGetMaxY(_imgView.frame) +CGRectGetMaxY(self.titleLbl.frame)+XLSpace, msgW, msgH);
        }
        
        //两个按钮 添加cancleBtn
        if (cancleTitle && sureTitle) {
            
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleBtn.frame = CGRectMake(30, CGRectGetMaxY(_msgLbl.frame) + 30, (AlertW-1)/2-30, 40);
            self.cancleBtn.backgroundColor = [UIColor whiteColor];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            
            [UIUtil viewLayerWithView:_cancleBtn cornerRadius:20 boredColor:RGB(43,144,217) borderWidth:1];
            //[self.cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.cancleBtn.tag = 1;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
            
//            //增加 横竖分割线
//            self.verLineView = [[UIView alloc] init];
//            self.verLineView.frame = CGRectMake(CGRectGetMaxX(self.cancleBtn.frame), CGRectGetMaxY(self.lineView.frame), 1, 40);
//            self.verLineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
//            [self.alertView addSubview:self.verLineView];

            //添加 确定按钮
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//             CGRectMake(30, CGRectGetMaxY(_msgLbl.frame) + 30, (AlertW-1)/2-40, 40)
            self.sureBtn.frame = CGRectMake(CGRectGetMaxX(self.cancleBtn.frame)+20,  CGRectGetMaxY(_msgLbl.frame) + 30, (AlertW-1)/2-40, 40);
            [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
            [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [UIUtil viewLayerWithView:_sureBtn cornerRadius:20 boredColor:RGB(43,144,217) borderWidth:1];
            self.sureBtn.backgroundColor = RGB(43,144,217);
            self.sureBtn.tag = 2;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPaths = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayers = [[CAShapeLayer alloc] init];
            maskLayers.frame = self.sureBtn.bounds;
            maskLayers.path = maskPaths.CGPath;
            self.sureBtn.layer.mask = maskLayers;
            
            [self.alertView addSubview:self.sureBtn];
        }
        
        
        
        //只有取消按钮
        if (cancleTitle && !sureTitle) {
            
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 40);
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            //[self.cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.cancleBtn.tag = 1;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
        }
        
        //只有确定按钮
        if(sureTitle && !cancleTitle){
            
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.sureBtn.frame = CGRectMake(30, CGRectGetMaxY(_msgLbl.frame) + 30, AlertW - 30 * 2, 40);
          
            [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
          
            self.sureBtn.tag = 2;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureBtn.layer.mask = maskLayer;
            [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [UIUtil viewLayerWithView:_sureBtn cornerRadius:20 boredColor:RGB(43,144,217) borderWidth:1];
            self.sureBtn.backgroundColor = RGB(43,144,217);
            
            
            
            [self.alertView addSubview:self.sureBtn];
            
            //添加一个描述按钮
            UILabel* infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_sureBtn.frame) + 10, AlertW, 20)];
            infoLabel.text = @"87％的小伙伴已更新，你还在等什么？";
            infoLabel.font = Font(12);
            infoLabel.textColor = RGBA(153, 153, 153, 1);
            infoLabel.textAlignment = NSTextAlignmentCenter;
            [self.alertView addSubview:infoLabel];
            
        }
        
        //计算高度
        CGFloat alertHeight = cancleTitle ? CGRectGetMaxY(self.cancleBtn.frame):CGRectGetMaxY(self.sureBtn.frame);
        self.alertView.frame = CGRectMake(0, 0, AlertW, alertHeight + 40);
        self.alertView.layer.position = self.center;
        
        [self addSubview:self.alertView];
    }
    
    return self;
}

#pragma mark - 弹出 -
- (void)showXLAlertView
{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation
{
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - 回调 -设置只有2  -- > 确定才回调
- (void)buttonEvent:(UIButton *)sender
{
    if (self.resultIndex) {
        self.resultIndex(sender.tag);
    }
    if (sender.tag == 1) {
        [self removeFromSuperview];
    }
}

-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andIsTitle:(BOOL)isTitle
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.numberOfLines = 0;
    contentLbl.text = contentStr;
    contentLbl.textAlignment = NSTextAlignmentCenter;
    if (isTitle) {
        contentLbl.font = [UIFont boldSystemFontOfSize:16.0];
    }else{
        contentLbl.font = [UIFont systemFontOfSize:14.0];
    }
    
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle *mParaStyle = [[NSMutableParagraphStyle alloc] init];
    mParaStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [mParaStyle setLineSpacing:3.0];
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:mParaStyle range:NSMakeRange(0,[contentStr length])];
    [contentLbl setAttributedText:mAttrStr];
    [contentLbl sizeToFit];
    
    return contentLbl;
}

-(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
