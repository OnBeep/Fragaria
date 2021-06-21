//
//  FragariaAppDelegate.m
//  Fragaria
//
//  Created by Jonathan on 30/04/2010.
//  Copyright 2010 mugginsoft.com. All rights reserved.
//

#import "FragariaAppDelegate.h"
#import <Fragaria/Fragaria.h>
#import "MGSSimpleBreakpointDelegate.h"
#import "ExampleCustomParser.h"
#import "ExampleCustomParserWithComposition.h"


@implementation FragariaAppDelegate {
    IBOutlet MGSFragariaView *fragaria;
    MGSSimpleBreakpointDelegate *breakptDelegate;
}

@synthesize window;


#pragma mark - NSApplicationDelegate

/*
 * - applicationDidFinishLaunching:
 */
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification 
{
    /* Register our custom parser factories.
     * The custom parsers will appear in the list of languages, toghether with the
     * other standard ones. */
    [[MGSSyntaxController sharedInstance] registerParserFactory:[[ExampleCustomParser alloc] init]];
    [[MGSSyntaxController sharedInstance] registerParserFactory:[[ExampleCustomParserWithComposition alloc] init]];
    
	// define initial object configuration
	//
	// see Fragaria.h for details
	//
    fragaria.textViewDelegate = self;

	// set our syntax definition
	[self setSyntaxDefinition:@"Objective-C"];

	// get initial text - in this case a test file from the bundle
	NSString *path = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"txt"];
	NSString *fileText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	
	// set text
    fragaria.string = fileText;

    // define a syntax error
    MGSSyntaxError *syntaxError = [MGSSyntaxError new];
    syntaxError.errorDescription = @"Syntax errors can be defined.";
    syntaxError.line = 1;
    syntaxError.character = 1;
    syntaxError.length = 10;
    fragaria.syntaxErrors = @[syntaxError];

    // specify a breakpoint delegate
    breakptDelegate = [[MGSSimpleBreakpointDelegate alloc] init];
    fragaria.breakpointDelegate = breakptDelegate;
    
    // Use a color scheme with dynamic colors to support light/dark transition.
    // When using FragariaDefaultsCoordinator, this is not required.
    fragaria.colourScheme = [MGSColourScheme dynamicColorBuiltinColourScheme];
}


/*
 * - applicationShouldTerminateAfterLastWindowClosed:
 */
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
	 #pragma unused(theApplication)
	 
	 return YES;
}


#pragma mark - Actions


/*
 * - reloadString:
 */
- (IBAction)reloadString:(id)sender
{
    [fragaria setString:[fragaria string]];
}


#pragma mark - Pasteboard handling

/*
 * - copyToPasteBoard:
 */
- (IBAction)copyToPasteBoard:(id)sender
{
	NSAttributedString *attString = fragaria.textView.attributedString;
    NSData *data = [attString RTFFromRange:NSMakeRange(0, [attString length])
                        documentAttributes:@{NSDocumentTypeDocumentAttribute: NSRTFTextDocumentType}];
	NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
	[pasteboard clearContents];
	[pasteboard setData:data forType:NSRTFPboardType];
}


#pragma mark - Property Accessors

/*
 * @property syntaxDefinition
 */
- (void)setSyntaxDefinition:(NSString *)name
{
    fragaria.syntaxDefinitionName = name;
}

- (NSString *)syntaxDefinition
{
	return fragaria.syntaxDefinitionName;
}


#pragma mark - NSTextDelegate

/*
 * - textDidChange:
 */
- (void)textDidChange:(NSNotification *)notification
{
	#pragma unused(notification)

	[window setDocumentEdited:YES];
}


/*
 * - textDidBeginEditing:
 */
- (void)textDidBeginEditing:(NSNotification *)aNotification
{
	NSLog(@"notification : %@", [aNotification name]);
}


/*
 * - textDidEndEditing:
 */
- (void)textDidEndEditing:(NSNotification *)aNotification
{
	NSLog(@"notification : %@", [aNotification name]);
}


/*
 * - textShouldBeginEditing:
 */
- (BOOL)textShouldBeginEditing:(NSText *)aTextObject
{
    #pragma unused(aTextObject)
	
	return YES;
}


/*
 * - textShouldEndEditing:
 */
- (BOOL)textShouldEndEditing:(NSText *)aTextObject
{
    #pragma unused(aTextObject)
	
	return YES;
}


- (void)textViewDidChangeSelection:(NSNotification *)notification
{
    NSUInteger i, r, c;
    
    i = fragaria.textView.selectedRange.location;
    [fragaria getRow:&r column:&c forCharacterIndex:i];
    self.row = [NSString stringWithFormat:@"%lu", (unsigned long)r+1];
    self.column = [NSString stringWithFormat:@"%lu", (unsigned long)c+1];
}


#pragma mark - MGSFragariaTextViewDelegate

/*
 * - mgsTextDidPaste:
 */
- (void)mgsTextDidPaste:(NSNotification *)aNotification
{
    // When this notification is received the paste will have been accepted.
    // Use this method to query the pasteboard for additional pasteboard content
    // that may be relevant to the application: eg: a plist that may contain custom data.
    NSLog(@"notification : %@", [aNotification name]);
}


@end
