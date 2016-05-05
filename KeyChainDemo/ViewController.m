//
//  ViewController.m
//  KeyChainDemo
//
//  Created by john on 16/5/5.
//  Copyright © 2016年 jhon. All rights reserved.
//

/**
 *  存在keychain里面可以保证密码在应用删除之后依然会被保存，
 *  同时可以作为跨应用传递数据的一种方式，因为keychain是在应用的
 *  沙盒之外的。
 *  另外，必须要说的是苹果官方的那个类是mrc的，所以需要对他手动设置一下
 *  不要用arc 编译
 *
 */

#import "ViewController.h"
#import "KeychainItemWrapper.h"

@interface ViewController ()

@property (nonatomic,strong)UITextField * nameField;
@property (nonatomic,strong)UITextField * pwdField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _nameField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, 335, 40)];
    _nameField.placeholder = @"请输入帐号";
    [self.view addSubview:_nameField];
    
    _pwdField = [[UITextField alloc]initWithFrame:CGRectMake(20, 160, 335, 40)];
    _pwdField.secureTextEntry = YES;
    _pwdField.placeholder = @"请输入密码";
    [self.view addSubview:_pwdField];
    
    KeychainItemWrapper * wrapper = [[KeychainItemWrapper alloc]initWithIdentifier:@"identifier" accessGroup:nil];
    
    NSString * name = [wrapper objectForKey:(id)kSecAttrAccount];
    NSString * pwd = [wrapper objectForKey:(id)kSecValueData];
    
    if (name && pwd) {
        _nameField.text = name;
        _pwdField.text = pwd;
//        在钥匙串中清除
//        [wrapper resetKeychainItem];
    }
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(60, 230, 375- 120, 50);
    [button addTarget:self action:@selector(setChain:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"设置" forState:UIWindowLevelNormal];
    [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)setChain:(UIButton *)sender{
    
    if ([_nameField.text isEqualToString:@""]||[_pwdField.text isEqualToString:@""]) {
        return;
    }
    
    KeychainItemWrapper * wrapper = [[KeychainItemWrapper alloc]initWithIdentifier:@"identifier" accessGroup:nil];
    
    [wrapper setObject:_nameField.text forKey:(id)kSecAttrAccount];
    [wrapper setObject:_pwdField.text forKey:(id)kSecValueData];
    
    NSLog(@"成功了！！！");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
