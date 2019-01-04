//
//  CreateViewController.m
//  IDNoCreater
//
//  Created by zhuang chaoxiao on 2019/1/4.
//  Copyright © 2019年 zhuang chaoxiao. All rights reserved.
//

#import "CreateViewController.h"
#import "CreateTableViewCell.h"

@interface CreateViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *provLab;
@property (strong, nonatomic) IBOutlet UILabel *cityLab;
@property (strong, nonatomic) IBOutlet UILabel *areaLab;
@property (strong, nonatomic) IBOutlet UILabel *birLab;
@property (strong, nonatomic) IBOutlet UILabel *sexLab;
@property (strong, nonatomic) IBOutlet UILabel *countLab;



@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.rowHeight = 50;
    
    [self addGesture];
}

#pragma private
-(void)addGesture
{
    UITapGestureRecognizer * g = nil;
    
    g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(porvClicked)];
    self.provLab.userInteractionEnabled = YES;
    [self.provLab addGestureRecognizer:g];
    
    //
    g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cityClicked)];
    self.cityLab.userInteractionEnabled = YES;
    [self.cityLab addGestureRecognizer:g];
    
    //
    g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(areaClicked)];
    self.areaLab.userInteractionEnabled = YES;
    [self.areaLab addGestureRecognizer:g];
    
    //
    g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(birClicked)];
    self.birLab.userInteractionEnabled = YES;
    [self.birLab addGestureRecognizer:g];
    
    //
    g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(countClicked)];
    self.countLab.userInteractionEnabled = YES;
    [self.countLab addGestureRecognizer:g];
}


#pragma event
-(void)porvClicked
{
    
}

-(void)cityClicked
{
    
}

-(void)areaClicked
{
    
}

-(void)birClicked
{
    
}

-(void)countClicked
{
    
}

#pragma UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreateTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CreateTableViewCell"];
    if( !cell )
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CreateTableViewCell" owner:self
                                           options:    nil] lastObject];
    }
    
    return cell;
}



@end
