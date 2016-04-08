//
//  PickerAreaView.h
//  doctor
//
//  Created by monday on 16/4/7.
//  Copyright © 2016年 monday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerAreaView : UIView
@property (weak, nonatomic) IBOutlet UITableView *provinceTab;
@property (weak, nonatomic) IBOutlet UITableView *cityTab;
@property (weak, nonatomic) IBOutlet UITableView *areTab;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabl;

@end
