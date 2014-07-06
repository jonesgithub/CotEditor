/*
 =================================================
 CESyntaxMappingConflictsSheetController
 (for CotEditor)
 
 Copyright (C) 2014 CotEditor Project
 http://coteditor.github.io
 =================================================
 
 encoding="UTF-8"
 Created:2014-03-25 by 1024jp
 
 -------------------------------------------------
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 
 
 =================================================
 */

#import "CESyntaxMappingConflictsSheetController.h"
#import "CESyntaxManager.h"


@interface CESyntaxMappingConflictsSheetController ()

@property (nonatomic, copy) NSArray *extensionConflicts;
@property (nonatomic, copy) NSArray *filenameConflicts;

@end




#pragma mark -

@implementation CESyntaxMappingConflictsSheetController

#pragma mark NSWindowController Methods

// ------------------------------------------------------
/// 初期化
- (instancetype)init
// ------------------------------------------------------
{
    self = [super initWithWindowNibName:@"SyntaxMappingConflictSheet"];
    if (self) {
        [[self window] setLevel:NSModalPanelWindowLevel];
        
        NSDictionary *errorDict = [[CESyntaxManager sharedManager] extensionConflicts];
        NSMutableArray *conflicts = [NSMutableArray array];
        for (NSString *key in errorDict) {
            NSMutableArray *styles = [errorDict[key] mutableCopy];
            NSString *primaryStyle = styles[0];
            [styles removeObjectAtIndex:0];
            [conflicts addObject:@{@"name": key,
                                 @"primaryStyle": primaryStyle,
                                 @"doubledStyles":  [styles componentsJoinedByString:@", "]}];
        }
        [self setExtensionConflicts:conflicts];
        
        
        errorDict = [[CESyntaxManager sharedManager] filenameConflicts];
        conflicts = [NSMutableArray array];
        for (NSString *key in errorDict) {
            NSMutableArray *styles = [errorDict[key] mutableCopy];
            NSString *primaryStyle = styles[0];
            [styles removeObjectAtIndex:0];
            [conflicts addObject:@{@"name": key,
                                   @"primaryStyle": primaryStyle,
                                   @"doubledStyles":  [styles componentsJoinedByString:@", "]}];
        }
        [self setFilenameConflicts:conflicts];
    }
    return self;
}



#pragma mark Action Messages

// ------------------------------------------------------
/// シートの Done ボタンが押された
- (IBAction)closeSheet:(id)sender
// ------------------------------------------------------
{
    [NSApp stopModal];
}

@end