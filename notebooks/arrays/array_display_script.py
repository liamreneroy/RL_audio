import numpy as np

# This script reads and prints the 'informed initialization' array files for each of the three tested robot states
# If you want visualizations of these arrays, please see image files in this folder

# TO RUN THIS SCRIPT:
# 1. Open a terminal
# 2. Navigate to the 'notebooks/arrays' directory
# 3. Run the command: python3 array_display_script.py

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# STATE INDEX REFERENCE
# ST0 = Stuck
# ST1 = Accomplished 
# ST2 = Progressing

# PARAM INDEX REFERENCE
# Index 0 = Speed of audio loop (BPM)		--> (100 BPM   //  140 BPM  //  180 BPM)
# Index 1 = Number of beeps per loop (BPL)  --> (1 BPL	 //  2 BPM	 //  4 BPL) 
# Index 2 = Amplitude of Pitch Bend  		--> (downward  //  neutral  //  upward)

# read the array files
st0_array = np.load('pilotset_st0.npy') # Stuck
st1_array = np.load('pilotset_st1.npy') # Accomplished
st2_array = np.load('pilotset_st2.npy') # Progressing

print(f'\nStuck Informed Initialization:\n{st0_array}')
# OUTPUT:
# [[[ 1. -1. -3.]
#   [ 2.  0. -3.]
#   [ 3.  2. -3.]]

#  [[ 2. -1. -3.]
#   [ 2.  0. -3.]
#   [ 4.  2. -3.]]

#  [[ 2. -1. -3.]
#   [ 3.  0. -3.]
#   [ 5.  3. -3.]]]

print(f'\nAccomplished Informed Initialization:\n{st1_array}')
# OUTPUT:
# [[[-3.  0.  2.]
#   [-3.  1.  3.]
#   [-3.  0.  2.]]

#  [[-3.  0.  4.]
#   [-3.  1.  5.]
#   [-3.  0.  3.]]

#  [[-3.  0.  2.]
#   [-3.  1.  3.]
#   [-3.  0.  2.]]]

print(f'\nProgressing Informed Initialization:\n{st2_array}')
# OUTPUT:
# [[[ 0.  3.  0.]
#   [-3.  2. -3.]
#   [-3.  1. -3.]]

#  [[ 0.  5.  0.]
#   [-3.  3. -3.]
#   [-3.  1. -3.]]

#  [[ 0.  4.  0.]
#   [-3.  2. -3.]
#   [-3.  1. -3.]]]

