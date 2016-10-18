# Recall Site Visit, 10.18.2016

Met with Sabra G., Alyda D. and Shannon L. (after introductions by Heather.)

## Sabra, Recall Desktop

In Chart Desktop, Flags

- Open Flag
	- if still in progress
		- Add to recall desktop
		- Hold
		- Remove Flag
	- if signed
		- Close Flag
		- Find Recall text manually
		- Route to Month (Absolute)
		- If only 1 name attached, remove that name (else pause)
		- When 'OK' right-click --> I'M DONE
			- Click OK
			- Go to Desktop
			- Delete the flag
			- Open Next
			- Close Alert when you open

Possible: Relative dates (3m instead of 1/2017)


In Chart Desktop, Documents

- Only Signed Documents Handled
- Route
	- if only 2 names, remove both of them
	- route to desktop
	
## Alyda, DM Recall

Splits recalls in to first and second halves of the month. 15th is split.

Needs Preference: Diabetes Ordering Default

- In Chart Desktop, Documents: After Review 'C' Change Properties Rename
	- Change Properties
	- Focus on Name Property
	- Send [ ]{left 2}
- In Properties Window
	- {Enter} Clicks OK
- Chart Desktop Documents
	- Append 'A' (Internal Other Recall)
	- Highlight Doc Name/Clinic Name
	- Ok
		- If DM, Switch to Billing/Diabetes for orders, Move mouse to A1c location
		- Switch to Process Lab Orders
			- If Send Orders
				- Wait until orders sent
				- Close window
				- Select behind pr
				- send lemr (or whatever the sent EMR script is.)
			- if close without sending
				- Close Window
				- Select behind pr
				- send le (or whatever quicktext it is.)
	- \\ Finish Lab Order Append
		- Send ^e
		- If only 2 names,
			- Send !m
			- Send !m
		- Send !s
		- Then imageclick(chart-desktop)
- Add Recall 'R'
	- imageclick(registration)
	- WinWaitOpen registration
	- imageclick Appointments
- Done with New Recall
	- When OK Clicked
		- Click it,
		- Close Recall
		- Close Registration
		- WinActivate, Chart Desktop
		
## Shannon, Recall Desktop

- In Chart Desktop, Documents
	- 'R' Recall Review
	- When done with new recall, as above.
	- Signing
		- Open Append
		- Send rfu
		- Send !s
		