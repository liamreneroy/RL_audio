# STAND-ALONE FUNCTIONS

def print_logger():
	# Initial prompts to determine if extra print statements are shown
	# To use this, add this to main:
		# Comment this to add/remove a print logger with y/n prompt 
		# print_logger_ext = misc_helpers.print_logger()
		# if print_logger_ext:
			# <print_logger actions here>

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
