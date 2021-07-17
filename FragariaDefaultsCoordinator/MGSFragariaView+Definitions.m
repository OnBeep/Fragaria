//
//  MGSFragariaView+Definitions.m
//  Fragaria
//
//  Created by Jim Derry on 3/3/15.
//
//
#import "MGSFragariaView.h"
#import "MGSFragariaView+Definitions.h"
#import "MGSSyntaxController.h"
#import "MGSColourScheme.h"
#import "MGSUserDefaults.h"


#pragma mark - Property User Defaults Keys


// Configuring Syntax Highlighting
NSString * const MGSFragariaDefaultsIsSyntaxColoured =          @"syntaxColoured";
NSString * const MGSFragariaDefaultsSyntaxDefinitionName =      @"syntaxDefinitionName";
NSString * const MGSFragariaDefaultsColoursMultiLineStrings =   @"coloursMultiLineStrings";
NSString * const MGSFragariaDefaultsColoursOnlyUntilEndOfLine = @"coloursOnlyUntilEndOfLine";

// Configuring Autocompletion
NSString * const MGSFragariaDefaultsAutoCompleteDelay =        @"autoCompleteDelay";
NSString * const MGSFragariaDefaultsAutoCompleteEnabled =      @"autoCompleteEnabled";
NSString * const MGSFragariaDefaultsAutoCompleteWithKeywords = @"autoCompleteWithKeywords";
NSString * const MGSFragariaDefaultsAutoCompleteDisableSpaceEnter = @"autoCompleteDisableSpaceEnter";

// Highlighting the current line
NSString * const MGSFragariaDefaultsHighlightsCurrentLine =      @"highlightsCurrentLine";

// Configuring the Gutter
NSString * const MGSFragariaDefaultsShowsGutter =        @"showsGutter";
NSString * const MGSFragariaDefaultsMinimumGutterWidth = @"minimumGutterWidth";
NSString * const MGSFragariaDefaultsShowsLineNumbers =   @"showsLineNumbers";
NSString * const MGSFragariaDefaultsStartingLineNumber = @"startingLineNumber";
NSString * const MGSFragariaDefaultsGutterFont =         @"gutterFont";
NSString * const MGSFragariaDefaultsGutterTextColour =   @"gutterTextColour";

// Showing Syntax Errors
NSString * const MGSFragariaDefaultsShowsSyntaxErrors =             @"showsSyntaxErrors";
NSString * const MGSFragariaDefaultsShowsIndividualErrors =         @"showsIndividualErrors";

// Tabulation and Indentation
NSString * const MGSFragariaDefaultsTabWidth =                    @"tabWidth";
NSString * const MGSFragariaDefaultsIndentWidth =                 @"indentWidth";
NSString * const MGSFragariaDefaultsIndentWithSpaces =            @"indentWithSpaces";
NSString * const MGSFragariaDefaultsUseTabStops =                 @"useTabStops";
NSString * const MGSFragariaDefaultsIndentBracesAutomatically =   @"indentBracesAutomatically";
NSString * const MGSFragariaDefaultsIndentNewLinesAutomatically = @"indentNewLinesAutomatically";

// Automatic Bracing
NSString * const MGSFragariaDefaultsInsertClosingBraceAutomatically =       @"insertClosingBraceAutomatically";
NSString * const MGSFragariaDefaultsInsertClosingParenthesisAutomatically = @"insertClosingParenthesisAutomatically";
NSString * const MGSFragariaDefaultsShowsMatchingBraces =                   @"showsMatchingBraces";
NSString * const MGSFragariaDefaultsBeepOnMissingBrace =                    @"beepOnMissingBrace";

// Page Guide and Line Wrap
NSString * const MGSFragariaDefaultsPageGuideColumn =      @"pageGuideColumn";
NSString * const MGSFragariaDefaultsShowsPageGuide =       @"showsPageGuide";
NSString * const MGSFragariaDefaultsLineWrap =             @"lineWrap";
NSString * const MGSFragariaDefaultsLineWrapsAtPageGuide = @"lineWrapsAtPageGuide";

