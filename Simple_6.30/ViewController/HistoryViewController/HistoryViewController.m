//
//  HistoryViewController.m
//  Simple_6.30
//
//  Created by 程彦博 on 2017/7/1.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,weak) IBOutlet UIView *headView;
@property (nonatomic, weak) IBOutlet UIButton *editButton;
@property (nonatomic, weak) IBOutlet UIButton *addButton;
@property(nonatomic,strong) UIBarButtonItem *editBarButton;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    //将header加入到tableview
//    [_tableView setTableHeaderView:self.headView];

    [self.view addSubview:_tableView];
    //创建UIBarButtonItem对象，将目标设置为当前对象，将动作方法设置为newItem，再将addbutton赋为navigationItem的右按钮
    UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(newItem:)];
    self.navigationItem.rightBarButtonItem = addBarButton;
    //对于编辑按钮，苹果已经写好了editButtonItem。 然而并用不了...
    _editBarButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit"
                                                     style:UIBarButtonItemStylePlain
                                                    target:self
                                                    action:@selector(editItem:)];
    self.navigationItem.leftBarButtonItem = _editBarButton;
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //注册cell
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"noMore"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)headView{
    //如果还未载入
    if(!_headView){
        [[NSBundle mainBundle] loadNibNamed:@"HistoryHeader"
                                      owner:self
                                    options:nil];
    }
    return _headView;
}

- (IBAction)newItem:(id)sender{
    UserItem *newItem = [[User sharedUser] creatItem:@"临时数据"];
    NSInteger lastRow = [[[User sharedUser] allItems] indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [_tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

//- (IBAction)editItem:(id)sender{
//    if(_tableView.isEditing){
//        [sender setTitle:@"Edit" forState:UIControlStateNormal];
//        [_tableView setEditing:NO animated:YES];
//        _addButton.enabled = YES;
//    }
//    else{
//        [sender setTitle:@"Done" forState:UIControlStateNormal];
//        [_tableView setEditing:YES animated:YES];
//        _addButton.enabled = NO;
//    }
//}
- (IBAction)editItem:(id)sender{
    if(_tableView.isEditing){
        [_editBarButton setTitle:@"Edit"];
        [_tableView setEditing:NO animated:YES];
    }
    else{
        [_editBarButton setTitle:@"Done"];
        [_tableView setEditing:YES animated:YES];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return [[[User sharedUser] allItems] count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//     indexPath 保存section 和 row ,dequeueReusableCellWithIdentifier: forIndexPath: 通过indexpath 确定所加的cell的具体位置
//     有forIndexPath 的重用cell方法必须和 registerClass:forCellReuseIdentifier: 组合使用，此方法总是返回一个cell，不会为nil
//    对于不用forIndexPath的 用以下代码替代
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
//    if(!cell){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
//    }
    UITableViewCell *cell;
    NSArray *items = [[User sharedUser] allItems];
    if(indexPath.row < [[[User sharedUser] allItems] count]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        UserItem *item = items[indexPath.row];
        cell.textLabel.text = item.name;
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"noMore" forIndexPath:indexPath];
        cell.textLabel.text = @"no more";
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;//文字居中
    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //如果tableview 请求确认删除操作
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if(indexPath.row < [[[User sharedUser] allItems] count]){
            // 从data source删除数据
            NSArray *items = [[User sharedUser] allItems];
            UserItem *item = items[indexPath.row];
            [[User sharedUser] removeItem:item];
            //删除表格中的对应行 用fade的动画效果(暂时没看出有啥区别...)
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

//自定义删除文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row < [[[User sharedUser] allItems] count]){
        NSArray *items = [[User sharedUser] allItems];
        UserItem *item = items[indexPath.row];
        NSString *del;
        if([item.name isEqualToString:@"程彦博"]){
            del = [[NSString alloc]initWithFormat :@"%@,%@", @"再见",  item.name];
        }
        else{
            del = [[NSString alloc]initWithFormat :@"%@,%@", @"滚吧",  item.name];
        }
        return del;
    }
    else
        return @"Unable";
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[User sharedUser] moveItemAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    //设置可以滑动
    NSArray *items = [[User sharedUser] allItems];
    //最后一行不可滑动
    if (indexPath.row == [items count]){
        return NO;
    }
    //只有一行数据时也不可滑动
    else if([items count] == 1){
        return NO;
    }
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < [[[User sharedUser] allItems] count])
        return   UITableViewCellEditingStyleDelete;
    else
        return UITableViewCellEditingStyleNone;
}

-(NSIndexPath *) tableView: (UITableView* ) tableView
targetIndexPathForMoveFromRowAtIndexPath: (NSIndexPath* ) source
      toProposedIndexPath: (NSIndexPath* ) destination
{
    NSArray *items = [[User sharedUser] allItems];
    //如果移动到最后一行以外的行
    if (destination.row < [items count]) {
        return destination;
    }
    NSIndexPath * indexPath = nil;
    // If your table can have <= 2 items, you might want to robusticize the index math.
    if (destination.row == 0) {
        indexPath = [NSIndexPath indexPathForRow: 1  inSection: 0];
    } else {
        indexPath = [NSIndexPath indexPathForRow: items.count - 2
                                       inSection: 0];
    }
    return indexPath;
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    if(indexPath.row < [[[User sharedUser] allItems] count]){
        ItemViewController *detailViewController = [[ItemViewController alloc] init];
        
        // Pass the selected object to the new view controller.
        NSArray *items = [[User sharedUser] allItems];
        UserItem *selectedItem = items[indexPath.row];
        detailViewController.item = selectedItem;
        
        //隐藏底部导航栏
        self.hidesBottomBarWhenPushed = YES;
        // Push the view controller.
        [self.navigationController pushViewController:detailViewController animated:YES];
        //push结束后再显示
        self.hidesBottomBarWhenPushed = NO;
    }
    
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
