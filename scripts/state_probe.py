# Initializations (eventually set these in main)
all_states = ["Progressing", "Successful", "Requires Assistance"]


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


def Probe_State():
	# Prompts user to determine what state they perceive the robot to be in.
    # Inputs:   None 
    # Returns:  Index of perceived state 

	print()
	while True:
		try:
			perceived_state_index = int(input(f"What state is the robot in: \n[0]: {all_states[0]} \n[1]: {all_states[1]} \n[2]: {all_states[2]} \n"))
			print()

		except ValueError:
			print(f"Please enter the numerical index of the state shown below.")
			print()
			continue

		if perceived_state_index == 0:
			print(f'You entered: {perceived_state_index} --> state: {all_states[perceived_state_index]}')
			break

		elif perceived_state_index == 1:
			print(f'You entered: {perceived_state_index} --> state: {all_states[perceived_state_index]}')
			break
		
		elif perceived_state_index == 2:
			print(f'You entered: {perceived_state_index} --> state: {all_states[perceived_state_index]}')
			break

		else:
			print(f"Please enter the numerical index of the state shown below.")
			print()

	print()
	return perceived_state_index, all_states[perceived_state_index]


Probe_State()



# NOTES:
# Make a STATE class, so that each state is an object (instance) with different values of the same attributes 
