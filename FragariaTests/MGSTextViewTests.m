//
//  MGSTextViewTests.m
//  Fragaria Tests
//
//  Created by Simon Fell on 7/19/21.
//

#import <XCTest/XCTest.h>
#import "MGSTextView.h"

@interface MGSTextView(TestPrivate)
-(BOOL)characterIsBrace:(unichar)c;
-(BOOL)characterIsClosingBrace:(unichar)c;
-(unichar)openingBraceForClosingBrace:(unichar)c;
-(unichar)closingBraceForOpeningBrace:(unichar)c;
@end

@interface MGSTextViewTests : XCTestCase

@end

@implementation MGSTextViewTests

-(void)testDefaultBraceMatching {
    MGSTextView *v = [[MGSTextView alloc] init];
    XCTAssertEqual('>', [v closingBraceForOpeningBrace:'<']);
    XCTAssertEqual('}', [v closingBraceForOpeningBrace:'{']);
    XCTAssertEqual(']', [v closingBraceForOpeningBrace:'[']);
    XCTAssertEqual(')', [v closingBraceForOpeningBrace:'(']);
    XCTAssertEqual(0, [v closingBraceForOpeningBrace:'q']);
    XCTAssertEqual('<', [v openingBraceForClosingBrace:'>']);
    XCTAssertEqual('{', [v openingBraceForClosingBrace:'}']);
    XCTAssertEqual('[', [v openingBraceForClosingBrace:']']);
    XCTAssertEqual('(', [v openingBraceForClosingBrace:')']);
    XCTAssertEqual(0,[v openingBraceForClosingBrace:' ']);
    unichar braces[] = {'<','>','{','}','[',']','(',')'};
    for (int i=0; i < 8; i++) {
        XCTAssertTrue([v characterIsBrace:braces[i]], @"%C should be a brace", braces[i]);
        XCTAssertEqual(i % 2 == 1, [v characterIsClosingBrace:braces[i]]);
    }
    XCTAssertFalse([v characterIsBrace:'q']);
}

-(void)testCustomBraceMatching {
    MGSTextView *v = [[MGSTextView alloc] init];
    [v setBraces:@{@'q':@'Q',@'<':@'>'}];
    XCTAssertEqualObjects((@{@'q':@'Q',@'<':@'>'}), v.braces);
    XCTAssertEqual('>', [v closingBraceForOpeningBrace:'<']);
    XCTAssertEqual('Q', [v closingBraceForOpeningBrace:'q']);
    XCTAssertEqual(0, [v closingBraceForOpeningBrace:'{']);
    XCTAssertEqual('<', [v openingBraceForClosingBrace:'>']);
    XCTAssertEqual('q', [v openingBraceForClosingBrace:'Q']);
    XCTAssertEqual(0,[v openingBraceForClosingBrace:'}']);
    unichar braces[] = {'<','>','q','Q'};
    for (int i=0; i < 4; i++) {
        XCTAssertTrue([v characterIsBrace:braces[i]], @"%C should be a brace", braces[i]);
        XCTAssertEqual(i % 2 == 1, [v characterIsClosingBrace:braces[i]]);
    }
    XCTAssertFalse([v characterIsBrace:'[']);
}

@end
