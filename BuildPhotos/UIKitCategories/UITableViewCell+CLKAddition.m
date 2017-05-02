//
//  UITableViewCell+CLKAddition.m
//  CLCommonExample
//
//  Created by wangdg on 14-4-16.
//  Copyright (c) 2014年 Culiu. All rights reserved.
//

#import "UITableViewCell+CLKAddition.h"

@implementation UITableViewCell (CLKAddition)

- (UITableView *)tableView
{
    UIView *cellSuperview = self.superview;
    while (cellSuperview && [cellSuperview isKindOfClass:[UITableView class]] == NO) {
        cellSuperview = cellSuperview.superview;
    }
    return (UITableView *)cellSuperview;
}

- (NSIndexPath *)indexPath
{
    UITableView *tableView = [self tableView];
    NSIndexPath *index = [tableView indexPathForCell:self];
    return index;
}

- (void)reloadWithRowAnimation:(UITableViewRowAnimation)animation
{
    UITableView *tableView = [self tableView];
    NSIndexPath *index = [tableView indexPathForCell:self];
    [tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:animation];
}

@end
