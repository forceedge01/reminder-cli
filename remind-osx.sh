#!/usr/bin/env bash


function main() {
if [[ -z "$1" ]]; then
        echo 'You must supply a title'
        return
fi

if [[ -z "$2" ]]; then
        echo 'You must supply a date'
        return
fi

if [[ -z "$3" ]]; then
        echo 'You must supply a time'
        return
fi

createReminder "$1" "$2" "$3" &>/dev/null
if [[ $? != 0 ]]; then
        echo 'An error occured, please check the values supplied'
fi

echo 'Reminder created'
}

function createReminder() {
osascript - "$1" "$2" "$3" <<END
on run argv
set stringedAll to date (item 2 of argv & " " & item 3 of argv)
tell application "Reminders"
make new reminder with properties {name:item 1 of argv, due date:stringedAll}
end tell
end run
END
}

main "$@"
