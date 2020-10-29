//
//  AddressBookVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/3/11.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "AddressBookVC.h"
#import <AddressBook/AddressBook.h>

@interface AddressBookVC ()

@end

@implementation AddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    /*
     kABAuthorizationStatusNotDetermined 未决定
     kABAuthorizationStatusRestricted 特殊原因不能访问用户的通信录
     kABAuthorizationStatusDenied 拒绝访问
     kABAuthorizationStatusAuthorized 已经授权
     */
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取用户的授权状态
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    
    // 2.如果授权状态是授权成功
    if (status != kABAuthorizationStatusAuthorized)  return;
    
    // 3.获取通信录对象
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    // 4.获取到所有联系人记录
    CFArrayRef peopleArray = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    
    // 5.遍历所有的联系人记录
    CFIndex peopleCount = CFArrayGetCount(peopleArray);
    for (CFIndex i = 0; i < peopleCount; i++) {
        // 5.1.获取到具体的联系人
        ABRecordRef person = CFArrayGetValueAtIndex(peopleArray, i);
        
        // 5.2.获取联系人的姓名
        NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        NSString *lastName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        NSLog(@"%@---%@", firstName, lastName);
        
        // 5.3.获取联系人的电话
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        CFIndex phoneCount = ABMultiValueGetCount(phones);
        for (CFIndex i = 0; i < phoneCount; i++) {
            NSString *phoneLabel = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(phones, i);
            NSString *phoneValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phones, i);
            NSLog(@"%@---%@",phoneLabel, phoneValue);
        }
        
        // 5.4.释放该释放的对象
        CFRelease(phones);
    }
    
    // 6.释放该释放的对象
    CFRelease(addressBook);
    CFRelease(peopleArray);
}

@end
