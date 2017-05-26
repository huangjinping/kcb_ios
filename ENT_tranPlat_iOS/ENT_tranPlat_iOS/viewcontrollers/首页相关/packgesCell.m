//
//  packgesCell.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/8/26.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "packgesCell.h"
#import "BaoYangModel.h"
#import "BaoYangServiewModel.h"



@implementation packgesCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code]]
        
        //服务名称---之所以写这里是因为传值先后问题会导致值为空
        UILabel *serviceName = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, APP_WIDTH*2/3, 40)];
        [self.contentView addSubview:serviceName];
        [serviceName convertNewLabelWithFont:FONT_NOMAL textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
        _nameLabel = serviceName;
        
        //switch
        UISwitch *swi = [[UISwitch alloc]init];
        //    [swi setOn:YES];
        [self.contentView addSubview:swi];
        _switchChoes = swi;
        _switchChoes.frame = CGRectMake(APP_WIDTH-swi.frame.size.width-10, 10, 0, 0);
        
        //分割线
        _lineL = [UILabel lineLabelWithPoint:CGPointMake(20, CGRectGetMaxY(_nameLabel.frame)+10)];
        [self addSubview:_lineL];
        
        [self createSubView];
        
    }
    return self;
}


//创建子视图
-(void)createSubView
{
    
    //小表
    UITableView * downTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_lineL.frame)+5, APP_WIDTH, _H) style:UITableViewStylePlain];
    [self.contentView addSubview:downTabView];
    downTabView.separatorStyle = UITableViewCellEditingStyleNone;
    downTabView.scrollEnabled = NO;
    downTabView.delegate = self;
    downTabView.dataSource = self;
    
    _downTabView = downTabView;
    //灰色view分割
    self.backgroundColor = [UIColor whiteColor];
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(_downTabView.frame)+_H, APP_WIDTH, 10)];
    _view.backgroundColor = COLOR_FRAME_LINE;
    [self.contentView addSubview:_view];
    
}



//建小表
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"smallCell";
    BaoYangServiewModel *model = _datas[indexPath.row];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //cell不为空时,走这个里面,刷表不走这个
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        //取消cell的点击事件(动画)
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
//    for (UIView *ve in cell.subviews) {
//        [ve removeFromSuperview];
//    }
    //单选框
    UIButton *chooesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cell addSubview:chooesBtn];
    [chooesBtn setImage:[UIImage imageNamed:@"btn_unchecked"] forState:UIControlStateNormal];
    [chooesBtn setImage:[UIImage imageNamed:@"btn_checked"] forState:UIControlStateSelected];
    [chooesBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside
     ];
    chooesBtn.tag = indexPath.row;
    //当isdelete为YES时,就是选中状态,否则为未选中状态
    if(model.isdelete == YES)
    {
        chooesBtn.selected = YES;
        
        
    }else if (model.isdelete == NO)
    {
        chooesBtn.selected = NO;
    }
    //判断显示的数据大于1个的 就要显示复选框
    if(self.datas.count > 1)
    {
        chooesBtn.frame = CGRectMake(5, 10, 20, 20);
        [cell addSubview:chooesBtn];
        
    }
    //服务名称
    UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(chooesBtn.frame)+5, 0, APP_WIDTH-80, 40)];
    nameL.numberOfLines = 2;
    [cell addSubview:nameL];
    nameL.text = model.name;
    [nameL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    //价格
    UILabel *priceL = [[UILabel alloc]init];
    [cell addSubview:priceL];
    priceL.text = [NSString stringWithFormat:@"%@元",model.price];
    priceL.frame = CGRectMake(APP_WIDTH - 80-10, 0, 80, 40);
    [priceL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_NAV textAlignment:NSTextAlignmentRight];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(void)buttonClicked:(UIButton *)button
{
    //遍历整个数组,将所有的isdelete 设置成为NO,当点击的按钮的tag值等于 i 值时,就改成YES
    for (int i = 0; i < _datas.count; i++)
    {
        BaoYangServiewModel *oldModel = _datas[i];
        oldModel.isdelete = NO;
        if(i == button.tag)
        {
            oldModel.isdelete = YES;
        }
    }
    [_downTabView reloadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CalculationPriceNOTI" object:nil];
    
}
-(void)setModel:(BaoYangModel *)model
{
    _model = model;
    _nameLabel.text = model.packagename;
    _datas = model.serviceItemList;
    //小表高度
    _H =  self.datas.count * 40;

    [self createSubView];
    [_downTabView reloadData];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
