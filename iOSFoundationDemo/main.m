//
//  main.m
//  iOSFoundationDemo
//
//  Created by uwei on 21/12/2017.
//  Copyright © 2017 uwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TestObject.h"

int main(int argc, char * argv[]) {
#pragma mark - Numbers, Data, and Basic Values & Data Formatting
    // 123 x 10-3
    NSDecimal decimal = {-3,5,0,1,0,123};
    NSLocale* locale = [NSLocale autoupdatingCurrentLocale];
    NSLog(@"string = %@", NSDecimalString(&decimal, locale));
    NSDecimalNumber *decimalNumber = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble:124.9];
    //    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithMantissa:678 exponent:-2 isNegative:YES];
    NSLog(@"string = %@", [decimalNumber stringValue]);
    NSDecimal decimalFromNumber = [decimalNumber decimalValue];
    NSLog(@"string = %@", NSDecimalString(&decimalFromNumber, locale));
    
    //以","当做小数点格式
    NSDictionary *localeDic = [NSDictionary dictionaryWithObject:@"," forKey:NSLocaleDecimalSeparator];
    //123.4
    NSDecimalNumber *discountAmount = [NSDecimalNumber decimalNumberWithString:@"123,419" locale:localeDic];
    NSLog(@"string = %@", [discountAmount stringValue]);
    
    // 算数运算
    NSDecimalNumber *addDecimalNumber = [decimalNumber decimalNumberByAdding:discountAmount];
    NSLog(@"string = %@", [addDecimalNumber stringValue]);
    
    /***************    Type definitions        ***********/
    
    // Rounding policies :
    // Original
    //    value 1.2  1.21  1.25  1.35  1.27
    // Plain    1.2  1.2   1.3   1.4   1.3
    // Down     1.2  1.2   1.2   1.3   1.2
    // Up       1.2  1.3   1.3   1.4   1.3
    // Bankers  1.2  1.2   1.2   1.4   1.3
    
    // 四舍五入运算
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSLog(@"string = %@", [addDecimalNumber decimalNumberByRoundingAccordingToBehavior:roundingBehavior]);
    
    NSNumberFormatter *nf = [NSNumberFormatter new];
    nf.numberStyle = NSNumberFormatterCurrencyStyle;
    nf.roundingMode = NSNumberFormatterRoundUp;
    nf.roundingIncrement = @(0.2);
    NSLog(@"string = %@", [nf stringFromNumber:@(124.897)]);
    
    NSString *urlString = @"https://username:password@www.apple.com:1290/us/search/uweiyuan?src=globalnav&name=value#jumpLocation";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLComponents *urlComponent = [NSURLComponents componentsWithString:urlString];
    
    NSUUID *uuid = [NSUUID UUID];
    NSLog(@"string = %@", [uuid UUIDString]);
    
    NSRange range = NSMakeRange(102, 89);
    NSLog(@"string = %@", NSStringFromRange(range));
    range = NSRangeFromString(@"{89, 90}");
    //集合运算 union、intersect
    range = NSIntersectionRange(range, NSMakeRange(102, 89));
    NSLog(@"string = %@", NSStringFromRange(range));
    if (NSLocationInRange(150, range)) {
        NSLog(@"in");
    } else {
        NSLog(@"out");
    }
    
    // 规律一：NSFormatter， 对于很多数据格式化，都是有Foundation定义的(NSByteCountFormatter, NSDateFormatter, NSDateComponentsFormatter, NSDateIntervalFormatter, NSEnergyFormatter, NSLengthFormatter, NSMassFormatter, NSNumberFormatter, and NSPersonNameComponentsFormatter)
    // 规律二：NS****FromString、 NSStringFrom****，****代表大多数OC中原生的数据类型
    
