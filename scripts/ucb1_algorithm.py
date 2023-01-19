# IMPORTS
import numpy as np
import time


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# INITIALIZATIONS 

param_disc = 5 # number of discretized regions for each param --> i.e. if equals 5 then (0, 1, 2, 3, 4)

Q_value_lookup = np.zeros((param_disc, param_disc))
print(Q_value_lookup)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# STAND-ALONE FUNCTIONS

def update_loop(loop_object, all_states, current_state_index):

	loop_object.probe(all_states, current_state_index)
	loop_object.update()
	Q_value_lookup[loop_object.param_1, loop_object.param_2] = loop_object.sample()
	print("(hidden) ~ Q_value_lookup after update:\n", Q_value_lookup)
	print()

	time.sleep(2.5) # Put here to make UI a bit nicer 
