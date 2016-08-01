//
//  MulChooseView.m
//  ChooseDemo
//
//  Created by lisonglin on 16/7/26.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "MulChooseView.h"
#import "CollectionViewChooseCell.h"
#import "HeaderView.h"
#define ItemHeight 70
#define HeaderHeight 50
static NSString *CellId = @"CellId";
static NSString *HeaderId = @"HeaderId";

@interface MulChooseView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView * chooseView;

@property(nonatomic, strong) UICollectionReusableView * reuseableView;

@property(nonatomic, strong) NSMutableArray * choosedArr;

@property(nonatomic, assign,getter=allSelected) BOOL ifAllSelected;

@property(nonatomic, assign,getter=allSelectSwitch) BOOL ifAllSelectSwitch;

@end

@implementation MulChooseView


+ (instancetype)mulChooseViewWithFrame:(CGRect)frame headerTitle:(NSString *)title
{
    MulChooseView * chooseView = [[MulChooseView alloc] initWithFrame:frame ifHave:YES title:title];
    return chooseView;
}

+ (instancetype)mulChooseViewWithFrame:(CGRect)frame
{
    MulChooseView * chooseView = [[MulChooseView alloc] initWithFrame:frame];
    return chooseView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame ifHave:(BOOL)have title:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    _choosedArr = [[NSMutableArray alloc]initWithCapacity:0];
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    self.chooseView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) collectionViewLayout:flowLayout];
    self.chooseView.backgroundColor = ColorRGB(0xf7f7f7);
    [self.chooseView registerClass:[CollectionViewChooseCell class] forCellWithReuseIdentifier:CellId];
    [self.chooseView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:HeaderId];
    self.chooseView.showsVerticalScrollIndicator = NO;
    self.chooseView.scrollEnabled = YES;
    self.chooseView.delegate = self;
    self.chooseView.dataSource = self;
    [self addSubview:self.chooseView];
}



#pragma mark  CollectionViewDelegate--=========================================
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        if (self.reuseableView == nil) {
            self.reuseableView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderId forIndexPath:indexPath];
            self.reuseableView.backgroundColor = [UIColor whiteColor];
            UILabel * headerTitleLabel = [[UILabel alloc] init];
            headerTitleLabel.text = @"全选";
            [self.reuseableView addSubview:headerTitleLabel];
            [headerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.reuseableView.mas_left).offset(15);
                make.top.equalTo(self.reuseableView.mas_top).offset(0);
                make.height.mas_equalTo(self.reuseableView.mas_height);
            }];
            
            UIButton * chooseIcon = [UIButton buttonWithType:UIButtonTypeCustom];
            chooseIcon.tag = 10;
            [chooseIcon setImage:[UIImage imageNamed:@"table_UnSelect"] forState:UIControlStateNormal];
            [chooseIcon setImage:[UIImage imageNamed:@"table_Selected"] forState:UIControlStateSelected];
            chooseIcon.userInteractionEnabled = NO;
            [self.reuseableView addSubview:chooseIcon];
            
            [chooseIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(headerTitleLabel.mas_right).offset(10);
                make.right.equalTo(self.reuseableView.mas_right).offset(-15);
                make.top.equalTo(self.reuseableView.mas_top);
                make.height.mas_equalTo(self.reuseableView.mas_height);
                make.width.mas_equalTo(50);
            }];
            
            UIButton * chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            chooseBtn.frame = CGRectMake(0, 0, self.reuseableView.frame.size.width, self.reuseableView.frame.size.height);
            [chooseBtn addTarget:self action:@selector(chooseAllClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.reuseableView addSubview:chooseBtn];
            
        }
    }
    
    return self.reuseableView;
}

- (void)chooseAllClick:(UIButton *)button
{
    self.ifAllSelectSwitch = YES;
    
    UIButton * chooseIcon = (UIButton *)[self.reuseableView viewWithTag:10];

    chooseIcon.selected = !_ifAllSelected;
    
    _ifAllSelected = !_ifAllSelected;
    
    if (self.allSelected) {
        [self.choosedArr removeAllObjects];
        [self.choosedArr addObjectsFromArray:self.dataArr];
    }else{
        [self.choosedArr removeAllObjects];
    }
    
    [self.chooseView reloadData];
    
    _block(@"all",self.choosedArr);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, HeaderHeight);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH / 3, ItemHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * reuseIndentify = CellId;
    CollectionViewChooseCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIndentify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.titleLab.text = self.dataArr[indexPath.row];
    
    if (self.allSelectSwitch) {
        [cell UpdateCellWithState:self.allSelected];
        
        if (indexPath.row == self.dataArr.count - 1) {
            self.ifAllSelectSwitch = NO;
        }
    }
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewChooseCell * cell = (CollectionViewChooseCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [cell UpdateCellWithState:!cell.isSelected];
    if (cell.isSelected) {
        [self.choosedArr addObject:cell.titleLab.text];
    }else{
        [self.choosedArr removeObject:cell.titleLab.text];
    }
    
    if (self.choosedArr.count < self.dataArr.count) {
        self.ifAllSelected = NO;
        UIButton * btn = (UIButton *)[self.reuseableView viewWithTag:10];
        btn.selected = self.allSelected;
    }
    if (_choosedArr.count == _dataArr.count) {
        _ifAllSelectSwitch = YES;
        UIButton * chooseIcon = (UIButton *)[self.reuseableView viewWithTag:10];
        [chooseIcon setSelected:!_ifAllSelected];
        _ifAllSelected = !_ifAllSelected;
        if (_ifAllSelected) {
            [_choosedArr removeAllObjects];
            [_choosedArr addObjectsFromArray:_dataArr];
        }
    }
    
    _block(cell.titleLab.text,self.choosedArr);
}

- (void)ReloadData
{
    [self.chooseView reloadData];
}



@end
