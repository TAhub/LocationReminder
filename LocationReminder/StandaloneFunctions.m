//
//  StandaloneFunctions.m
//  LocationReminder
//
//  Created by Theodore Abshire on 11/24/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "StandaloneFunctions.h"

int DigitSummer(NSString *digitString)
{
	int result = 0;
	
	unichar buffer[digitString.length];
	[digitString getCharacters:buffer range:NSMakeRange(0, digitString.length)];
	for (int i = 0; i < digitString.length; i++)
	{
		if (buffer[i] >= '0' && buffer[i] <= '9')
		{
			int num = buffer[i] - '0';
			result += num;
		}
	}
	
	return result;
}

BOOL AnagramCheck(NSString *string1, NSString *string2)
{
	//this checks if two strings are anagrams
	//it only checks characters, and isn't caps-sensitive
	//so it's checking for natural-language anagrams
	
	//construct two dictionaries of characters
	NSMutableDictionary *charDict1 = [[NSMutableDictionary alloc] init];
	NSMutableDictionary *charDict2 = [[NSMutableDictionary alloc] init];
	for (unichar i = 'a'; i <= 'z'; i++)
	{
		NSString *key = [NSString stringWithFormat:@"%C", i];
		[charDict1 setValue:@(0) forKey:key];
		[charDict2 setValue:@(0) forKey:key];
	}
	
	//add to the first dictionary
	unichar buffer1[string1.length];
	[[string1 lowercaseString] getCharacters:buffer1 range:NSMakeRange(0, string1.length)];
	for (int i = 0; i < string1.length; i++)
	{
		if (buffer1[i] >= 'a' && buffer1[i] <= 'z')
		{
			NSString *key = [NSString stringWithFormat:@"%C", buffer1[i]];
			NSNumber *amount = [charDict1 valueForKey:key];
			[charDict1 setValue:@([amount integerValue] + 1) forKey:key];
		}
	}
	
	//add to the second dictionary
	unichar buffer2[string2.length];
	[[string2 lowercaseString] getCharacters:buffer2 range:NSMakeRange(0, string2.length)];
	for (int i = 0; i < string2.length; i++)
	{
		if (buffer2[i] >= 'a' && buffer2[i] <= 'z')
		{
			NSString *key = [NSString stringWithFormat:@"%C", buffer2[i]];
			NSNumber *amount = [charDict2 valueForKey:key];
			[charDict2 setValue:@([amount integerValue] + 1) forKey:key];
		}
	}
	
	return [charDict1 isEqualToDictionary:charDict2];
}