//
//  UIKit+Property.m
//  ZHCategoriesDemo
//
//  Created by walen on 16/8/8.
//  Copyright © 2016年 wuzhihe. All rights reserved.
//

#import "UIKit+Property.h"

@implementation UIView (Property)

+ (UIView *)zh_instance
{
    return [[self alloc] init];
}

- (UIView *(^)(CGFloat, CGFloat, CGFloat, CGFloat))zh_frame
{
    return ^UIView *(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
        self.frame = CGRectMake(x, y, width, height);
        return self;
    };
}

- (UIView *(^)(CGFloat, CGFloat, CGFloat, CGFloat))zh_bounds
{
    return ^UIView *(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
        self.bounds = CGRectMake(x, y, width, height);
        return self;
    };
}

- (UIView *(^)(UIColor *))zh_backgroundColor
{
    return ^UIView *(UIColor *color){
        self.backgroundColor = color;
        return self;
    };
}

- (UIView *(^)(CGFloat alpha))zh_alpha
{
    return ^UIView *(CGFloat alpha){
        self.alpha = alpha;
        return self;
    };
}

- (UIView *(^)(BOOL hidden))zh_hidden
{
    return ^UIView *(BOOL hidden){
        self.hidden = hidden;
        return self;
    };
}

- (UIView *(^)(BOOL clipsToBounds))zh_clipsToBounds
{
    return ^UIView *(BOOL clipsToBounds){
        self.clipsToBounds = clipsToBounds;
        return self;
    };
}

- (UIView *(^)(CGFloat cornerRadius))zh_cornerRadius
{
    return ^UIView *(CGFloat cornerRadius){
        self.layer.cornerRadius = cornerRadius;
        self.clipsToBounds = YES;
        return self;
    };
}

- (UIView *(^)(UIColor *))zh_borderColor
{
    return ^UIView *(UIColor * borderColor){
        self.layer.borderColor = borderColor.CGColor;
        return self;
    };
}

- (UIView *(^)(CGFloat borderWidth))zh_borderWidth
{
    return ^UIView *(CGFloat borderWidth){
        self.layer.borderWidth = borderWidth;
        return self;
    };
}

@end

@implementation UIButton (Property)

+ (UIButton *(^)(UIButtonType buttonType))zh_button
{
    return ^UIButton *(UIButtonType buttonType){
        UIButton *button = [self buttonWithType:buttonType];
        return button;
    };
}

- (UIButton *(^)(UIEdgeInsets contentEdgeInsets))zh_contentEdgeInsets
{
    return ^UIButton *(UIEdgeInsets contentEdgeInsets){
        self.contentEdgeInsets = contentEdgeInsets;
        return self;
    };
}

- (UIButton *(^)(UIEdgeInsets titleEdgeInsets))zh_titleEdgeInsets
{
    return ^UIButton *(UIEdgeInsets titleEdgeInsets){
        self.titleEdgeInsets = titleEdgeInsets;
        return self;
    };
}


- (UIButton *(^)(UIEdgeInsets imageEdgeInsets))zh_imageEdgeInsets
{
    return ^UIButton *(UIEdgeInsets imageEdgeInsets){
        self.imageEdgeInsets = imageEdgeInsets;
        return self;
    };
}

- (UIButton *(^)(NSString *title, UIControlState state))zh_title
{
    return ^UIButton *(NSString *title, UIControlState state){
        [self setTitle:title forState:state];
        return self;
    };
}

- (UIButton *(^)(UIColor *color, UIControlState state))zh_titleColor
{
    return ^UIButton *(UIColor *color, UIControlState state){
        [self setTitleColor:color forState:state];
        return self;
    };
}

- (UIButton *(^)(UIImage *image, UIControlState state))zh_image
{
    return ^UIButton *(UIImage *image, UIControlState state){
        [self setImage:image forState:state];
        return self;
    };
}

