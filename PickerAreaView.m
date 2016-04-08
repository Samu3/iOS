//
//  PickerAreaView.m
//  doctor
//
//  Created by monday on 16/4/7.
//  Copyright © 2016年 monday. All rights reserved.
//

#import "PickerAreaView.h"
#import "HandleStringTools.h"

@interface PickerAreaView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PickerAreaView{
    NSMutableArray *_provinces;
    NSMutableArray *_cities;
    NSMutableArray *_areas;
    
    NSString *provinceString;
    
    NSString *cityString;
    
    NSString *areaString;
}

- (void)awakeFromNib{
    
    self.provinceTab.delegate = self;
    self.provinceTab.dataSource =self;
    
    self.cityTab.delegate = self;
    self.cityTab.dataSource =self;
    
    self.areTab.delegate = self;
    self.areTab.dataSource =self;
    
    
    [HandleStringTools handleLayer:self.submitBtn.layer borderWidth:0 borderColor:nil cornerRadius:5];
    [HandleStringTools handleLayer:self.cancelBtn.layer borderWidth:0 borderColor:nil cornerRadius:5];
    
    [HandleStringTools handleLayer:self.mainView.layer borderWidth:1 borderColor:GLOBAL_BLUE_COLOR cornerRadius:0];
    
    [HandleStringTools handleLayer:self.provinceTab.layer borderWidth:1 borderColor:[UIColor lightGrayColor] cornerRadius:5];
    [HandleStringTools handleLayer:self.cityTab.layer borderWidth:1 borderColor:[UIColor lightGrayColor] cornerRadius:5];
    [HandleStringTools handleLayer:self.areTab.layer borderWidth:1 borderColor:[UIColor lightGrayColor] cornerRadius:5];
    
    _provinces = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Parameter.plist" ofType:nil]];
    
//    _cities = [[_provinces objectAtIndex:0] objectForKey:@"cities"];
//    
//    _areas = [[_cities objectAtIndex:0] objectForKey:@"areas"];
    
    [_provinces insertObject:@{@"state":@"全国"} atIndex:0];

    
    _cities = [[NSMutableArray alloc]init];
    
    _areas = [[NSMutableArray alloc]init];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%f,%f,%f",self.provinceTab.frame.size.width,self.cityTab.frame.size.width,self.areTab.frame.size.width);
    
    UITouch *touch = [touches anyObject];
    
    if (self.mainView == touch.view) {
        
    }else{
        
        [self removeFromSuperview];
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (tableView == self.provinceTab) {
        
        return _provinces.count;
        
    }else if(tableView == self.cityTab){
        return _cities.count;
        
    }else{
        return _areas.count;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identify = @"cdef";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.textLabel.font = [UIFont systemFontOfSize:11];
        cell.textLabel.numberOfLines = 0;
    }
    
    if (tableView == self.provinceTab) {
        
     
            cell.textLabel.text = [_provinces[indexPath.row] objectForKey:@"state"];
        
    
      
        
    }else if(tableView == self.cityTab){
        
        
            cell.textLabel.text  = [[_cities objectAtIndex:indexPath.row] objectForKey:@"city"];
    

        
    }else{
        
            cell.textLabel.text = _areas[indexPath.row];
        

        
    }
    
  
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.provinceTab) {
        
        [_cities removeAllObjects];
        
        [_areas removeAllObjects];
         NSArray *city = [[_provinces objectAtIndex:indexPath.row] objectForKey:@"cities"];
        
        
        if (indexPath.row != 0) {
            [_cities insertObject:@{@"city":@"全省"} atIndex:0];

        }
        
        
        for (NSString *cityStr in city) {
            [_cities addObject:cityStr];
        }
        
        provinceString = [_provinces[indexPath.row] objectForKey:@"state"];
        
        self.infoLabl.text = [NSString stringWithFormat:@"%@",provinceString];


        [self.cityTab reloadData];
        [self.areTab reloadData];

    }else if(tableView == self.cityTab){
        
        [_areas removeAllObjects];

        
        NSArray *area = [[_cities objectAtIndex:indexPath.row] objectForKey:@"areas"];
        

        
        [_areas insertObject:@"全市" atIndex:0];
        
        
        for (NSString *areaCity in area) {
            [_areas addObject:areaCity];
        }
        
        cityString = [_cities[indexPath.row] objectForKey:@"city"];
        
        
        self.infoLabl.text = [NSString stringWithFormat:@"%@-%@",provinceString,cityString];

        
        
        
        [self.areTab reloadData];


        
    }else if(tableView == self.areTab){
        
        
        areaString = _areas[indexPath.row];
        
        
        self.infoLabl.text = [NSString stringWithFormat:@"%@-%@-%@",provinceString,cityString,areaString];

    }
    
    
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
