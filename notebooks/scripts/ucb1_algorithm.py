# IMPORTS
import numpy as np

import sys
from termcolor import colored, cprint
# Termcolor guide: https://pypi.org/project/termcolor/

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# INITIALIZATIONS 

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CLASSES

class robot_state:
	""" the base state object class """
	
	def __init__(self, state_idx, description, param_disc, load_file, user_ID_str):				

		self.state_idx = state_idx
		self.description = description

		if load_file: # Load an existing Q-table
			self.action_value_lookup = np.load("user_data/user_" + user_ID_str + "/arrays/" + load_file + "_st" + str(self.state_idx) + ".npy")
			# print("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
			# print(f"Initialized Q-table file: {'user_data/user_' + user_ID_str + '/arrays/' + load_file + '_st' + str(self.state_idx) + '.npy'}\n")
			
		else: # Initialize all Q-Values to max reward (optimism in the face of uncertainty)
			self.action_value_lookup = np.ones((param_disc, param_disc, param_disc)) * 10.0 # Arbitrary initialization
			# print("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
			# print(f"Initialized action value Q-table as flat 10.0\n")


	def action_selection(self):
		max_action_index = np.unravel_index(randargmax(self.action_value_lookup), self.action_value_lookup.shape)
		param_1_idx = max_action_index[0]
		param_2_idx = max_action_index[1]
		param_3_idx = max_action_index[2]

		return param_1_idx, param_2_idx, param_3_idx


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# STAND-ALONE FUNCTIONS

def randargmax(b,**kw):
	""" a random tie-breaking argmax"""
	return np.argmax(np.random.random(b.shape) * (b==b.max()), **kw)