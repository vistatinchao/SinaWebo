//
//  ZCUserAccount.m
//  SinaWebo
//
//  Created by mac on 2016/11/18.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCUserAccount.h"

@implementation ZCUserAccount

+ (instancetype)userAccountWithDictionary:(NSDictionary *)userDict
{
    ZCUserAccount *user = [[self alloc] init];
    user.access_token = userDict[@"access_token"];
    user.uid = userDict[@"uid"];
    user.create_time = [NSDate date];
    user.expires_in = userDict[@"expires_in"];
    return user;
}
#pragma mark 解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.create_time = [aDecoder decodeObjectForKey:@"create_time"];
    }
    return self;
}
#pragma mark 归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.create_time forKey:@"create_time"];
}
@end
