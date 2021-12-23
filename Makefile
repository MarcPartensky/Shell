install: clean
	./symlink.sh
clean:
	find ~/.local/bin -xtype l | xargs -I {} rm "{}"

