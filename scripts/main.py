import get_play_mp3

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Initializations



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


def Print_Logger():
	# Initial promps to determine if extra print statements are shown

	print()

	while True:
		try:
			print_logger = input("Print Debugging (y / n): ")
			print()

		except ValueError:
			print("Please enter 'y' or 'n'")
			print()
			continue

		if print_logger == "y" or print_logger == "Y" or print_logger == "n" or print_logger == "N":
			print(f'You entered: {print_logger}')
			break

		else:
			print("Please enter 'y' or 'n'")
			print()


	if print_logger == "y":
		print_logger_bin = 1

	elif print_logger == "Y":
		print_logger_bin = 1
		
	else:
		print_logger_bin = 0
	
	print()
	return print_logger_bin


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


if __name__ == "__main__":

    # Comment this out to remove initial print logger y/n prompt 
    print_logger_ext = Print_Logger()

    # Ask user what V/A they want, then find acording filepath 
    init_valence, init_arousal = get_play_mp3.Get_Valence_Arousal()
    MP3_file_path = get_play_mp3.Get_MP3_Path(init_valence, init_arousal)
    print()

    if print_logger_ext:
        print("init_valence", init_valence)
        print("init_arousal", init_arousal)
        print()
        print("MP3_file_path", MP3_file_path)
        print()

    # Play the desired MP# file
    get_play_mp3.Play_MP3(MP3_file_path)

    