// Showing Invisible Characters
NSString * const MGSFragariaDefaultsShowsInvisibleCharacters =      @"showsInvisibleCharacters";

// Configuring Text Appearance
NSString * const MGSFragariaDefaultsTextFont =        @"textFont";
NSString * const MGSFragariaDefaultsLineHeightMultiple = @"lineHeightMultiple";

// Configuring Additional Text View Behavior
NSString * const MGSFragariaDefaultsHasVerticalScroller =      @"hasVerticalScroller";
NSString * const MGSFragariaDefaultsScrollElasticityDisabled = @"scrollElasticityDisabled";

// Colour Scheme
NSString * const MGSFragariaDefaultsColourScheme = @"colourScheme";
NSString * const MGSFragariaDefaultsUseSystemSelectionColor = @"useSystemSelectionColor";


#pragma mark - Implementation


@implementation MGSFragariaView (MGSUserDefaultsDefinitions)


#pragma mark - Defaults Dictionaries


#define ARCHIVED_OBJECT(obj) [NSArchiver archivedDataWithRootObject:obj]

/*
 *  + defaultsDictionary
 */
+ (NSDictionary *)defaultsDictionary
{
    static NSDictionary *cache;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cache = [MGSUserDefaults defaultsObjectFromObject:@{
            MGSFragariaDefaultsIsSyntaxColoured : @YES,
            MGSFragariaDefaultsSyntaxDefinitionName : [[MGSSyntaxController class] standardSyntaxDefinitionName],
            MGSFragariaDefaultsColoursMultiLineStrings : @NO,
            MGSFragariaDefaultsColoursOnlyUntilEndOfLine : @YES,

            MGSFragariaDefaultsAutoCompleteDelay : @1.0f,
            MGSFragariaDefaultsAutoCompleteEnabled : @NO,
            MGSFragariaDefaultsAutoCompleteWithKeywords : @YES,
            MGSFragariaDefaultsAutoCompleteDisableSpaceEnter : @NO,

            MGSFragariaDefaultsHighlightsCurrentLine : @NO,

            MGSFragariaDefaultsShowsGutter : @YES,
            MGSFragariaDefaultsMinimumGutterWidth : @40,
            MGSFragariaDefaultsShowsLineNumbers : @YES,
            MGSFragariaDefaultsStartingLineNumber : @1,
            MGSFragariaDefaultsGutterFont : [NSFont userFixedPitchFontOfSize:11],
            MGSFragariaDefaultsGutterTextColour : [NSColor disabledControlTextColor],

            MGSFragariaDefaultsShowsSyntaxErrors : @YES,
            MGSFragariaDefaultsShowsIndividualErrors : @NO,

            MGSFragariaDefaultsTabWidth : @4,
            MGSFragariaDefaultsIndentWidth : @4,
            MGSFragariaDefaultsUseTabStops : @YES,
            MGSFragariaDefaultsIndentWithSpaces : @NO,
            MGSFragariaDefaultsIndentBracesAutomatically : @YES,
            MGSFragariaDefaultsIndentNewLinesAutomatically : @YES,
            MGSFragariaDefaultsLineHeightMultiple : @(0.0),
            
            MGSFragariaDefaultsInsertClosingBraceAutomatically : @NO,
            MGSFragariaDefaultsInsertClosingParenthesisAutomatically : @NO,
            MGSFragariaDefaultsShowsMatchingBraces : @YES,
            MGSFragariaDefaultsBeepOnMissingBrace : @YES,
            
            MGSFragariaDefaultsPageGuideColumn : @80,
            MGSFragariaDefaultsShowsPageGuide : @NO,
            MGSFragariaDefaultsLineWrap : @YES,
            MGSFragariaDefaultsLineWrapsAtPageGuide : @NO,
            MGSFragariaDefaultsShowsInvisibleCharacters : @NO,

            MGSFragariaDefaultsTextFont : [NSFont userFixedPitchFontOfSize:11],

            MGSFragariaDefaultsHasVerticalScroller : @YES,
            MGSFragariaDefaultsScrollElasticityDisabled : @NO,
        
            MGSFragariaDefaultsColourScheme :
                [MGSColourScheme defaultColorSchemeForAppearance:
                    [NSAppearance appearanceNamed:NSAppearanceNameAqua]],
            MGSFragariaDefaultsUseSystemSelectionColor : @NO
        }];
    });
    
    return cache;
}


