#import <Foundation/Foundation.h>

//所有的子类都应该覆盖-initWithDictionary方法，并在-initWithDictionary中调用`BaseDataModel - (id)initWithDictionary:(NSDictionary*)dict stringPropertyKeys:(NSArray *)stringPropertyKeys numberPropertyKeys:(NSArray *)numberPropertyKeys;`

// 模板代码
//-(id)initWithDictionary:(NSDictionary *)dict
//{
//    NSArray *stringPropertyKeys = @[@"addon_id",
//                                    @"picture_url",
//                                    @"tag",
//                                    @"is_publish",
//                                    @"tag_type",];
//    NSArray *numberPropertyKeys = nil;
//    self = [super initWithDictionary:dict stringPropertyKeys:stringPropertyKeys numberPropertyKeys:numberPropertyKeys];
//    if (self) {
//    }
//    return self;
//}


@interface BaseDataModel : NSObject<NSCoding,NSCopying>
+ (id)sharedInstance;
- (id)initWithDictionary:(NSDictionary*)dict;
- (id)initWithDictionary:(NSDictionary*)dict stringPropertyKeys:(NSArray *)stringPropertyKeys numberPropertyKeys:(NSArray *)numberPropertyKeys;
- (BOOL)checkReachability;
+ (NSString *)trimNSNull:(NSString *)s;
@end