- (UIButton *(^)(UIImage *image, UIControlState state))zh_backgroundImage
{
    return ^UIButton *(UIImage *image, UIControlState state){
        [self setBackgroundImage:image forState:state];
        return self;
    };
}

- (UIButton *(^)(NSAttributedString *attributedTitle, UIControlState state))zh_attributedTitle
{
    return ^UIButton *(NSAttributedString *attributedTitle, UIControlState state){
        [self setAttributedTitle:attributedTitle forState:state];
        return self;
    };
}

@end

@implementation UILabel (Property)

+ (UILabel *)zh_instance
{
    return [[self alloc] init];
}

- (UILabel *(^)(NSString *text))zh_text
{
    return ^UILabel *(NSString *text){
        self.text = text;
        return self;
    };
}

- (UILabel *(^)(UIFont *font))zh_font
{
    return ^UILabel *(UIFont *font){
        self.font = font;
        return self;
    };
}

- (UILabel *(^)(UIColor *textColor))zh_textColor
{
    return ^UILabel *(UIColor *textColor){
        self.textColor = textColor;
        return self;
    };
}

- (UILabel *(^)(UIColor *shadowColor))zh_shadowColor
{
    return ^UILabel *(UIColor *shadowColor){
        self.shadowColor = shadowColor;
        return self;
    };
}

