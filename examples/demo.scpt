on run
	set longDelay to 0.500000
	set shortDelay to 0.300000
	set timeoutSeconds to 2.000000
	set podmanCommand to {	"p", "o", "d", "m", "a", "n", " ", "r", "u", "n", " ", "-", "-", "r", "m", " ", "-", "i", "t", " ", "-", "v", " ", "$", "H", "O", "M", "E", "/", "P", "r", "o", "j", "e", "c", "t", "s", "/", "O", "p", "e", "n", "S", "o", "u", "r", "c", "e", "/", "C", "L", "I", "s", "/", "i", "n", "s", "t", "a", "l", "l", "-", "l", "i", "b", ":", "/", "i", "n", "s", "t", "a", "l", "l", "-", "l", "i", "b", " ", "-", "v", " ", "$", "H", "O", "M", "E", "/", ".", "c", "o", "n", "f", "i", "g", "/", "a", "s", "c", "i", "i", "n", "e", "m", "a", ":", "/", "r", "o", "o", "t", "/", ".", "c", "o", "n", "f", "i", "g", "/", "a", "s", "c", "i", "i", "n", "e", "m", "a", " ", "-", "-", "w", "o", "r", "k", "d", "i", "r", "=", "/", "i", "n", "s", "t", "a", "l", "l", "-", "l", "i", "b", " ", "g", "h", "c", "r", ".", "i", "o", "/", "a", "s", "c", "i", "i", "n", "e", "m", "a", "/", "a", "s", "c", "i", "i", "n", "e", "m", "a", " ", "r", "e", "c", " ", "-", "-", "o", "v", "e", "r", "w", "r", "i", "t", "e", " ", ".", "/", "e", "x", "a", "m", "p", "l", "e", "s", ".", "c", "a", "s", "t" }
	set exampleCommand to { ".", "/", "e", "x", "a", "m", "p", "l", "e", "s", "/", "e", "x", "a", "m", "p", "l", "e", "s", ".", "s", "h" }
	set updateCommand to { "a", "p", "t", " ", "-", "y", " ", "u", "p", "d", "a", "t", "e" }
	set installPackages to { "a", "p", "t", " ", "-", "y", " ", "i", "n", "s", "t", "a", "l", "l", " ", "b", "c", " ", "w", "a", "m", "e", "r", "i", "c", "a", "n", "-", "l", "a", "r", "g", "e" }
	set exitCommand to { "e", "x", "i", "t" }
	set ctrlShiftLkey to "keystroke \"l\" using {control down, shift down}"
	set yKey to "keystroke \"y\""
	set nKey to "keystroke \"n\""
	set ctrlMkey to "keystroke \"m\" using control down"
	set enterKey to "key code 36"
	set downKey to "key code 125"

	-- Focus Terminal window
	my doWithDelay( shortDelay, ctrlShiftLkey, timeoutSeconds )

	-- Type podman command and execute
	repeat with currentString in podmanCommand
	  set charToType to "keystroke \"" & currentString & "\""
	  my doWithTimeout( charToType, timeoutSeconds )
	end repeat
	my doWithDelay( shortDelay, enterKey, timeoutSeconds )
	delay 2

	-- Type update command and execute
	repeat with currentString in updateCommand
	  set charToType to "keystroke \"" & currentString & "\""
	  my doWithTimeout( charToType, timeoutSeconds )
	end repeat
  my doWithDelay( shortDelay, enterKey, timeoutSeconds )
  delay 30

	-- Type install command and execute
	repeat with currentString in installPackages
	  set charToType to "keystroke \"" & currentString & "\""
	  my doWithTimeout( charToType, timeoutSeconds )
	end repeat
  my doWithDelay( shortDelay, enterKey, timeoutSeconds )
  delay 30

	-- Type example command and execute
	repeat with currentString in exampleCommand
	  set charToType to "keystroke \"" & currentString & "\""
	  my doWithTimeout( charToType, timeoutSeconds )
	end repeat
	my doWithDelay( shortDelay, enterKey, timeoutSeconds )

	-- Navigate to the color examples
  my doWithDelay( longDelay, enterKey, timeoutSeconds )

  -- Run through the color examples
	repeat with menuIndex from 1 to 43
  	my selectMenuItem( menuIndex, timeoutSeconds )
  	my doWithDelay( longDelay, enterKey, timeoutSeconds )
  end repeat

  -- Leave the color examples
  my doWithDelay( longDelay, enterKey, timeoutSeconds )
  my doWithDelay( longDelay, nKey, timeoutSeconds )
  my doWithDelay( longDelay, enterKey, timeoutSeconds )

  -- Mark
  my doWithDelay( longDelay, ctrlMkey, timeoutSeconds )

  -- Navigate to the logging examples
  my doWithDelay( shortDelay, downKey, timeoutSeconds )
	my doWithDelay( longDelay, enterKey, timeoutSeconds )

	-- Run through the logging examples
	repeat with menuIndex from 1 to 5
  	my selectMenuItem( menuIndex, timeoutSeconds )
  	if (menuIndex is not equal to 5) then
  		my doWithDelay( longDelay, enterKey, timeoutSeconds )
  	end if
  end repeat

  -- Mark
  my doWithDelay( longDelay, ctrlMkey, timeoutSeconds )

  -- Navigate to the OS examples
	my doWithDelay( shortDelay, downKey, timeoutSeconds )
	my doWithDelay( shortDelay, downKey, timeoutSeconds )
  my doWithDelay( longDelay, enterKey, timeoutSeconds )

  -- Run through the OS examples
	repeat with menuIndex from 1 to 3
  	my selectMenuItem( menuIndex, timeoutSeconds )
  	if (menuIndex is not equal to 3) then
  		my doWithDelay( longDelay, enterKey, timeoutSeconds )
  	end if
  end repeat

  -- Mark
  my doWithDelay( longDelay, ctrlMkey, timeoutSeconds )

  -- Navigate to the OS examples
	my doWithDelay( shortDelay, downKey, timeoutSeconds )
	my doWithDelay( shortDelay, downKey, timeoutSeconds )
  my doWithDelay( longDelay, enterKey, timeoutSeconds )

  -- Run through the final OS examples
	repeat with menuIndex from 1 to 2
  	my selectMenuItem( menuIndex + 3, timeoutSeconds )
  	my doWithDelay( longDelay, enterKey, timeoutSeconds )
  end repeat

  -- Leave the OS examples
  my doWithDelay( longDelay, enterKey, timeoutSeconds )
	my doWithDelay( longDelay, nKey, timeoutSeconds )
  my doWithDelay( longDelay, enterKey, timeoutSeconds )

  -- Mark
	my doWithDelay( longDelay, ctrlMkey, timeoutSeconds )

	-- Navigate to the Package examples
	my doWithDelay( shortDelay, downKey, timeoutSeconds )
	my doWithDelay( shortDelay, downKey, timeoutSeconds )
	my doWithDelay( shortDelay, downKey, timeoutSeconds )
  my doWithDelay( longDelay, enterKey, timeoutSeconds )

  -- Run through the Package examples
	repeat with menuIndex from 1 to 3
  	my selectMenuItem( menuIndex, timeoutSeconds )
  	if (menuIndex is not equal to 3) then
  		my doWithDelay( longDelay, enterKey, timeoutSeconds )
  	end if
  end repeat

  -- delay for package install
  delay 20

	-- Leave the Package examples
  my doWithDelay( longDelay, nKey, timeoutSeconds )
  my doWithDelay( longDelay, enterKey, timeoutSeconds )

	-- Mark
	my doWithDelay( longDelay, ctrlMkey, timeoutSeconds )

	-- Navigate to the Run examples
	my doWithDelay( shortDelay, downKey, timeoutSeconds )
	my doWithDelay( shortDelay, downKey, timeoutSeconds )
	my doWithDelay( shortDelay, downKey, timeoutSeconds )
	my doWithDelay( shortDelay, downKey, timeoutSeconds )
  my doWithDelay( longDelay, enterKey, timeoutSeconds )

  -- Run through the Run example
  my doWithDelay( longDelay, enterKey, timeoutSeconds )
  delay 30

	-- Leave the Run examples
	my doWithDelay( shortDelay, nKey, timeoutSeconds )
	my doWithDelay( shortDelay, enterKey, timeoutSeconds )
	my doWithDelay( shortDelay, enterKey, timeoutSeconds )

	-- Mark
	-- my doWithDelay( longDelay, ctrlMkey, timeoutSeconds )

	-- Navigate to the Final examples
	my doWithDelay( shortDelay, downKey, timeoutSeconds )
	my doWithDelay( shortDelay, downKey, timeoutSeconds )
	my doWithDelay( shortDelay, downKey, timeoutSeconds )
	my doWithDelay( shortDelay, downKey, timeoutSeconds )
	my doWithDelay( shortDelay, downKey, timeoutSeconds )
	my doWithDelay( longDelay, enterKey, timeoutSeconds )

	-- Run through the UI examples
	repeat with menuIndex from 1 to 4
  	my selectMenuItem( menuIndex, timeoutSeconds )
  	if (menuIndex is not equal to 4) then
  		my doWithDelay( longDelay, enterKey, timeoutSeconds )
  		my doWithDelay( longDelay, enterKey, timeoutSeconds )
  	end if
  end repeat

	-- Leave the examples
	my doWithDelay( longDelay, nKey, timeoutSeconds )
	my doWithDelay( longDelay, enterKey, timeoutSeconds )
	my doWithDelay( longDelay, nKey, timeoutSeconds )
	my doWithDelay( longDelay, enterKey, timeoutSeconds )

	-- Type exit command and execute
	repeat with currentString in exitCommand
	  set charToType to "keystroke \"" & currentString & "\""
	  my doWithTimeout( charToType, timeoutSeconds )
	end repeat
	my doWithDelay( shortDelay, enterKey, timeoutSeconds )
end run

on selectMenuItem( itemNum, timeoutSeconds )
	set longDelay to 0.500000
	set shortDelay to 0.300000
	set enterKey to "key code 36"
	set downKey to "key code 125"
	set itemNum to itemNum - 1
  repeat itemNum times
    my doWithDelay( shortDelay, downKey, timeoutSeconds )
	end repeat
	my doWithDelay( longDelay, enterKey, timeoutSeconds )
end selectMenuItem

on doWithDelay( delaySeconds, uiScript, timeoutSeconds )
	delay delaySeconds
	my doWithTimeout( uiScript, timeoutSeconds )
	delay delaySeconds
end doWithDelay

on doWithTimeout( uiScript, timeoutSeconds )
	set endDate to (current date) + timeoutSeconds
	repeat
		try
			run script "tell application \"System Events\"
" & uiScript & "
end tell"
			exit repeat
		on error errorMessage
			if ((current date) > endDate) then
				error "Can not " & uiScript
			end if
		end try
	end repeat
end doWithTimeout
