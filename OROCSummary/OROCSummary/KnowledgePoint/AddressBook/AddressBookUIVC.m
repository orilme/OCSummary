//
//  AddressBookUIVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/3/11.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "AddressBookUIVC.h"
#import <AddressBookUI/AddressBookUI.h>

@interface AddressBookUIVC () <ABPeoplePickerNavigationControllerDelegate>

@end

@implementation AddressBookUIVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 1.用户联系人选择控制器ABPeoplePickerNavigationController
    ABPeoplePickerNavigationController *ppnc = [[ABPeoplePickerNavigationController alloc] init];
    
    // 2.设置代理
    ppnc.peoplePickerDelegate = self;
    
    // 2.展示控制器
    [self presentViewController:ppnc animated:YES completion:nil];
}

#pragma mark - ABPeoplePickerNavigationController的代理方法
/**
 *  选中某一个联系人的时候会调用该方法
 *
 *  @param person       选中的联系人
 */
-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person {
    // 1.获取联系人的姓名
    CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
#warning 防止内存泄漏
    /*
     __bridge NSString * : 将对象所有权给Foundation框架一份,但是本身并没有释放
     __bridge_transfer NSString * : 将对象所有权交给Foundation框架,并且自身释放掉对象
     */
    NSString *first = (__bridge_transfer NSString *)(firstName);
    NSString *last = (__bridge NSString *)(lastName);
    NSLog(@"%@----%@", first, last);
    CFRelease(lastName);
    
    // 2.获取联系人的电话号码
    ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex phoneCount = ABMultiValueGetCount(phones);
    for (CFIndex i = 0; i < phoneCount; i++) {
        NSString *phoneLabel = CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phones, i));
        NSString *phoneValue = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, i));
        NSLog(@"%@--%@", phoneLabel, phoneValue);
    }
    
    // 3.释放需要释放的对象
    CFRelease(phones);
}

/**
 *  选中某一个联系人的某一个属性的时候会调用该方法
 *
 *  @param person       选中的联系人
 *  @param property     选中的属性
 *  @param identifier   属性对应的标识
 */
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    NSLog(@"%s", __func__);
}

// 下面三个方法适配 iOS7
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
#warning 为了适配iOS7需要把iOS8 方法-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person 里面的东西抽出来此处也要调用
    NSLog(@"%s", __func__);
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    return NO;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

@end
