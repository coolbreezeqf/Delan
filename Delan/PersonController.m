//
//  PersonController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "PersonController.h"
#import "AccountManageEmergencyController.h"

@interface PersonController ()

@property (nonatomic,strong) UITableViewCell *lastCell;
@property (nonatomic,strong) AccountManageEmergencyController *am;

@end

@implementation PersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"与你的关系";
    self.lastCell = [[UITableViewCell alloc] init];
    self.am = [[AccountManageEmergencyController alloc] init];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *a = @[@"父母",@"子女",@"配偶",@"兄弟姐妹",@"同学",@"同事",@"朋友",@"其他"];
    static NSString *myId = @"myId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myId];
        cell.textLabel.text = [a objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.lastCell.accessoryView = nil;
    
    UITableViewCell * selCell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    [img setImage:[UIImage imageNamed:@"AccountManagePersonCheck"]];
    selCell.accessoryView = (UIView *)img;
    self.am.choseLabel1.placeholder = selCell.textLabel.text;
    NSLog(@"%@",selCell.textLabel.text);
    self.lastCell = selCell;
    
}

@end
