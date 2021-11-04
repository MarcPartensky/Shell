function youareuseless {
        for i in {1..$2}
        do  
                sleep $1
		echo $2
		osascript -e 'display notification "you are useless"'
                say "you are useless"
        done
}

