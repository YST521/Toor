
//

#import "HYBHeaderView.h"
#import "HYBSectionModel.h"

@interface HYBHeaderView ()

@property (nonatomic, strong) UIImageView *arrowImageView;
//@property (nonatomic, strong) UILabel *titleLabel;
@property(nonatomic,strong)UILabel* gongshiLa;


@end

@implementation HYBHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
      self.userInteractionEnabled=YES;
      
    self.arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_up"]];
    self.arrowImageView.frame = CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT(45 - 8) / 2, 15, 8);
    [self.contentView addSubview:self.arrowImageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(onExpand:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    button.frame = CGRectMake(PROPORTION_WIDTH(100), 0, w, 45);
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, PROPORTION_HIGHT(10/2), PROPORTION_WIDTH(150), PROPORTION_HIGHT(20))];
    self.titleLabel.textColor =textCententColor;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.titleLabel];
    self.contentView.backgroundColor = [UIColor whiteColor];
     //gongshi label
      self.gongshiLa=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame)+2, self.titleLabel.width, PROPORTION_HIGHT(13))];
      self.gongshiLa.textColor =textCententColor;
      self.gongshiLa.font =[UIFont systemFontOfSize:12];
      [self.contentView addSubview:self.gongshiLa];
    
      //分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45 - 0.5, w, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
  }
  
  return self;
}

- (void)setModel:(HYBSectionModel *)model {
  if (_model != model) {
    _model = model;
  }
  
  
  if (model.isExpanded) {
    self.arrowImageView.transform = CGAffineTransformIdentity;
  } else {
    self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
  }
  
  self.gongshiLa.text =model.gongshititle;
  self.titleLabel.text = model.sectionTitle;
    if ([self.titleLabel.text isEqualToString:@"去申请工时"]) {
        self.titleLabel.textColor=[UIColor redColor];
        UIView*view=[[UIView alloc]init];
        view.frame=CGRectMake(self.titleLabel.x-10, self.titleLabel.height-1, PROPORTION_WIDTH(80), 1);
        view.backgroundColor=[UIColor redColor];
        [self.titleLabel addSubview:view];
    }
 
}

- (void)onExpand:(UIButton *)sender {
  self.model.isExpanded = !self.model.isExpanded;
  
  [UIView animateWithDuration:0.25 animations:^{
    if (self.model.isExpanded) {
      self.arrowImageView.transform = CGAffineTransformIdentity;
    } else {
      self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
    }
  }];
  
  if (self.expandCallback) {
    self.expandCallback(self.model.isExpanded);
  }
}

@end
