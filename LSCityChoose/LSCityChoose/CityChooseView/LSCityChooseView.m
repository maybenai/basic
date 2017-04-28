//
//  LSCityChooseView.m
//  LSCityChoose
//
//  Created by lisonglin on 26/04/2017.
//  Copyright © 2017 lisonglin. All rights reserved.
//

#import "LSCityChooseView.h"

#define PICKERHEIGHT 216
#define BGHEIGHT     256

#define KEY_WINDOW_HEIGHT [UIApplication sharedApplication].keyWindow.frame.size.height

@interface LSCityChooseView ()<UIPickerViewDelegate,UIPickerViewDataSource>

/**
 pickerView
 */
@property(nonatomic, strong) UIPickerView * pickerView;
/**
 bgView
 */
@property(nonatomic, strong) UIView * bgView;

/**
 toolBar
 */
@property(nonatomic, strong) UIView * toolBar;

/**
 取消按钮
 */
@property(nonatomic, strong) UIButton * cancleBtn;

/**
 确定按钮
 */
@property(nonatomic, strong) UIButton * sureBtn;


/**
 省
 */
@property(nonatomic, strong) NSArray * provinceArray;

/**
 市
 */
@property(nonatomic, strong) NSArray * cityArray;

/**
 区
 */
@property(nonatomic, strong) NSArray * areaArray;
/**
 所有数据
 */
@property(nonatomic, strong) NSArray * dataSource;

/**
 记录省选中的位置
 */
@property(nonatomic, assign) NSInteger selected;

/**
 选中的省
 */
@property(nonatomic, copy) NSString * provinceStr;

/**
 选中的市
 */
@property(nonatomic, copy) NSString * cityStr;

/**
 选中的区
 */
@property(nonatomic, copy) NSString * areaStr;

@end

@implementation LSCityChooseView

#pragma mark -- lazy

- (UIButton *)cancleBtn
{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(10, 5, 50, BGHEIGHT - PICKERHEIGHT - 10);
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _cancleBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _cancleBtn.layer.borderWidth = 0.5;
        _cancleBtn.layer.cornerRadius = 5;
        _cancleBtn.backgroundColor = [UIColor orangeColor];
        [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(self.frame.size.width - 60, 5, 50, BGHEIGHT - PICKERHEIGHT - 10);
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _sureBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _sureBtn.layer.borderWidth = 0.5;
        _sureBtn.layer.cornerRadius = 5;
        _sureBtn.backgroundColor = [UIColor orangeColor];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIView *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, BGHEIGHT - PICKERHEIGHT)];
        _toolBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _toolBar;
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height , self.frame.size.width, BGHEIGHT)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, BGHEIGHT - PICKERHEIGHT, self.frame.size.width, PICKERHEIGHT)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (NSArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray = [NSArray array];
    }
    return _provinceArray;
}

- (NSArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSArray array];
    }
    return _cityArray;
}

- (NSArray *)areaArray
{
    if (!_areaArray) {
        _areaArray = [NSArray array];
    }
    return _areaArray;
}

#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.selected = 0;
        
        [self initSuViews];
        [self loadDatas];
    }
    return self;
}

#pragma mark -- 从plist里面读数据
- (void)loadDatas
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    self.dataSource = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray * tempArray = [NSMutableArray array];
    for (NSDictionary * tempDic in self.dataSource) {
        
        for (int i = 0; i < tempDic.allKeys.count; i ++) {
            [tempArray addObject:tempDic.allKeys[i]];
        }

    }
    //省
    self.provinceArray = [tempArray copy];
    //市
    self.cityArray = [self getCityNamesFromProvince:0];
    //区
    self.areaArray = [self getAreaNamesFromCity:0];
    
    self.provinceStr = self.provinceArray[0];
    self.cityStr = self.cityArray[0];
    self.areaStr = self.areaArray[0];
}

- (NSArray *)getAreaNamesFromCity:(NSInteger)row
{
    NSDictionary * tempDic = [self.dataSource[self.selected] objectForKey:self.provinceArray[self.selected]];
    NSArray * array = [NSArray array];
    
    NSDictionary * dic = tempDic.allValues[row];
    array = [dic objectForKey:self.cityArray[row]];

    return array;
}

- (NSArray *)getCityNamesFromProvince:(NSInteger)row
{
    NSDictionary * tempDic = [self.dataSource[row] objectForKey:self.provinceArray[row]];
    NSMutableArray * cityArray = [NSMutableArray array];
    for (NSDictionary * valueDic in tempDic.allValues) {
        
        for (int i = 0; i < valueDic.allKeys.count; i ++) {
            [cityArray addObject:valueDic.allKeys[i]];
        }
    }
    return [cityArray copy];
}


#pragma mark -- loadSubViews
- (void)initSuViews
{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.toolBar];
    [self.bgView addSubview:self.pickerView];
    [self.toolBar addSubview:self.cancleBtn];
    [self.toolBar addSubview:self.sureBtn];
    
    [self showPickerView];
}

#pragma mark -- showPickerView
- (void)showPickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _bgView.frame = CGRectMake(0, self.frame.size.height - BGHEIGHT, self.frame.size.width, BGHEIGHT);
    }];
}


- (void)hidePickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.frame = CGRectMake(0, self.frame.size.height , self.frame.size.width, BGHEIGHT);

        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -- UIPickerView
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.provinceArray.count;
    }else if (component == 1){
        return self.cityArray.count;
    }else if (component == 2){
        return self.areaArray.count;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 3, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        label.text = self.provinceArray[row];
    }else if (component == 1){
        label.text = self.cityArray[row];
    }else if (component == 2){
        label.text = self.areaArray[row];
    }
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {//选择省
        self.selected = row;
        self.cityArray = [self getCityNamesFromProvince:row];
        self.areaArray = [self getAreaNamesFromCity:0];
        
        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        
        self.provinceStr = self.provinceArray[row];
        self.cityStr = self.cityArray[0];
        self.areaStr = self.areaArray[0];
        
    }else if (component == 1){//选择市
        self.areaArray = [self getAreaNamesFromCity:row];
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        self.cityStr = self.cityArray[row];
        self.areaStr = self.areaArray[0];
    }else if (component == 2){//选择区
        self.areaStr = self.areaArray[row];
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


#pragma mark -- Button
- (void)cancleBtnClick
{
    [self hidePickerView];
}

- (void)sureBtnClick
{
    [self hidePickerView];

    if (self.selectedBlock != nil) {
        self.selectedBlock(self.provinceStr,self.cityStr,self.areaStr);
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self hidePickerView];
    }
}

@end