/*
 *  + defaultsDictionary
 */
+ (NSDictionary *)defaultsDarkDictionary
{
    static NSDictionary *cache;
    static dispatch_once_t onceToken;
    
    if (@available(macOS 10.14.0, *)) {
        dispatch_once(&onceToken, ^{
            cache = [MGSUserDefaults defaultsObjectFromObject:@{
                MGSFragariaDefaultsIsSyntaxColoured : @YES,
                MGSFragariaDefaultsSyntaxDefinitionName : [[MGSSyntaxController class] standardSyntaxDefinitionName],
                MGSFragariaDefaultsColoursMultiLineStrings : @NO,
                MGSFragariaDefaultsColoursOnlyUntilEndOfLine : @YES,
                
                MGSFragariaDefaultsAutoCompleteDelay : @1.0f,
                MGSFragariaDefaultsAutoCompleteEnabled : @NO,
                MGSFragariaDefaultsAutoCompleteWithKeywords : @YES,
                MGSFragariaDefaultsAutoCompleteDisableSpaceEnter : @NO,
                
                MGSFragariaDefaultsHighlightsCurrentLine : @NO,
                
                MGSFragariaDefaultsShowsGutter : @YES,
                MGSFragariaDefaultsMinimumGutterWidth : @40,
                MGSFragariaDefaultsShowsLineNumbers : @YES,
                MGSFragariaDefaultsStartingLineNumber : @1,
                MGSFragariaDefaultsGutterFont : [NSFont userFixedPitchFontOfSize:11],
                MGSFragariaDefaultsGutterTextColour : [NSColor disabledControlTextColor],
                
                MGSFragariaDefaultsShowsSyntaxErrors : @YES,
                MGSFragariaDefaultsShowsIndividualErrors : @NO,
                
                MGSFragariaDefaultsTabWidth : @4,
                MGSFragariaDefaultsIndentWidth : @4,
                MGSFragariaDefaultsUseTabStops : @YES,
                MGSFragariaDefaultsIndentWithSpaces : @NO,
                MGSFragariaDefaultsIndentBracesAutomatically : @YES,
                MGSFragariaDefaultsIndentNewLinesAutomatically : @YES,
                MGSFragariaDefaultsLineHeightMultiple : @(0.0),
                
                MGSFragariaDefaultsInsertClosingBraceAutomatically : @NO,
                MGSFragariaDefaultsInsertClosingParenthesisAutomatically : @NO,
                MGSFragariaDefaultsShowsMatchingBraces : @YES,
                MGSFragariaDefaultsBeepOnMissingBrace : @YES,
                
                MGSFragariaDefaultsPageGuideColumn : @80,
                MGSFragariaDefaultsShowsPageGuide : @NO,
                MGSFragariaDefaultsLineWrap : @YES,
                MGSFragariaDefaultsLineWrapsAtPageGuide : @NO,
                MGSFragariaDefaultsShowsInvisibleCharacters : @NO,
                
                MGSFragariaDefaultsTextFont : [NSFont userFixedPitchFontOfSize:11],
                
                MGSFragariaDefaultsHasVerticalScroller : @YES,
                MGSFragariaDefaultsScrollElasticityDisabled : @NO,
                
                MGSFragariaDefaultsColourScheme :
                    [MGSColourScheme defaultColorSchemeForAppearance:
                        [NSAppearance appearanceNamed:NSAppearanceNameDarkAqua]],
                MGSFragariaDefaultsUseSystemSelectionColor : @NO
            }];
        });
        return cache;
    } else {
        return [self defaultsDictionary];
    }
}



#pragma mark - Manual Management Support

/*
 *  + fragariaNamespacedKeyForKey:
 */
