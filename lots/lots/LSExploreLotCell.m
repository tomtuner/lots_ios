//
//  LSExploreLotCell.m
//  lots
//
//  Created by Thomas DeMeo on 3/13/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "LSExploreLotCell.h"

@implementation LSExploreLotCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lotName.font = [[ThemeManager sharedTheme] customFontWithSize:22.0f];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
