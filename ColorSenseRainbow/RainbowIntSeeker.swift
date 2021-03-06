//
//  RainbowIntSeeker.swift
//  
//
//  Created by Reid Gravelle on 2015-04-20.
//
//

import AppKit

class RainbowIntSeeker: Seeker {

    override init () {
        super.init()
        
        var error : NSError?
        
        
        var regex = NSRegularExpression ( pattern: "(?:NS|UI)Color\\s*\\(\\s*redValue:\\s*([0-9]{1,3})\\s*,\\s*greenValue:\\s*([0-9]{1,3})\\s*,\\s*blueValue:\\s*([0-9]{1,3})\\s*,\\s*alphaValue:\\s*([01]\\.?[0-9]*)\\s*\\)", options: .allZeros, error: &error )
        
        if regex == nil {
            println ( "Error creating Swift Rainbow Integer with alphaValue regex = \(error?.localizedDescription)" )
        } else {
            regexes.append( regex! )
        }
        
        
        regex = NSRegularExpression ( pattern: "(?:NS|UI)Color\\s*\\(\\s*redValue:\\s*([0-9]{1,3})\\s*,\\s*greenValue:\\s*([0-9]{1,3})\\s*,\\s*blueValue:\\s*([0-9]{1,3})\\s*\\)", options: .allZeros, error: &error )
        
        if regex == nil {
            println ( "Error creating Swift Rainbow Integer without alphaValue regex = \(error?.localizedDescription)" )
        } else {
            regexes.append( regex! )
        }
    }
    
    
    override func processMatch ( match : NSTextCheckingResult, line : String ) -> SearchResult? {
        
        if ( ( match.numberOfRanges == 4 ) || ( match.numberOfRanges == 5 ) ) {
            var alphaValue : CGFloat = 1.0
            
            let matchString = stringFromRange( match.range, line: line )
            let redString = stringFromRange( match.rangeAtIndex( 1 ), line: line )
            let greenString = stringFromRange( match.rangeAtIndex( 2 ), line: line )
            let blueString = stringFromRange( match.rangeAtIndex( 3 ), line: line )
            var capturedStrings = [ matchString, redString, greenString, blueString ]
            
            if ( match.numberOfRanges == 5 ) {
                let alphaString = stringFromRange( match.rangeAtIndex( 4 ), line: line )
                
                alphaValue = CGFloat ( (alphaString as NSString).doubleValue )
                capturedStrings.append( alphaString )
            }
            
            
            let redValue = redString.toInt()!
            let greenValue = greenString.toInt()!
            let blueValue = blueString.toInt()!
            
            let color = NSColor ( redValue: redValue, greenValue: greenValue, blueValue: blueValue, alphaValue: alphaValue )

            var searchResult = SearchResult ( color: color, textCheckingResult: match, capturedStrings: capturedStrings )
            searchResult.creationType = .RainbowInt
            
            return searchResult
        }

        return nil
    }
}
