//
//  TodoListViewController.m
//  TodoList
//
//  Created by mkim on 10/12/13.
//  Copyright (c) 2013 mkim. All rights reserved.
//

#import "TodoListViewController.h"

@interface TodoListViewController ()

@property (nonatomic, retain) NSMutableArray *todoListArray;

@end

@implementation TodoListViewController

static char *indexPathKey;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.todoListArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"To Do List"];
    
    UINib *customNib = [UINib nibWithNibName:@"TodoCell" bundle:nil];
    [self.tableView registerNib:customNib forCellReuseIdentifier:@"TodoCell"];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTodoItem)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addTodoItem
{
    //add an empty row to the data source and refresh the view
    [self.todoListArray insertObject:@"" atIndex:0];
    [self.tableView reloadData];
    
    //set editing mode
    [self setEditing:YES animated:YES];
    
    //find the newly created cell in visibleCells and call becomeFirstResponder
    NSArray *todoCellArray = [self.tableView visibleCells];
    
    for (TodoCell *cell in todoCellArray)
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        if (indexPath.row == 0)
        {
            [cell.todoTextField becomeFirstResponder];
            break;
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.todoListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TodoCell";
    TodoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TodoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.todoTextField.text = [self.todoListArray objectAtIndex:indexPath.row];
    cell.todoTextField.delegate = self;
    
    //associate the indexPath with the UITextField
    objc_setAssociatedObject(cell.todoTextField, indexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN);
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.todoListArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Not using this insert style
    }
}

// implementing this UITextField function if user edits and hits "Done"
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self textFieldUpdateTodoItemArray:textField];
    return YES;
}

// implementing this UITextField function if user edits and taps on another cell
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self textFieldUpdateTodoItemArray:textField];    
}

// save the edited value in the todo item array
- (void) textFieldUpdateTodoItemArray:(UITextField *) textField
{
    [textField resignFirstResponder];
    
    NSIndexPath *indexPath = objc_getAssociatedObject(textField, indexPathKey);
    [self.todoListArray replaceObjectAtIndex:indexPath.row withObject:textField.text];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
