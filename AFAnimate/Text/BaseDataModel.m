#import "BaseDataModel.h"
//#import "Reachability.h"
#import <objc/runtime.h>

BOOL isNullOrNil(id obj){
    BOOL isNull = [obj isKindOfClass:[NSNull class]];
    BOOL isNil = (obj == nil);
    if (isNull || isNil) {
        return YES;
    }else{
        return NO;
    }
}

@implementation BaseDataModel

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return self;
    }
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (NSUInteger i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        [self setValue:[decoder decodeObjectForKey:key] forKey:key];
    }
    free(properties);
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (NSUInteger i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        id value = [self valueForKey:key];
        if ([value isKindOfClass:[NSAttributedString class]]) {
            continue;//不保存NSAttributedString，因为其中可能包括UIView
        }
        if (value) {
            [coder encodeObject:value forKey:key];//不能encode nil！
        }
    }
    free(properties);
}

+ (id)sharedInstance
{
    static id _sharedInstance = nil;
    if (_sharedInstance == nil) {
        _sharedInstance = [[[self class] alloc] init];
    }
    return _sharedInstance;
}
- (id)init
{
    if (self = [super init]) {
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dict{
    [NSException raise:NSInvalidArgumentException format:@"can not directly call this method. Subclass should override this method,and call - initWithDictionary:stringPropertyKeys:numberPropertyKeys:"];
    return nil;
}

- (id)initWithDictionary:(NSDictionary*)dict stringPropertyKeys:(NSArray *)stringPropertyKeys numberPropertyKeys:(NSArray *)numberPropertyKeys
{
    self = [super init];
    if (self) {
        BOOL isDict = [dict isKindOfClass:[NSDictionary class]];
        if (isDict) {
            [self setValuesForKeysWithDictionary:dict];

            // assure string property has @""
            for (NSString *stringPropertyKey in stringPropertyKeys) {
                NSString *s = [self valueForKey:stringPropertyKey];
                if (isNullOrNil(s)) {
                    [self setValue:@"" forKey:stringPropertyKey];
                }
            }

            // assure number property has @0
            for (NSString *numberPropertyKey in numberPropertyKeys) {
                NSNumber *n = [self valueForKey:numberPropertyKey];
                if (isNullOrNil(n)) {
                    [self setValue:@0 forKey:numberPropertyKey];
                }
            }
        }
    }
    return self;
}


- (void)setValue: (id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)setNilValueForKey:(NSString *)key
{

}

-(id)copyWithZone:(NSZone *)zone
{
    return  [[self class] allocWithZone: zone];
}


- (BOOL) checkReachability{
//    Reachability *reachability = [Reachability reachabilityForInternetConnection];
//    BOOL isReachable = [reachability isReachable];
//    if (!isReachable) {
        return NO;
//    } else {
//        return YES;
//    }
}

//只适用于NSString
+ (NSString *)trimNSNull:(NSString *)s{
    if ([s isKindOfClass:[NSString class]]) {
        return s;
    } else {
        return @"";
    }
}


@end
