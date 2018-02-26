#!/bin/sh

function help() {
    echo "📖  Visit our docs for step-by-step instructions on installing Swift correctly."
    echo "http://docs.vapor.codes"
    echo ""
    echo "👋  or Join our Slack and we'll help you get setup."
    echo "http://vapor.team"
}

function check_vapor() {
    SWIFTC=`which swift`;

    if [[ $SWIFTC == "" ]];
    then
        echo "❌  Cannot find Swift."
        echo ""
        echo "ℹ️  'which swift' is empty."
        echo ""
        help
        return 1;
    fi

    OS=`uname`
    if [[ $OS == "Darwin" ]]; # macOS
    then
        XCBVERSION=`xcodebuild -version`
        if [[ $XCBVERSION == *"Xcode 9"* ]];
        then
            echo "✅  Compatible Xcode" 
        elif [[ $XCBVERSION == *"Xcode 8"* ]]; 
        then 
            echo "⚠️  Xcode 9 is recommended"; 
            echo ""; 
            echo "✅  Compatible Xcode" 
        else
            echo "⚠️  It looks like your Command Line Tools version is incorrect."
            echo ""
            echo "Open Xcode and make sure the correct SDK is selected:"
            echo "👀  Xcode > Preferences > Locations > Command Line Tools"
            echo ""
            echo "Correct: Xcode 9.x (Any Build Number)"
            echo "Current: $XCBVERSION"
            echo ""
            help
            return 1;
        fi
    fi

    SWIFTV=`swift --version`

    if [[ $SWIFTV == *"4.0"* ]];
    then
        echo "✅  Compatible with Vapor 2"
        return 0;
    elif [[ $SWIFTV == *"3.1"* ]]; 
    then 
        echo "⚠️  Swift 4.0 is recommended"; 
        echo ""; 
        echo "✅  Compatible with Vapor 2"; 
        return 0; 
    else 
        echo "❌  Swift 4.0 is recommended, 3.1 or later is required.."
        echo ""
        echo "'swift --version' output:"
        echo $SWIFTV
        echo ""
        echo "Output does not contain '3.1'."
        echo ""
        help
        return 1;
    fi
}

check_vapor;
