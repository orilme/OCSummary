//
//  RuntimeExploreVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/4/7.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "RuntimeExploreVC.h"
#import "RuntimeExploreInfo+RuntimeAddProperty.h"
#import <objc/message.h>
#import "RuntimePersonModel.h"

@interface RuntimeExploreVC ()

@end

@implementation RuntimeExploreVC

+ (void)load {
    NSLog(@"RuntimeExploreVC---+ (void)load");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(runtimeReplaceViewDidLoad);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        //judge the method named  swizzledMethod is already existed.
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        // if swizzledMethod is already existed.
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)runtimeReplaceViewDidLoad {
    NSLog(@"替换的方法");
    [self runtimeReplaceViewDidLoad];
}

- (void)viewDidLoad {
    NSLog(@"自带的方法");
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self runtimeAddProperty];
    [self runtimeGetPropertyList];
    [self runtimeGetIvarList];
    [self printRuntime]; // runtime的基本用法
    [self json2Model];
}

// 给分类增加属性
- (void)runtimeAddProperty {
    RuntimeExploreInfo *test = [RuntimeExploreInfo new];
    test.phoneNum = @"12342424242";
    NSLog(@"RuntimeAddProperty---%@", test.phoneNum);
}

- (void)runtimeGetPropertyList {
    id RuntimeExploreInfo = objc_getClass("RuntimeExploreInfo");
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(RuntimeExploreInfo, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        fprintf(stdout, "runtimeGetPropertyList---%s %s\n", property_getName(property), property_getAttributes(property));
    }
}

- (void)runtimeGetIvarList {
    id RuntimeExploreInfo = objc_getClass("RuntimeExploreInfo");
    unsigned int numIvars = 0;
    Ivar *ivars = class_copyIvarList(RuntimeExploreInfo, &numIvars);
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        const char *type = ivar_getTypeEncoding(thisIvar);
        NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        if (![stringType hasPrefix:@"@"]) {
            continue;
        }
        fprintf(stdout, "runtimeGetIvarList---%s\n", ivar_getName(thisIvar));
    }
}

#pragma mark - Runtime 的基本用法

- (void)printRuntime {
    NSLog(@"runtime的基本用法==========================");
    [self printIvarList];
    [self printPropertyList];
    [self printMethodList];
}

- (void)printIvarList {
    NSLog(@"%s", __func__);
    u_int count = 0;
    // 获取所有成员变量，对于属性会自动生成_成员变量
    Ivar *ivars = class_copyIvarList([UIView class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *ivarName = ivar_getName(ivar); // runtime是用C写的。
        const char *ivarType = ivar_getTypeEncoding(ivar);
        NSString *strName = [NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
        NSString *strType = [NSString stringWithCString:ivarType encoding:NSUTF8StringEncoding];
        NSLog(@"ivarName : %@", strName);
        NSLog(@"ivarType : %@", strType);
    }
    
    Ivar _ivarMyName = class_getInstanceVariable([self class], "_myName");
    NSLog(@"_ivarMyName : %@", object_getIvar(self, _ivarMyName));
    object_setIvar(self, _ivarMyName, @"MyName");
    NSLog(@"_ivarMyName : %@", object_getIvar(self, _ivarMyName));
    
    free(ivars);
    
    NSLog(@"\n\n");
}

- (void)printPropertyList {
    NSLog(@"%s", __func__);
    u_int count = 0;
    // 获取所有属性
    objc_property_t *properties = class_copyPropertyList([UIView class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        const char *propertyAttr = property_getAttributes(property);
        NSString *strName = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSString *strAttr = [NSString stringWithCString:propertyAttr encoding:NSUTF8StringEncoding];
        NSLog(@"propertyName : %@", strName);
        NSLog(@"propertyAttr : %@", strAttr);
        
        u_int attrCount = 0;
        objc_property_attribute_t *attrs = property_copyAttributeList(property, &attrCount);
        for (int j = 0; j < attrCount; j++) {
            objc_property_attribute_t attr = attrs[j];
            const char *attrName = attr.name;
            const char *attrValue = attr.value;
            NSLog(@"attrName: %s", attrName);
            NSLog(@"attrValue: %s", attrValue);
        }
        free(attrs);
    }
    free(properties);
    
    NSLog(@"\n\n");
}

- (void)printMethodList {
    NSLog(@"%s", __func__);
    u_int count = 0;
    // 获取所有方法
    Method *methods = class_copyMethodList([UIView class], &count);
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        // 方法类型是SEL选择器类型
        SEL methodName = method_getName(method);
        NSString *str = [NSString stringWithCString:sel_getName(methodName) encoding:NSUTF8StringEncoding];
        
        int arguments = method_getNumberOfArguments(method);
        NSLog(@"methodName : %@, arguments Count: %d", str, arguments);
//
//        const char *retType = method_copyReturnType(method);
//        if (retType != "@") {
//            str = [NSString stringWithCString:retType encoding:NSUTF8StringEncoding];
//            NSLog(@"returnType : %@", str);
//        }
//
//        const char *argType = method_copyArgumentType(method, i);
//        if (argType != NULL && argType != "@") {
//            str = [NSString stringWithCString:argType encoding:NSUTF8StringEncoding];
//            NSLog(@"returnType : %@", str);
//        }
    }
    free(methods);
    
    NSLog(@"\n\n");
}

#pragma mark - 使用runtime将JSON转成Model
- (void)json2Model {
    NSLog(@"使用runtime将JSON转成Model==================");
    NSString *file = [[NSBundle mainBundle] pathForResource:@"Persons" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:file];
    NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *model in array) {
        RuntimePersonModel *person = [[RuntimePersonModel alloc] initWithNSDictionary:model];
        NSLog(@"%@, %ld, %@, %@", person.name, (long)person.age, person.city, person.job);
    }
}

@end
