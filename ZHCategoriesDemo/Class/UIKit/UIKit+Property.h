//
//  UIKit+Property.h
//  ZHCategoriesDemo
//
//  Created by walen on 16/8/8.
//  Copyright © 2016年 wuzhihe. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Property)

+ (UIView *)zh_instance;

- (UIView *(^)(CGFloat, CGFloat, CGFloat, CGFloat))zh_frame;
- (UIView *(^)(CGFloat, CGFloat, CGFloat, CGFloat))zh_bounds;

- (UIView *(^)(UIColor *))zh_backgroundColor;
- (UIView *(^)(CGFloat alpha))zh_alpha;
- (UIView *(^)(BOOL hidden))zh_hidden;
- (UIView *(^)(BOOL clipsToBounds))zh_clipsToBounds;
- (UIView *(^)(CGFloat cornerRadius))zh_cornerRadius;
- (UIView *(^)(UIColor *))zh_borderColor;
- (UIView *(^)(CGFloat borderWidth))zh_borderWidth;

@end

@interface UIButton (Property)

+ (UIButton *(^)(UIButtonType buttonType))zh_button;
- (UIButton *(^)(UIEdgeInsets contentEdgeInsets))zh_contentEdgeInsets;
- (UIButton *(^)(UIEdgeInsets titleEdgeInsets))zh_titleEdgeInsets;
- (UIButton *(^)(UIEdgeInsets imageEdgeInsets))zh_imageEdgeInsets;
- (UIButton *(^)(NSString *title, UIControlState state))zh_title;
- (UIButton *(^)(UIColor *color, UIControlState state))zh_titleColor;
- (UIButton *(^)(UIImage *image, UIControlState state))zh_image;
- (UIButton *(^)(UIImage *image, UIControlState state))zh_backgroundImage;
- (UIButton *(^)(NSAttributedString *attributedTitle, UIControlState state))zh_attributedTitle;

@end

@interface UILabel (Property)

+ (UILabel *)zh_instance;
- (UILabel *(^)(NSString *text))zh_text;
- (UILabel *(^)(UIFont *font))zh_font;
- (UILabel *(^)(UIColor *textColor))zh_textColor;
- (UILabel *(^)(UIColor *shadowColor))zh_shadowColor;
- (UILabel *(^)(NSTextAlignment textAlignment))zh_textAlignment;
- (UILabel *(^)(NSLineBreakMode lineBreakMode))zh_lineBreakMode;
- (UILabel *(^)(NSAttributedString *attributedText))zh_attributedText;
- (UILabel *(^)(UIColor *attributedText))zh_highlightedTextColor;
- (UILabel *(^)(BOOL userInteractionEnabled))zh_userInteractionEnabled;
- (UILabel *(^)(NSInteger numberOfLines))zh_numberOfLines;
- (UILabel *(^)(BOOL adjustsFontSizeToFitWidth))zh_adjustsFontSizeToFitWidth;
- (UILabel *(^)(UIBaselineAdjustment baselineAdjustment))zh_baselineAdjustment;

@end

@interface UITextField (Property)

+ (UITextField *)zh_instance;
- (UITextField *(^)(NSString *text))zh_text;
- (UITextField *(^)(NSAttributedString *attributedText))zh_attributedText;
- (UITextField *(^)(UIColor *textColor))zh_textColor;
- (UITextField *(^)(UIFont *font))zh_font;
- (UITextField *(^)(NSTextAlignment textAlignment))zh_textAlignment;
- (UITextField *(^)(UITextBorderStyle borderStyle))zh_borderStyle;
- (UITextField *(^)(NSDictionary<NSString *, id> *defaultTextAttributes))zh_defaultTextAttributes;
- (UITextField *(^)(NSString *placeholder))zh_placeholder;
- (UITextField *(^)(NSAttributedString *attributedPlaceholder))zh_attributedPlaceholder;
- (UITextField *(^)(BOOL clearsOnBeginEditing))zh_clearsOnBeginEditing;
- (UITextField *(^)(BOOL adjustsFontSizeToFitWidth))zh_adjustsFontSizeToFitWidth;
- (UITextField *(^)(CGFloat minimumFontSize))zh_minimumFontSize;
- (UITextField *(^)(id<UITextFieldDelegate> delegate))zh_delegate;
- (UITextField *(^)(UIImage *background))zh_background;
- (UITextField *(^)(UIImage *disabledBackground))zh_disabledBackground;
- (UITextField *(^)(UITextFieldViewMode clearButtonMode))zh_clearButtonMode;
- (UITextField *(^)(UIView *leftView))zh_leftView;
- (UITextField *(^)(UITextFieldViewMode leftViewMode))zh_leftViewMode;
- (UITextField *(^)(UIView *rightView))zh_rightView;
- (UITextField *(^)(UITextFieldViewMode rightViewMode))zh_rightViewMode;
- (UITextField *(^)(UIView *inputView))zh_inputView;
- (UITextField *(^)(UIView *inputAccessoryView))zh_inputAccessoryView;

@end

@interface UITableView (Property)

+ (UITableView *(^)(CGRect frame, UITableViewStyle style))zh_tableView;
- (UITableView *(^)(id <UITableViewDataSource> dataSource))zh_dataSource;
- (UITableView *(^)(id <UITableViewDelegate> delegate))zh_delegate;
- (UITableView *(^)(CGFloat rowHeight))zh_rowHeight;
- (UITableView *(^)(CGFloat sectionHeaderHeight))zh_sectionHeaderHeight;
- (UITableView *(^)(CGFloat sectionFooterHeight))zh_sectionFooterHeight;
- (UITableView *(^)(CGFloat estimatedRowHeight))zh_estimatedRowHeight;
- (UITableView *(^)(CGFloat estimatedSectionHeaderHeight))zh_estimatedSectionHeaderHeight;
- (UITableView *(^)(CGFloat estimatedSectionFooterHeight))zh_estimatedSectionFooterHeight;
- (UITableView *(^)(UIEdgeInsets separatorInset))zh_separatorInset;
- (UITableView *(^)(UIView *backgroundView))zh_backgroundView;
- (UITableView *(^)(UITableViewCellSeparatorStyle separatorStyle))zh_separatorStyle;
- (UITableView *(^)(UIColor *separatorColor))zh_separatorColor;
- (UITableView *(^)(UIVisualEffect *separatorEffect))zh_separatorEffect;
- (UITableView *(^)(UIView *tableHeaderView))zh_tableHeaderView;
- (UITableView *(^)(UIView *tableFooterView))zh_tableFooterView;

@end