#pragma mark - Strings and Text
    
    NSString *text = @"我们是共产主义接班人，迎接着朝霞";
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:@[NSLinguisticTagSchemeTokenType] options:0];
    tagger.string = text;
    NSRange textRange = NSMakeRange(0, text.length);
    [tagger enumerateTagsInRange:textRange unit:(NSLinguisticTaggerUnitWord) scheme:( NSLinguisticTagSchemeTokenType) options:NSLinguisticTaggerOmitPunctuation|NSLinguisticTaggerOmitWhitespace usingBlock:^(NSLinguisticTag  _Nullable tag, NSRange tokenRange, BOOL * _Nonnull stop) {
        NSLog(@"%@", [text substringWithRange:tokenRange]);
    }];
    
    [[NSLinguisticTagger availableTagSchemesForLanguage:@"zh-Hans"] enumerateObjectsUsingBlock:^(NSLinguisticTagScheme  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
    
    [[NSLinguisticTagger availableTagSchemesForLanguage:@"en"] enumerateObjectsUsingBlock:^(NSLinguisticTagScheme  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
    NSLog(@"lan is %@", [NSLinguisticTagger dominantLanguageForString:@"ありがとうございます"]);
    NSLog(@"lan is %@", [NSLinguisticTagger dominantLanguageForString:@"非常的感谢"]);
    NSLog(@"lan is %@", [NSLinguisticTagger dominantLanguageForString:@"thank you very much"]);
    NSRange orthographyRange;
    NSLog(@"orthography is %@", [tagger orthographyAtIndex:0 effectiveRange:&orthographyRange]);
    
    text = @"The American Red Cross was established in Washington, D.C., by Clara Barton.";
    tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:@[NSLinguisticTagSchemeNameType] options:0];
    tagger.string = text;
    textRange = NSMakeRange(0, text.length);
    NSArray *tags = @[NSLinguisticTagPersonalName, NSLinguisticTagPlaceName, NSLinguisticTagOrganizationName];
    [tagger enumerateTagsInRange:textRange unit:NSLinguisticTaggerUnitWord scheme:NSLinguisticTagSchemeNameType options:NSLinguisticTaggerOmitPunctuation|NSLinguisticTaggerOmitWhitespace|NSLinguisticTaggerJoinNames usingBlock:^(NSLinguisticTag  _Nullable tag, NSRange tokenRange, BOOL * _Nonnull stop) {
        if ([tags containsObject:tag]) {
            NSLog(@"name :%@ tag:%@", [text substringWithRange:tokenRange], tag);
        }
    }];
    
    NSString *scannerString = @"100q100.89a99";
    NSScanner *stringScanner = [NSScanner scannerWithString:scannerString];
    stringScanner.charactersToBeSkipped = [NSCharacterSet letterCharacterSet];
    unsigned long long ll  = 0;
    NSLog(@"hex is %hhd", [stringScanner scanHexLongLong:&ll]);
    float f = 0.0;
    NSLog(@"float is %hhd", [stringScanner scanFloat:&f]);
    NSInteger i = 0;
    [stringScanner scanInt:&i];
    NSLog(@"int is %ld", (long)i);
    
#pragma mark - Collections
    NSArray *name1Array = @[@"g", @"b", @"c", @"d"];
    NSArray *name2Array = @[@"a", @"f", @"d", @"g"];
    NSCountedSet *countedName1Set = [[NSCountedSet alloc] initWithArray:name1Array];
    NSCountedSet *countedName2Set = [[NSCountedSet alloc] initWithArray:name2Array];
    [countedName1Set unionSet:countedName2Set];
    NSLog(@"%@", countedName1Set);
    
    NSOrderedSet *orderedNameSet = [[NSOrderedSet alloc] initWithArray:name1Array];
    NSLog(@"%@", orderedNameSet);
    NSLog(@"%@", [orderedNameSet objectAtIndex:2]);
    NSOrderedSet *orderedSet = [[NSOrderedSet alloc] initWithObjects:@"f",@"a", @"e", @"g", @"b", @"c", @"d", nil];
    NSLog(@"%@", orderedSet);
    NSSet *set = [[NSSet alloc] initWithObjects:@"f",@"a", @"e", @"g", @"b", @"c", @"d", nil];
    NSLog(@"%@", set);
    
    //A mutable collection you use to temporarily store transient key-value pairs that are subject to eviction when resources are low
    NSCache *cache = [NSCache new];
    cache.countLimit = 1;
    [cache setObject:@"aValue" forKey:@"akey"];
    [cache setObject:@"bValue" forKey:@"bkey" cost:1];
    NSLog(@"%@", [cache objectForKey:@"bkey"]);
    
    // Pointer Collections
    // NSMapTable    NSHashTable
    NSPointerArray *pointerArray = [[NSPointerArray alloc] initWithOptions:NSPointerFunctionsOpaqueMemory];
    int intI = 99;
    void *nullPointer = NULL;
    [pointerArray addPointer:&intI];
    [pointerArray addPointer:nullPointer];
    NSLog(@"%@", pointerArray);
    NSLog(@"%d", *(int *)([pointerArray pointerAtIndex:0]));
    
#pragma mark - Dates and Times
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = 20;
    dateComponents.month = 12;
    dateComponents.year = 2017;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSLog(@"time zone name %@", calendar.timeZone.name);
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDate *date = [calendar dateFromComponents:dateComponents];
    
    NSInteger weekday = [calendar component:NSCalendarUnitWeekdayOrdinal fromDate:date];
    NSLog(@"first day is %ld, now is %ld", calendar.firstWeekday,(long)weekday); // 5, which corresponds to Thursday in the Gregorian Calendar
    
    [calendar.shortStandaloneMonthSymbols enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
    
    [calendar.weekdaySymbols enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
    [calendar.quarterSymbols enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
    
    [calendar.longEraSymbols enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
    
    [[NSTimeZone knownTimeZoneNames] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
    
    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleBrief;
    formatter.includesApproximationPhrase = YES;
    formatter.includesTimeRemainingPhrase = YES;
    formatter.allowedUnits = NSCalendarUnitMinute;
    
    // Use the configured formatter to generate the string.
    NSString* outputString = [formatter stringFromTimeInterval:78400];
    NSLog(@"%@",outputString);
    
    NSDateIntervalFormatter* intervalFormatter = [[NSDateIntervalFormatter alloc] init];
    //    intervalFormatter.dateTemplate = @"YYYY:MM:dd HH-m-sss";
    intervalFormatter.dateStyle = NSDateIntervalFormatterShortStyle;
    intervalFormatter.timeStyle = NSDateIntervalFormatterShortStyle;
    
    // Create two dates that are exactly 1 day apart.
    NSDate* startDate = [NSDate date];
    NSDate* endDate = [NSDate dateWithTimeInterval:86400 sinceDate:startDate];
    
    // Use the configured formatter to generate the string.
    NSString* intervalFormatterOutputString = [intervalFormatter stringFromDate:startDate toDate:endDate];
    NSLog(@"%@",intervalFormatterOutputString);
    
    NSISO8601DateFormatter *isoFormatter = [NSISO8601DateFormatter new];
    isoFormatter.formatOptions = NSISO8601DateFormatWithFullDate|NSISO8601DateFormatWithTime;
    NSString *isoStringOutput = [isoFormatter stringFromDate:[NSDate date]];
    NSLog(@"%@",isoStringOutput);
    
    [[NSLocale ISOCountryCodes] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
    
    [[NSLocale ISOLanguageCodes] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
    
    [[NSLocale ISOCurrencyCodes] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
    
    [[NSLocale availableLocaleIdentifiers] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
    
#pragma mark - Units and Measurement
    //    NSUnit *pressUnit = [NSUnitPressure kilopascals];
    NSUnit *pressUnit = [NSUnitLength meters];
    NSMeasurement *measurement = [[NSMeasurement alloc] initWithDoubleValue:1007.98 unit:pressUnit];
    NSMeasurementFormatter *measureFormatter = [NSMeasurementFormatter new];
    measureFormatter.unitOptions = NSMeasurementFormatterUnitOptionsProvidedUnit;
    measureFormatter.unitStyle = NSFormattingUnitStyleShort;
    NSString *measurementFormatterOutputString = [measureFormatter stringFromMeasurement:measurement];
    NSLog(@"%@",measurementFormatterOutputString);
    
    // y = mx + b
    // subclass converter
    NSUnitConverter *converter = [[NSUnitConverterLinear alloc] initWithCoefficient:10 constant:0];
    double linerResult = [converter baseUnitValueFromValue:1.879];
    NSLog(@"%f",linerResult);
    
    // 总结：有很多物理学度量的类：Physical Dimension、Mass, Weight, and Force、Time and Motion、Energy, Heat, and Light、Electricity、Concentration and Dispersion、Fuel Efficiency
    
#pragma mark - Filters and Sorting
    NSString *testMatchString = @"we are the champion";
    // self指向evaluateWithObject的参数
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self BEGINSWITH[c] 'We'"];
    if ([predicate evaluateWithObject:testMatchString]) {
        NSLog(@" testMatchString BEGINSWITH We!");
    } else {
        NSLog(@" testMatchString not BEGINSWITH We!");
    }
    
    NSArray *filterArray = @[@"ab", @"abc"];
    NSArray *targetArray = @[@"a", @"b", @"c", @"ab", @"ac", @"bc", @"abc", @"ab"];
    NSPredicate *arrayPredicate = [NSPredicate predicateWithFormat:@"ANY self == 'bc'"];
    if ([arrayPredicate evaluateWithObject:filterArray]) {
        NSLog(@"find bc!");
    } else {
        NSLog(@"not find bc!");
    }
    if ([arrayPredicate evaluateWithObject:targetArray]) {
        NSLog(@"find bc!");
    } else {
        NSLog(@"not find bc!");
    }
    NSPredicate *filterArrayPredicate = [NSPredicate predicateWithFormat:@"(self in %@)", filterArray];
    NSArray *resultArray = [targetArray filteredArrayUsingPredicate:filterArrayPredicate];
    NSLog(@"result array = %@", resultArray);
    
    
    TestObject *o1 = [[TestObject alloc] initWithName:@"uwei" age:12];
    TestObject *o2 = [[TestObject alloc] initWithName:@"wei" age:21];
    TestObject *o3 = [[TestObject alloc] initWithName:@"yuan" age:2];
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"name like '*wei'"];
    if ([namePredicate evaluateWithObject:o1]) {
        NSLog(@"o1 find wei!");
    }
    
    if ([namePredicate evaluateWithObject:o2]) {
        NSLog(@"o2 find wei!");
    }
    
    if ([namePredicate evaluateWithObject:o3]) {
        NSLog(@"o3 find wei!");
    }
    
    NSArray *oArray = @[o1,o2,o3];
    NSArray *resultOArray = [oArray filteredArrayUsingPredicate:namePredicate];
    for (TestObject *o in resultOArray) {
        NSLog(@"name = %@, age = %lu", o.name, (unsigned long)o.age);
    }
    
    NSString *property = @"name";
    NSString *value = @"yuan";
    //  该谓词的作用是如果元素中property属性含有值value时就取出放入新的数组内，这里是name包含Jack
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K CONTAINS %@", property, value];
    NSArray *newArray = [oArray filteredArrayUsingPredicate:pred];
    for (TestObject *o in newArray) {
        NSLog(@"name = %@, age = %lu", o.name, (unsigned long)o.age);
    }
    
    //  创建谓词，属性名改为age，要求这个age包含$VALUE字符串
    NSPredicate *predTemp = [NSPredicate predicateWithFormat:@"%K >= $VALUE", @"age"];
    // 指定$VALUE的值为 25
    NSPredicate *pred1 = [predTemp predicateWithSubstitutionVariables:@{@"VALUE" : @12}];
    NSArray *newArray1 = [oArray filteredArrayUsingPredicate:pred1];
    for (TestObject *o in newArray1) {
        NSLog(@"name = %@, age = %lu", o.name, (unsigned long)o.age);
    }
    
    NSExpression *lhs = [NSExpression expressionForKeyPath:@"name"];
    NSExpression *rhs = [NSExpression expressionForVariable:@"VK"];
    NSPredicate *predicateTemplate = [NSComparisonPredicate
                                      predicateWithLeftExpression:lhs
                                      rightExpression:rhs
                                      modifier:NSDirectPredicateModifier
                                      type:NSLikePredicateOperatorType
                                      options:NSCaseInsensitivePredicateOption];
    NSPredicate *predicate11 = [predicateTemplate predicateWithSubstitutionVariables: [NSDictionary dictionaryWithObject:@"*wei" forKey:@"VK"]];
    
    [[oArray filteredArrayUsingPredicate:predicate11] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"NSExpression name = %@, age = %lu", ((TestObject*)obj).name, (unsigned long)((TestObject*)obj).age);
    }];
    
    // NSCompoundPredicate for AND OR NOT logical combinations
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSComparisonResult comResult = [sortDescriptor compareObject:o1 toObject:o2];
    NSLog(@"%ld", (long)comResult);
    
    //规律总结
    // Simple comparisons, such as grade == "7" or firstName like "Shaffiq"
    // Case and diacritic insensitive lookups, such as name contains[cd] "itroen"
    // Logical operations, such as (firstName like "Mark") OR (lastName like "Adderley")
    // Temporal range constraints, such as date between {$YESTERDAY, $TOMORROW}.
    // Relational conditions, such as group.name like "work*"
    // Aggregate operations, such as @sum.items.price < 1000
    // Reference URL:https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Predicates/Articles/pSyntax.html#//apple_ref/doc/uid/TP40001795
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
