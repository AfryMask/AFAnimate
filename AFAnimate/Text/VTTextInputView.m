////
////  VTTextInputView.m
////  Taker
////
////  Created by chuyi on 16/6/23.
////  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
////
//
//#import "NSString+VideoText.h"
//#import "VTTextInputView.h"
//#import "NSString+ChactersLength.h"
//#import "GlobalMacros.h"
//#import "VTFontDownloadManager.h"
//
//#define MENTION_BUTTON_WIDTH 44
//#define MENTION_BUTTON_PADDING 0
//
//#define kMaxInputCount 140
//#define kNextButtonWidth 60
//
//@interface VTTextInputView()
//{
//    CGFloat keyboardHeight;
//    UIButton *nextButton;
//    BOOL keyboardRelayoutLock;
//    BOOL keyboardHeightLock;
//    BOOL isDelete;
//    BOOL isReplace;
//    float cachedStringHeight;
//}
//@property (nonatomic,strong) UILabel *textCountLabel;
//@end
//
//@implementation VTTextInputView
//@synthesize textCountLabel;
//- (id) initWithEffect:(UIVisualEffect *)effect
//{
//    BLog(@"initWithEffect start");
//    self = [super initWithEffect:effect];
//    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//    self.hidden = YES;
//    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    self.textView.frame = self.frame;
//    self.textView.backgroundColor = [UIColor clearColor];
//    self.textView.returnKeyType = UIReturnKeyDefault;// 返回键设置成默认类型
//    self.textView.font = fontRegular17;
//    self.textView.textAlignment = NSTextAlignmentCenter;
//    self.textView.textColor = [UIColor whiteColor];
//    self.textView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
//    self.textView.textContainerInset = UIEdgeInsetsMake(10, 20, 10, 20);
//    self.textView.tintColor = colorGold;
//    self.textView.delegate = self;
//    self.textView.keyboardAppearance = UIKeyboardAppearanceDark;
//    
//    nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [nextButton setTitle:_L(@"BUTTON_DONE") forState: UIControlStateNormal];
//    nextButton.titleLabel.font = fontBoldCondensed17;
//    CGFloat nextButtonTop = 10;
//    if (kSafe_TopH != 0) {
//        nextButtonTop = kSafe_TopH;
//    }
//    nextButton.frame = CGRectMake(self.width - kNextButtonWidth, nextButtonTop, kNextButtonWidth, MENTION_BUTTON_WIDTH);
//    [nextButton setTitleColor:colorGold forState:UIControlStateNormal];
//    nextButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
//    
//    [nextButton setImage:nil forState:UIControlStateNormal];
//    [nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    self.textCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    self.textCountLabel.font = fontCondensed12;
//    self.textCountLabel.textAlignment = NSTextAlignmentRight;
//    self.textCountLabel.text = [self.class stringForRemainingCount:kMaxInputCount];
//    self.textCountLabel.textColor = colorGrayCC;
//    [self.contentView addSubview:self.textCountLabel];
//    keyboardHeight = 250;
//
//    [self.contentView addSubview: self.textView];
//    [self.contentView addSubview:nextButton];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow:)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getKeyboardHeight:) name:UIKeyboardDidShowNotification object:nil];
//    BLog(@"initWithEffect end");
//    return self;
//}
//
//- (void) nextButtonAction
//{
//    if (self.textView.text.glyphCount > kMaxInputCount) {
//        return;
//    }
//    [self endEditing:YES];
//    [self.delegate hideInputViewSelectAddTextButtonIfNeed:YES];
//}
//
//- (void) finishAction
//{
//    if (self.textView.text.glyphCount > kMaxInputCount) {
//        return;
//    }
//    [self endEditing:YES];
//    [self.delegate hideInputViewSelectAddTextButtonIfNeed:NO];
//}
//
//- (void) dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
//-(int)getSubStringShowNumsInStringBy:(NSString*)string andSubstring:(NSString*)Substring
//{
//    int count =0;
//    NSRange range = [string rangeOfString:Substring];
//    if(range.length>0)
//    {
//        count++;
//        while (range.length>0) {
//            NSUInteger startIndex = range.location + range.length;
//            NSUInteger endIndex = string.length - startIndex;
//            string= [string substringWithRange:NSMakeRange(startIndex, endIndex)];
//            range = [string rangeOfString:Substring];
//            if(range.length>0)
//            {
//                count++;
//            }
//        }
//    }
//    return count;
//}
//
//
//#pragma mark -
//#pragma mark - TextViewDelegate
//
//- (void) textViewDidBeginEditing:(UITextView *)textView
//{
//    [self relayoutTextViewCenter];
//}
//
//- (void) textViewDidChange:(UITextView *)textView
//{
//    NSInteger length = (int)textView.text.glyphCount;
//    if (length <= kMaxInputCount && length >= 0) {
//        textCountLabel.textColor = colorGrayCC;
//        textCountLabel.text = [self.class stringForRemainingCount:kMaxInputCount - (int)textView.text.glyphCount];
//    } else {
//        textCountLabel.textColor = colorAlert;
//        textCountLabel.text = [self.class stringForRemainingCount:kMaxInputCount - (int)textView.text.glyphCount];
//    }
//    [self relayoutTextViewCenter];
//    
//    if (textView.text.glyphCount > kMaxInputCount) {
//        nextButton.alpha = 0.3;
//        nextButton.userInteractionEnabled = NO;
//    } else {
//        nextButton.alpha = 1;
//        nextButton.userInteractionEnabled = YES;
//    }
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    keyboardRelayoutLock = YES;
//}
//
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if (!text.glyphCount) {//限制最大输入
//        isDelete = YES;
//        if (textView.text.length > 0) {
//            if([[textView.text substringWithRange:range] isEqualToString:@" "]) {
//                return !isReplace;
//            }
//        }
//    }
//    if ([text isEqualToString:@"\n"]) {
//        textView.text = [textView.text stringByReplacingCharactersInRange:range withString:@"\r"];
//        textView.selectedRange = NSMakeRange(range.location + text.length, 0);
//        if ([textView.delegate respondsToSelector:@selector(textViewDidChange:)]) {
//            [textView.delegate textViewDidChange:textView];
//        }
//        return NO;
//    }
//    isDelete = NO;
//    return YES;
//}
//
///**
// 监听键盘高度
// */
//- (void) getKeyboardHeight: (NSNotification *) notification
//{
//    int length = (int)self.textView.text.glyphCount;
//    textCountLabel.text = [self.class stringForRemainingCount:kMaxInputCount - (int)length];
//    if (!keyboardHeightLock) {
//        CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//        keyboardHeight = keyboardFrame.size.height;
//        keyboardHeightLock = YES;
//        textCountLabel.hidden = NO;
//        textCountLabel.frame = CGRectMake(kScreenWidth - 200 - 10, kScreenHeight - keyboardHeight - 30, 200, 15);
//        textCountLabel.right = self.width - 15;
//    }
//    if (keyboardRelayoutLock) {
//        keyboardRelayoutLock = NO;
//        [self relayoutTextViewCenter];
//    }
//}
//
//- (void) keyboardWillShow:(NSNotification *)notification {
//    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    self.textFieldTop = CGRectGetMinY(rect);
//    keyboardHeightLock = NO;
//}
//
//- (void) keyboardWillHide:(NSNotification *) notification {
//    
//}
//
//
//- (void) relayoutTextViewCenter
//{
//    UIEdgeInsets baseInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"啊%@", [self.textView.text copy]] attributes: @{
//                                                                                                                                                                      NSFontAttributeName:fontRegular17
//                                                                                                                                                                      }];
//    CGRect frame = [string boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 99999) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
//    if (fabs(cachedStringHeight - CGRectGetHeight(frame)) > fontRegular17.lineHeight * 0.9) {
//        float top = (kScreenHeight - keyboardHeight - frame.size.height) / 2;
//        baseInset.top = top;
//        self.textView.contentInset = baseInset;
//    }
//    self.textView.textAlignment = NSTextAlignmentCenter;
//    cachedStringHeight = CGRectGetHeight(frame);
//}
//
//+ (NSString *)stringForRemainingCount:(int)remainingCount{
//    NSString *text = nil;
//    if (remainingCount>=0) {
//        text = _L(@"TEXT_CHARS_LEFT");
//        text = [text stringByReplacingOccurrencesOfString:@"%s" withString:@(remainingCount).stringValue];
//    } else {
//        text = _L(@"TEXT_CHARS_EXCEEDED");
//        text = [text stringByReplacingOccurrencesOfString:@"%s" withString:@(abs(remainingCount)).stringValue];
//    }
//    // 特殊处理：把“符”去掉，英文状态下会被忽略
//    text = [text stringByReplacingOccurrencesOfString:@"符" withString:@""];
//    return text;
//}
//
//@end
//
