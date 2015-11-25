//
//  ViewController.m
//  QQUI
//
//  Created by 向元新 on 15/11/9.
//  Copyright © 2015年 向元新. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "messagesModel.h"
#import "messageFrames.h"
#import "QQUIMessageCell.h"

//  #define httpServer @"http://www.tuling123.com/openapi/api?key=90b5afea37c568a2871ce5b9e0d4e27c"
#define httpServer @"http://www.tuling123.com/openapi/api?key=80a009dabfc205ecf0b2e6cb2d065a70"
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(nonatomic, strong)NSMutableArray *arrayFrame;

@property (weak, nonatomic) IBOutlet UITableView *messageTable;

@property (weak, nonatomic) IBOutlet UITextField *sendText;

@property (weak, nonatomic) IBOutlet UIView *sendView;

@property(nonatomic, assign)BOOL isFrameChanged;

@property(nonatomic, assign)CGRect sendViewFrame;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.messageTable.delegate = self;
    self.messageTable.dataSource = self;
    self.sendText.delegate = self;
    self.messageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.messageTable.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    self.messageTable.allowsSelection = NO;
    
    //创建一个NSNotificationCenter对象
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    //监听
    [center addObserver:self selector:@selector(keyBoardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}


-(void)httpRequest:(NSString *)content{
    NSString *httpPath = [NSString stringWithFormat:@"%@&info=%@",httpServer,content];
 //   NSURL *url = [NSURL URLWithString:[httpPath stringByRemovingPercentEncoding]];
    
    NSURL *url = [NSURL URLWithString:[httpPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = operation.responseString;
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSString *text = [dic objectForKey:@"text"];
        [self sendMessage:text isMe:NO];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fail");
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:operation];
}


-(void)keyBoardFrameChange:(NSNotification *)noteInfo
{
    NSLog(@"%@",noteInfo.userInfo);

    //获取键盘的y值
    CGRect rectBegine = [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = rectBegine.origin.y;

    
    //如果最下方的控件很高，键盘弹起根本挡不到，则不用移动
    NSIndexPath *lastRowIndexPath = [NSIndexPath indexPathForRow:(_arrayFrame.count - 1) inSection:0];
    
    QQUIMessageCell *lastCell = [self.messageTable cellForRowAtIndexPath:lastRowIndexPath];
    CGFloat lastRowY = lastCell.frame.origin.y;
    
    //最后一行的行高
    messageFrames *frame = [_arrayFrame lastObject];
    CGFloat cellHeight = frame.messageFrame.size.height;
    

    
    if (_isFrameChanged == YES) {
 //       CGFloat transformY = keyboardY - self.view.frame.size.height;
        [UIView animateWithDuration:0.25 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
        self.sendView.frame = _sendViewFrame;
        [self.view addSubview:self.sendView];
        _isFrameChanged = NO;
    }else
    {
        if (lastRowY == 0) {
            _sendViewFrame = self.sendView.frame;
            CGFloat transformY = keyboardY - self.view.frame.size.height;
            [UIView animateWithDuration:0.25 animations:^{
                self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
                
            }];
            _isFrameChanged = YES;
        }
    if ((lastRowY + cellHeight) > (keyboardY - _sendViewFrame.size.height)) {  //键盘挡住了至少一行
        //获取sendview的frame
        _sendViewFrame = self.sendView.frame;
        
        CGFloat transformY = keyboardY - lastRowY - cellHeight - _sendViewFrame.size.height;
        if (transformY < keyboardY - self.view.frame.size.height) {
            transformY = keyboardY - self.view.frame.size.height;
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, transformY);

        }];
        CGFloat newY = keyboardY - transformY - _sendViewFrame.size.height ;
        CGRect newFrame = CGRectMake(0, newY, _sendViewFrame.size.width, _sendViewFrame.size.height);
        self.sendView.frame = newFrame;
        
        [self.view addSubview:self.sendView];
        _isFrameChanged = YES;
        
        
        }
    }
        [self.messageTable scrollToRowAtIndexPath:lastRowIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    

}


- (NSMutableArray *)arrayFrame
{
    if (_arrayFrame == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"data.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *array_temp = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            messagesModel *model = [messagesModel messagesModelWithDict:dict];
            
            messageFrames *frame = [[messageFrames alloc]init];
            //在把model赋值给frame之前就要赋值hideTime
            messageFrames *lastObject = (messageFrames *)[array_temp lastObject];
            if ([model.time isEqualToString:lastObject.model.time]) {
                model.hideTime = YES;
            }else
            {
                model.hideTime = NO;
            }
            
            frame.model = model;

             [array_temp addObject:frame];
        }
        
        _arrayFrame = array_temp;

        
    }

    return _arrayFrame;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayFrame.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据模型
    messageFrames *frame =_arrayFrame[indexPath.row];
 
    //创建自定义控件
    static NSString *ID = @"message_cell";
    QQUIMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[QQUIMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.frames = frame;
    
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    messageFrames *frame = _arrayFrame[indexPath.row];
    return frame.rowHeight;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //获取输入的文本
    NSString *text = _sendText.text;
    [self sendMessage:text isMe:YES];
    

    _sendText.text = nil;
//    NSString *backMssage = @"hello";
//    [self sendMessage:backMssage isMe:NO];
    
    //滚到最后一行
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:(self.arrayFrame.count - 1) inSection:0];
    [self.messageTable scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    // 网络请求
    [self httpRequest:text];

    return YES;
}

- (void)sendMessage:(NSString *)sendText isMe:(BOOL)isMe
{
    //获取输入的文本
    NSString *text = sendText;
    //获取系统时间
    NSDate *nowData = [NSDate date];
    //将系统时间变为“今天 HH:mm”格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"今天 HH:mm";
    //创建数据模型
    messagesModel *model = [[messagesModel alloc]init];
    //将时间赋值
    model.time = [formatter stringFromDate:nowData];
    messageFrames *lastFrame = [self.arrayFrame lastObject];
    if ([model.time isEqualToString: lastFrame.model.time]) {
        model.hideTime = YES;
    }
    
    model.message = text;
    model.isMe = isMe;
    messageFrames *frame = [[messageFrames alloc]init];
    frame.model = model;
    [_arrayFrame addObject:frame];
    
    //reload显示界面
    [self.messageTable reloadData];
    
    //滚到最后一行
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:(self.arrayFrame.count - 1) inSection:0];
    [self.messageTable scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}





- (BOOL)prefersStatusBarHidden
{
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
