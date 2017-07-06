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
@interface ItemViewController ()

@property (nonatomic,weak) IBOutlet UILabel *itemName;
@property (nonatomic,weak) IBOutlet UITextField *adjTF;
@property (nonatomic,weak) IBOutlet UIButton *subButton;
@property (nonatomic,weak) IBOutlet UIImageView *imgView;
@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UserItem *Item = self.item;
    
    _itemName.text = Item.name;
    [_itemName sizeToFit];
    
    UINavigationItem *navItem = self.navigationItem;
    navItem.title = @"条目详情";
    
    UIBarButtonItem *cameraBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                                 target:self
                                                                                 action:@selector(takePicture:)];
    navItem.rightBarButtonItem = cameraBarButton;
    
    //设置初始头像
//    if(Item.itemKey == nil){
//        if([Item.name isEqualToString:@"程彦博"]){
//            _imgView.image = [UIImage imageNamed:@"WechatIMG1.jpeg"];
//        }
//        else{
//            _imgView.image = [UIImage imageNamed:@"WechatIMG2.jpeg"];
//        }
//
//    }
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
        if([Item.name isEqualToString:@"程彦博"]){
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

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //通过info字典获取选择照片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //以itemKey为键，将照片存入userimage
    [[UserImage sharedUser] setImage:image forKey:self.item.itemKey];
    
    //关闭uiimagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
    
    _imgView.image = image;
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