- (UILabel *(^)(NSTextAlignment textAlignment))zh_textAlignment
{
    return ^UILabel *(NSTextAlignment textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
}

- (UILabel *(^)(NSLineBreakMode lineBreakMode))zh_lineBreakMode
{
    return ^UILabel *(NSLineBreakMode lineBreakMode){
        self.lineBreakMode = lineBreakMode;
        return self;
    };
}

- (UILabel *(^)(NSAttributedString *attributedText))zh_attributedText
{
    return ^UILabel *(NSAttributedString *attributedText){
        self.attributedText = attributedText;
        return self;
    };
}

- (UILabel *(^)(UIColor *attributedText))zh_highlightedTextColor
{
    return ^UILabel *(UIColor *highlightedTextColor){
        self.highlightedTextColor = highlightedTextColor;
        return self;
    };
}

- (UILabel *(^)(BOOL userInteractionEnabled))zh_userInteractionEnabled
{
    return ^UILabel *(BOOL userInteractionEnabled){
        self.userInteractionEnabled = userInteractionEnabled;
        return self;
    };
}

- (UILabel *(^)(NSInteger numberOfLines))zh_numberOfLines
{
    return ^UILabel *(NSInteger numberOfLines){
        self.numberOfLines = numberOfLines;
        return self;
    };
}

- (UILabel *(^)(BOOL adjustsFontSizeToFitWidth))zh_adjustsFontSizeToFitWidth
{
    return ^UILabel *(BOOL adjustsFontSizeToFitWidth){
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
        return self;
    };
}

- (UILabel *(^)(UIBaselineAdjustment baselineAdjustment))zh_baselineAdjustment
{
    return ^UILabel *(UIBaselineAdjustment baselineAdjustment){
        self.baselineAdjustment = baselineAdjustment;
        return self;
    };
}

@end

@implementation UITextField (Property)

+ (UITextField *)zh_instance
{
    return [[self alloc] init];
}

- (UITextField *(^)(NSString *text))zh_text
{
    return ^UITextField *(NSString *text){
        self.text = text;
        return self;
    };
}

- (UITextField *(^)(NSAttributedString *attributedText))zh_attributedText
{
    return ^UITextField *(NSAttributedString *attributedText){
        self.attributedText = attributedText;
        return self;
    };
}

- (UITextField *(^)(UIColor *textColor))zh_textColor
{
    return ^UITextField *(UIColor *textColor){
        self.textColor = textColor;
        return self;
    };
}

- (UITextField *(^)(UIFont *font))zh_font
{
    return ^UITextField *(UIFont *font){
        self.font = font;
        return self;
    };
}

- (UITextField *(^)(NSTextAlignment textAlignment))zh_textAlignment
{
    return ^UITextField *(NSTextAlignment textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
}

- (UITextField *(^)(UITextBorderStyle borderStyle))zh_borderStyle
{
    return ^UITextField *(UITextBorderStyle borderStyle){
        self.borderStyle = borderStyle;
        return self;
    };
}

- (UITextField *(^)(NSDictionary<NSString *, id> *defaultTextAttributes))zh_defaultTextAttributes
{
    return ^UITextField *(NSDictionary<NSString *, id> *defaultTextAttributes){
        self.defaultTextAttributes = defaultTextAttributes;
        return self;
    };
}

- (UITextField *(^)(NSString *placeholder))zh_placeholder
{
    return ^UITextField *(NSString *placeholder){
        self.placeholder = placeholder;
        return self;
    };
}

- (UITextField *(^)(NSAttributedString *attributedPlaceholder))zh_attributedPlaceholder
{
    return ^UITextField *(NSAttributedString *attributedPlaceholder){
        self.attributedPlaceholder = attributedPlaceholder;
        return self;
    };
}

- (UITextField *(^)(BOOL clearsOnBeginEditing))zh_clearsOnBeginEditing
{
    return ^UITextField *(BOOL clearsOnBeginEditing){
        self.clearsOnBeginEditing = clearsOnBeginEditing;
        return self;
    };
}

- (UITextField *(^)(BOOL adjustsFontSizeToFitWidth))zh_adjustsFontSizeToFitWidth
{
    return ^UITextField *(BOOL adjustsFontSizeToFitWidth){
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
        return self;
    };
}

- (UITextField *(^)(CGFloat minimumFontSize))zh_minimumFontSize
{
    return ^UITextField *(CGFloat minimumFontSize){
        self.minimumFontSize = minimumFontSize;
        return self;
    };
}

- (UITextField *(^)(id<UITextFieldDelegate> delegate))zh_delegate
{
    return ^UITextField *(id<UITextFieldDelegate> delegate){
        self.delegate = delegate;
        return self;
    };
}

- (UITextField *(^)(UIImage *background))zh_background
{
    return ^UITextField *(UIImage *background){
        self.background = background;
        return self;
    };
}

- (UITextField *(^)(UIImage *disabledBackground))zh_disabledBackground
{
    return ^UITextField *(UIImage *disabledBackground){
        self.disabledBackground = disabledBackground;
        return self;
    };
}

- (UITextField *(^)(UITextFieldViewMode clearButtonMode))zh_clearButtonMode
{
    return ^UITextField *(UITextFieldViewMode clearButtonMode){
        self.clearButtonMode = clearButtonMode;
        return self;
    };
}

- (UITextField *(^)(UIView *leftView))zh_leftView
{
    return ^UITextField *(UIView *leftView){
        self.leftView = leftView;
        return self;
    };
}

- (UITextField *(^)(UITextFieldViewMode leftViewMode))zh_leftViewMode
{
    return ^UITextField *(UITextFieldViewMode leftViewMode){
        self.leftViewMode = leftViewMode;
        return self;
    };
}

- (UITextField *(^)(UIView *rightView))zh_rightView
{
    return ^UITextField *(UIView *rightView){
        self.rightView = rightView;
        return self;
    };
}

- (UITextField *(^)(UITextFieldViewMode rightViewMode))zh_rightViewMode
{
    return ^UITextField *(UITextFieldViewMode rightViewMode){
        self.rightViewMode = rightViewMode;
        return self;
    };
}

- (UITextField *(^)(UIView *inputView))zh_inputView
{
    return ^UITextField *(UIView *inputView){
        self.inputView = inputView;
        return self;
    };
}

- (UITextField *(^)(UIView *inputAccessoryView))zh_inputAccessoryView
{
    return ^UITextField *(UIView *inputAccessoryView){
        self.inputAccessoryView = inputAccessoryView;
        return self;
    };
}

@end

@implementation UITableView (Property)

+ (UITableView *(^)(CGRect frame, UITableViewStyle style))zh_tableView
{
    return ^UITableView *(CGRect frame, UITableViewStyle style){
        UITableView *tableView = [[self alloc] initWithFrame:frame style:style];
        return tableView;
    };
}

- (UITableView *(^)(id <UITableViewDataSource> dataSource))zh_dataSource
{
    return ^UITableView *(id <UITableViewDataSource> dataSource){
        self.dataSource = dataSource;
        return self;
    };
}

- (UITableView *(^)(id <UITableViewDelegate> delegate))zh_delegate
{
    return ^UITableView *(id <UITableViewDelegate> delegate){
        self.delegate = delegate;
        return self;
    };
}

- (UITableView *(^)(CGFloat rowHeight))zh_rowHeight
{
    return ^UITableView *(CGFloat rowHeight){
        self.rowHeight = rowHeight;
        return self;
    };
}

- (UITableView *(^)(CGFloat sectionHeaderHeight))zh_sectionHeaderHeight
{
    return ^UITableView *(CGFloat sectionHeaderHeight){
        self.sectionHeaderHeight = sectionHeaderHeight;
        return self;
    };
}

- (UITableView *(^)(CGFloat sectionFooterHeight))zh_sectionFooterHeight
{
    return ^UITableView *(CGFloat sectionFooterHeight){
        self.sectionFooterHeight = sectionFooterHeight;
        return self;
    };
}

- (UITableView *(^)(CGFloat estimatedRowHeight))zh_estimatedRowHeight
{
    return ^UITableView *(CGFloat estimatedRowHeight){
        self.estimatedRowHeight = estimatedRowHeight;
        return self;
    };
}

- (UITableView *(^)(CGFloat estimatedSectionHeaderHeight))zh_estimatedSectionHeaderHeight
{
    return ^UITableView *(CGFloat estimatedSectionHeaderHeight){
        self.estimatedSectionHeaderHeight = estimatedSectionHeaderHeight;
        return self;
    };
}

- (UITableView *(^)(CGFloat estimatedSectionFooterHeight))zh_estimatedSectionFooterHeight
{
    return ^UITableView *(CGFloat estimatedSectionFooterHeight){
        self.estimatedSectionFooterHeight = estimatedSectionFooterHeight;
        return self;
    };
}

- (UITableView *(^)(UIEdgeInsets separatorInset))zh_separatorInset
{
    return ^UITableView *(UIEdgeInsets separatorInset){
        self.separatorInset = separatorInset;
        return self;
    };
}

- (UITableView *(^)(UIView *backgroundView))zh_backgroundView
{
    return ^UITableView *(UIView *backgroundView){
        self.backgroundView = backgroundView;
        return self;
    };
}

- (UITableView *(^)(UITableViewCellSeparatorStyle separatorStyle))zh_separatorStyle
{
    return ^UITableView *(UITableViewCellSeparatorStyle separatorStyle){
        self.separatorStyle = separatorStyle;
        return self;
    };
}

- (UITableView *(^)(UIColor *separatorColor))zh_separatorColor
{
    return ^UITableView *(UIColor *separatorColor){
        self.separatorColor = separatorColor;
        return self;
    };
}

- (UITableView *(^)(UIVisualEffect *separatorEffect))zh_separatorEffect
{
    return ^UITableView *(UIVisualEffect *separatorEffect){
        self.separatorEffect = separatorEffect;
        return self;
    };
}

- (UITableView *(^)(UIView *tableHeaderView))zh_tableHeaderView
{
    return ^UITableView *(UIView *tableHeaderView){
        self.tableHeaderView = tableHeaderView;
        return self;
    };
}

- (UITableView *(^)(UIView *tableFooterView))zh_tableFooterView
{
    return ^UITableView *(UIView *tableFooterView){
        self.tableFooterView = tableFooterView;
        return self;
    };
}

@end