+ (NSString *)namespacedKeyForKey:(NSString *)aString
{
	NSString *character = [[aString substringToIndex:1] uppercaseString];
	NSMutableString *changedString = [NSMutableString stringWithString:aString];
	[changedString replaceCharactersInRange:NSMakeRange(0, 1) withString:character];
	return [NSString stringWithFormat:@"MGSFragariaDefaults%@", changedString];
}


/*
 *  + fragariaDefaultsDictionaryWithNamespace
 */
+ (NSDictionary *)defaultsDictionaryWithNamespace
{
    __block NSMutableDictionary *dictionary;
    NSDictionary *def;
    
    dictionary = [[NSMutableDictionary alloc] init];
    def = [[self class] defaultsDictionary];
    
	[def enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
        [dictionary setObject:object forKey:[self namespacedKeyForKey:key]];
	}];
    
	return [dictionary copy];
}


/*
 *  - resetDefaults
 */
- (void)resetDefaults
{
    NSDictionary *def;
    
    def = [[self class] defaultsDictionary];
    
	for (NSString *key in def)
		[self setValue:def[key] forKey:key];
}


#pragma mark - Class Methods - Convenience Sets of Properties


/*
 * + propertyGroupEditing
 */
+ (NSSet *)propertyGroupEditing
{
	return [NSSet setWithArray:@[MGSFragariaDefaultsIsSyntaxColoured,
        MGSFragariaDefaultsHighlightsCurrentLine, MGSFragariaDefaultsPageGuideColumn,
		MGSFragariaDefaultsShowsSyntaxErrors, MGSFragariaDefaultsShowsIndividualErrors,
		MGSFragariaDefaultsShowsPageGuide, MGSFragariaDefaultsLineWrap,
		MGSFragariaDefaultsLineWrapsAtPageGuide, MGSFragariaDefaultsShowsInvisibleCharacters,
		MGSFragariaDefaultsLineHeightMultiple, MGSFragariaDefaultsShowsMatchingBraces,
        MGSFragariaDefaultsBeepOnMissingBrace,
	]];
}


/*
 * + propertyGroupGutter
 */
+ (NSSet *)propertyGroupGutter
{
    return [NSSet setWithArray:@[MGSFragariaDefaultsMinimumGutterWidth,
        MGSFragariaDefaultsShowsGutter, MGSFragariaDefaultsShowsLineNumbers,
	]];
}

/*
 * + propertyGroupAutocomplete
 */
+ (NSSet *)propertyGroupAutocomplete
{
	return [NSSet setWithArray:@[MGSFragariaDefaultsAutoCompleteDelay,
		MGSFragariaDefaultsAutoCompleteEnabled, MGSFragariaDefaultsAutoCompleteWithKeywords,
		MGSFragariaDefaultsInsertClosingBraceAutomatically,
        MGSFragariaDefaultsInsertClosingParenthesisAutomatically,
        MGSFragariaDefaultsAutoCompleteDisableSpaceEnter
	]];
}


/*
 * + propertyGroupIndenting
 */
+ (NSSet *)propertyGroupIndenting
{
	return [NSSet setWithArray:@[MGSFragariaDefaultsTabWidth,
        MGSFragariaDefaultsIndentWidth, MGSFragariaDefaultsIndentWithSpaces,
		MGSFragariaDefaultsUseTabStops, MGSFragariaDefaultsIndentBracesAutomatically,
		MGSFragariaDefaultsIndentNewLinesAutomatically
	]];
}


/*
 * + propertyGroupTextFont
 */
+ (NSSet *)propertyGroupTextFont
{
	return [NSSet setWithArray:@[MGSFragariaDefaultsTextFont]];
}


/*
 * + propertyGroupTheme
 */
+ (NSSet *)propertyGroupTheme
{
	return [NSSet setWithObject:MGSFragariaDefaultsColourScheme];
}


/*
 * + propertyGroupColouringExtraOptions
 */
+ (NSSet *)propertyGroupColouringExtraOptions
{
	return [NSSet setWithArray:@[MGSFragariaDefaultsColoursMultiLineStrings,
        MGSFragariaDefaultsColoursOnlyUntilEndOfLine,
        MGSFragariaDefaultsUseSystemSelectionColor]];
}


@end
