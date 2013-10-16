//
//  TodoCell.m
//  TodoListRedo
//
//  Created by mkim on 10/12/13.
//  Copyright (c) 2013 mkim. All rights reserved.
//

#import "TodoCell.h"

@implementation TodoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    //UITextFields are disabled by default, enable if in editing mode
    if (editing == NO)
    {
        [self.todoTextField setEnabled:NO];
    }
    else if (editing == YES)
    {
        [self.todoTextField setEnabled:YES];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
