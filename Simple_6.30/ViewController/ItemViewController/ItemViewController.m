//
//  ItemViewController.m
//  Simple_6.30
//
//  Created by 程彦博 on 2017/7/5.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import "ItemViewController.h"
#import "UserItem.h"
#import "UserImage.h"
#import "User.h"
@interface ItemViewController ()

@property (nonatomic,weak) IBOutlet UILabel *itemName;
@property (nonatomic,weak) IBOutlet UITextField *adjTF;
@property (nonatomic,weak) IBOutlet UIButton *subButton;
@property (nonatomic,weak) IBOutlet UIImageView *imgView;
@property (nonatomic,weak) IBOutlet UIToolbar *toolBar;
@property(nonatomic,strong) UIImageView *imgViewCodebase;
@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UserItem *Item = self.item;
    
    _itemName.text = Item.name;
    [_itemName sizeToFit];
    [_itemName setTextColor:[UIColor whiteColor]];
    
//    UINavigationItem *navItem = self.navigationItem;
//    navItem.title = @"条目详情";
    
    _adjTF.returnKeyType = UIReturnKeyDone;
    _adjTF.delegate = self;
    
    [_subButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
//    UIBarButtonItem *cameraBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
//                                                                                 target:self
//                                                                                 action:@selector(takePicture:)];
//    navItem.rightBarButtonItem = cameraBarButton;
    
//---------------------------如果控件及约束由代码创建----------------------------
//    UIImageView *iv = [[UIImageView alloc] initWithImage:nil];
//
//    //设置uiimageview的缩放模式
//    iv.contentMode = UIViewContentModeScaleAspectFit;
//    //设置自动布局系统不要将自动缩放掩码转换为约束
//    iv.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:iv];
//    self.imgViewCodebase = iv;
    
//    NSDictionary *nameMap = @{@"imageView" : self.imgViewCodebase,
//                              @"submitButton" : self.subButton};
//    //imgViewCodebase的左右与父视图距离都为0
//    NSArray *horizonalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|"
//                                                                            options:0
//                                                                            metrics:nil
//                                                                              views:nameMap
//                                     ];
//    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[submitButton]-10-[imageView]-54-|"
//                                                                           options:0
//                                                                           metrics:nil
//                                                                             views:nameMap];
//    [self.view addConstraints:horizonalConstraints];
//    [self.view addConstraints:verticalConstraints];
    _imgViewCodebase.image = [UIImage imageNamed:@"WechatIMG2.jpeg"];
//----------------------------------------------------------------------------
   }

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    UserItem *Item = self.item;
    NSString *itemKey = self.item.itemKey;
    //由itemkey来寻找照片
    UIImage *imageToShow = [[UserImage sharedUser] imageForKey:itemKey];
    if(imageToShow != nil){
                _imgView.image = imageToShow;
    }
    else{
        if([Item.name isEqualToString:@"哈维·阿隆索"]){
            _imgView.image = [UIImage imageNamed:@"WechatIMG1.jpeg"];
        }
        else{
            _imgView.image = [UIImage imageNamed:@"WechatIMG2.jpeg"];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    @throw [NSException exceptionWithName:@"错误的初始化方法"
                                   reason:@"用initForNewItem"
                                 userInfo:nil];
    return nil;
}

-(instancetype)initForNewItem:(BOOL)isNew{
    self = [super initWithNibName:nil bundle:nil];
    UINavigationItem *navItem = self.navigationItem;
    if(self){
        if(isNew){
            UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                           target:self
                                           action:@selector(saveNewItem:)];
            self.navigationItem.rightBarButtonItem = doneButton;
            
            UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                       target:self
                                       action:@selector(cancelNewItem:)];
            self.navigationItem.leftBarButtonItem = cancelButton;
            
            navItem.title = @"创建新项目";
            
        }
        else{
            navItem.title = @"条目详情";
        }
    }
    return self;
}
#pragma mark - Actions

-(IBAction)doSubmit:(id)sender
{
    [_adjTF resignFirstResponder];
    UserItem *Item = self.item;
    Item.name = _adjTF.text;
    [_subButton setTitle:@"submit success!" forState:UIControlStateNormal];
    [_subButton sizeToFit];
}

-(IBAction)takePicture:(id)sender{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // If the device ahs a camera, take a picture, otherwise,
    // just pick from the photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    // Place image picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];

}

-(IBAction)saveNewItem:(id)sender{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)cancelNewItem:(id)sender{
    //按下cancel后 移除已经创建好的item
    [[User sharedUser] removeItem:self.item];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //通过info字典获取选择照片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.item setThunbNailFormImage:image];
    //以itemKey为键，将照片存入userimage
    [[UserImage sharedUser] setImage:image forKey:self.item.itemKey];
    
    //关闭uiimagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
    
    _imgView.image = image;
}

#pragma mark - UITextFieldDelegate
//键盘消除
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self changeViewUp:YES];
}
// 结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self changeViewUp:NO];
}
// 点击屏幕的时候
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 强制结束所有的编辑(也会调用对应的textFieldDidEndEditing方法)
    [self.view endEditing:YES];
}
- (void)changeViewUp:(BOOL)isUp
{
    // 开始动画(定义了动画的名字)
    [UIView beginAnimations:@"viewUp" context:nil];
    // 设置时长
    [UIView setAnimationDuration:0.2f];
    // 通过isUp来确定视图的移动方向
    int changedValue;
    if (isUp) {
        changedValue = -100;
    }else {
        changedValue = 100;
    }
    // 设置动画内容
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + changedValue, self.view.frame.size.width, self.view.frame.size.height);
    // 提交动画
    [UIView commitAnimations];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
