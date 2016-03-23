//
//  RetunWeek.m
//  UniQue
//
//  Created by sinmonli on 16/3/4.
//  Copyright © 2016年 longliming. All rights reserved.
//

#import "RetunWeek.h"

@implementation RetunWeek


+ (NSString*)weekdayStringFromDate:(NSString *)string {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    NSString *timeStr = string;
       [formatter setDateFormat:@"yyyy-MM/dd H:mm:ss"];
    
    NSDate *date = [formatter  dateFromString:timeStr ];//[formatter
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sta", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    return [weekdays objectAtIndex:theComponents.weekday];    
}





+ (NSString *)timeWith:(NSString *)time{

    NSLog(@"%@",time);
    
    
    NSString *str = nil;
    str = [time substringToIndex:11];
    NSLog(@"str______%@", str);
    NSArray *dateArray = [str componentsSeparatedByString:@"-"];
    NSDictionary *dataChange = @{@"01":@"Jan",  @"02":@"Feb",
                                 @"03":@"Mar",    @"04":@"Apr",
                                 @"05":@"May",      @"06":@"June",
                                 @"07":@"July",     @"08":@"Aug",
                                 @"09":@"Sep",@"10":@"Oct",
                                 @"11":@"Nov", @"12":@"Dece"};
   time = [NSString stringWithFormat:@"%@%@.%@",dateArray[2],dataChange[dateArray[1]],dateArray[0]];

    NSLog(@"%@",time);
    
    
//NSString* timeStr =time;
//
//NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//
//
//[formatter setDateStyle:NSDateFormatterMediumStyle];
//
//[formatter setTimeStyle:NSDateFormatterShortStyle];
//[formatter setDateFormat:@"yyyy-MM/dd H:mm:ss"];
//
//
//NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//设置时区
//
//[formatter setTimeZone:timeZone];
//
//
//NSDate *date = [formatter dateFromString:timeStr];//将源时间字符串转化为NSDate
//
//NSDateFormatter *toformatter = [[NSDateFormatter alloc] init];
//
//
//[toformatter setDateStyle:NSDateFormatterMediumStyle];
//
//[toformatter setTimeStyle:NSDateFormatterShortStyle];
//
//[toformatter setDateFormat:@"dd-MMM-yyyy"];//设置目标时间字符串的格式
//
//NSString *targetTime = [toformatter stringFromDate:date];//将时间转化成目标时间字符串
//
//
//NSLog(@"%@",targetTime);
//    return targetTime;
    return time;
}







@end
