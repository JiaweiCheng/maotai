//  ShareToWeiXin
//
//  Created by xiajin on 11/6/13.
//
//

#import "MainViewController.h"
#import "ContentCell.h"

@implementation MainViewController
@synthesize selectTableView;
@synthesize deleteDic;
@synthesize listData;
@synthesize dataList;
@synthesize imageList;
@synthesize rightButton;
@synthesize browserViewController = _browserViewController;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	rightButton.title = @"编辑";
    
    self.browserViewController = [[[BrowserViewController alloc] initWithNibName:@"BrowserViewController" bundle:nil] autorelease];
    
    //加载plist文件的数据和图片
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"news" withExtension:@"plist"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    
    NSMutableArray *tmpDataArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[dictionary count]; i++) {
        NSString *key = [[NSString alloc] initWithFormat:@"%i", i+1];
        NSDictionary *tmpDic = [dictionary objectForKey:key];
        [tmpDataArray addObject:tmpDic];
    }
    self.dataList = [tmpDataArray copy];
}

- (void)viewDidUnload
{
    [selectTableView release];
    selectTableView = nil;
    [super viewDidUnload];
    self.listData = nil;
    self.dataList = nil;
    self.imageList = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}



// 设置单条列表数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ContentCellIdentifier = @"ContentCellIdentifier";
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"ContentCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ContentCellIdentifier];
        nibsRegistered = YES;
    }
    
    ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ContentCellIdentifier];
    if (cell == nil) { 
        cell = [[ContentCell alloc] 
                initWithStyle:UITableViewCellStyleDefault 
                reuseIdentifier:ContentCellIdentifier]; 
    }
    
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowData = [self.dataList objectAtIndex:row];
    cell.title = [rowData objectForKey:@"title"];
    cell.desc = [rowData objectForKey:@"content"];
    cell.link = [rowData objectForKey:@"link"];
    cell.imgUrl = [rowData objectForKey:@"img"];
    //url请求实在UI主线程中进行的
    NSURL *photourl = [NSURL URLWithString:cell.imgUrl];
    //通过网络url获取uiimage
    cell.imgView = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];
    return cell;
}




//此时删除按钮为Delete，如果想显示为“删除” 中文的话，则需要实现
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"微信";
}

//要求委托方的编辑风格在表视图的一个特定的位置。
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( selectTableView.editing )
    {
        return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    }
    
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
    //默认没有编辑风格
    if ([tableView isEqual:selectTableView])
    {
        result = UITableViewCellEditingStyleDelete;
        NSLog(@"%@",[NSString stringWithFormat:@"%@Cell %ld in Section %ld is selected",
                     rightButton.title,(long)indexPath.row,(long)indexPath.section]);
    }
    return result;
}

- (void)sendLinkContent:(NSDictionary *)msgDict
{
    if (_delegate)
    {
        [_delegate sendLinkContent:msgDict];
    }
}

//请求数据源提交的插入或删除指定行接收者。
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleDelete)
    {
        //如果编辑样式为删除样式
        if (indexPath.row<[self.dataList count])
        {
            ContentCell * selectCell = (ContentCell *)[tableView cellForRowAtIndexPath:( indexPath )];
            NSDictionary *msgDict = [NSDictionary dictionaryWithObjectsAndKeys:selectCell.title,@"title",
                                     selectCell.desc,@"content", selectCell.imgUrl,@"imgUrl",
                                     selectCell.link,@"link", nil];
            [self sendLinkContent:msgDict];
        }
    }
}





#pragma mark Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}


- (void)dealloc {
    [selectTableView release];
    [super dealloc];
}

- (IBAction)chooseData
{
    if ([rightButton.title isEqual: @"确定"] )
    {
        rightButton.title = @"编辑";
        [self.selectTableView setEditing:NO animated:YES] ;
    }
    else
    {
        if ( selectTableView.editing )
        {
            [self.selectTableView setEditing:NO animated:YES] ;
        }
        rightButton.title = @"确定";
        [self.selectTableView setEditing:YES animated:YES] ;
    }
}




#pragma mark -
#pragma mark Table view delegate
//点击某一行时候触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([rightButton.title isEqual: @"确定"] )
    {
        [deleteDic setObject:indexPath forKey:[self.dataList objectAtIndex:indexPath.row]];
        return ;
    }
		
    if ([tableView isEqual:selectTableView])
    {
        ContentCell * selectCell = (ContentCell *)[tableView cellForRowAtIndexPath:( indexPath )];
        [self.browserViewController openBrowser:self.view webUrl:selectCell.link];
        NSLog(@"%@",[NSString stringWithFormat:@"Cell %ld in Section %ld is selected",(long)indexPath.row,(long)indexPath.section]);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([rightButton.title isEqual: @"确定"] )
    {
        [deleteDic removeObjectForKey:[self.dataList objectAtIndex:indexPath.row]];
    }
}



@end
