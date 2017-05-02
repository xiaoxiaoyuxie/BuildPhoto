//
//  UITableViewCell+CLKAddition.h
//  CLCommonExample
//
//  Created by wangdg on 14-4-16.
//  Copyright (c) 2014年 Culiu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UITableViewCell (CLKAddition)

- (UITableView *)tableView;
- (NSIndexPath *)indexPath;
- (void)reloadWithRowAnimation:(UITableViewRowAnimation)animation;

@end
