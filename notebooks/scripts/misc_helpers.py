# IMPORTS
import os
import shutil
import time
from scripts import audio_control
from scripts import ucb1_algorithm as ucb1

import sys
from termcolor import colored, cprint
# Termcolor guide: https://pypi.org/project/termcolor/

import random

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# INITIALIZATIONS



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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

def get_user_ID(parent_dir, num_of_states):
    ''' returns an string of the double digit user ID '''
    
    user_ID_str = "-1" # <---"enter your number here"
    
    while True:
        try:
            user_ID_str = str(input(f"\nPlease enter your double digiet user ID number (ex: 00 ) then hit 'enter'\n"))

        except ValueError:
            print("Invalid user ID...\n")
            continue

        if user_ID_str != "-1" and len(user_ID_str) == 2:

            
            
            
            directory = "user_data/user_" + user_ID_str + "/arrays"

            # Path (add parent directory with new folder)
            path = os.path.join(parent_dir, directory)

            # Create the directory
            try:
                os.makedirs(path, exist_ok = True)
                # print("\nDirectory '%s' created successfully" % directory)
            except OSError as error:
                # print("\nDirectory '%s' can not be created" % directory)
                pass
        

            for state_idx in range(num_of_states):
                shutil.copyfile("arrays/pilotset_st" + str(state_idx) + ".npy", "user_data/user_" + user_ID_str + "/arrays/pilotset_st" + str(state_idx) + ".npy")

            # Coloured print statement to direct user to next cell
            cprint("\n\n\n------------------------------------------------------------------------", "light_yellow", attrs=["bold"])
            cprint("------------------------------------------------------------------------\n", "light_yellow", attrs=["bold"])
            cprint(f"Great job! You are user: {user_ID_str}\n", "black", "on_yellow", attrs=["bold"])
            cprint(f"Click on the next cell below and hit 'shift + enter' to continue\n", "black", "on_yellow", attrs=["bold"])
            cprint("------------------------------------------------------------------------", "light_yellow", attrs=["bold"])
            cprint("------------------------------------------------------------------------\n\n\n", "light_yellow", attrs=["bold"])
            
            break

        else:
            print("Invalid user ID...\n")
    
    time.sleep(2)
    
    return user_ID_str


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


def get_user_accuracy(sound_obj_array, lib_str, sect_str, user_ID_str, num_of_states, states_array, state_descriptions, param_disc, load_file="pilotset", seed=55):
    
    random.seed(seed)
    rand_state_idx_list = [*range(0, num_of_states, 1)]
    random.shuffle(rand_state_idx_list)
    print("Suffled rand_state_idx_list:", rand_state_idx_list)
    
    #creating a text file with the command function "w"
    textfile = open("user_data/user_" + user_ID_str + "/" + sect_str + "_" + lib_str + "_responses.txt", "w")
    textfile.write(f"{user_ID_str} - {sect_str} - {lib_str}\n")
    textfile.write("~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n")
    textfile.flush()

    for state_idx in rand_state_idx_list:  # To run them in order, replace with: for ... in range(num_of_states)
        current_state_index = state_idx

        # At each index of the state array, add the state object (each object has a unique index, description, and Q-table)
        states_array[state_idx] = ucb1.robot_state(state_idx, state_descriptions[state_idx], param_disc, load_file, user_ID_str)

        # Select the highest valued action in that states Q-Table - assign to params 1,2,3
        param_1_idx, param_2_idx, param_3_idx = states_array[current_state_index].action_selection()

        # Now lets play this action for the user and get their reponse 
        probed_state_index, probed_confidence = sound_obj_array[param_1_idx, param_2_idx, param_3_idx].probe(state_descriptions)

        textfile.write(f"current_state_index: {current_state_index}\n")
        textfile.write(f"probed_state_index: {probed_state_index}\n")
        textfile.write(f"probed_confidence: {probed_confidence}\n")
        textfile.write("\n________________________________________________________________________\n\n")
        textfile.flush()
        
    textfile.close()


    # Coloured print statement to direct user to next cell
    cprint("\n\n\n------------------------------------------------------------------------", "light_yellow", attrs=["bold"])
    cprint("------------------------------------------------------------------------\n", "light_yellow", attrs=["bold"])
    cprint(f"Great job!", "black", "on_yellow", attrs=["bold"])
    cprint(f"Click on the next cell below and hit 'shift + enter' to continue\n", "black", "on_yellow", attrs=["bold"])
    cprint("------------------------------------------------------------------------", "light_yellow", attrs=["bold"])
    cprint("------------------------------------------------------------------------\n\n\n", "light_yellow", attrs=["bold"])
