

#!/usr/bin/env python
# -*- coding: utf-8 -*-



def gen_runfiles(nmbr):

   import numpy as np
   import random as rd
   import copy
   import os

   # set variable for a relative directory
   #thisdir = os.getcwd()

   # create stimulus-lists for voice, song and music each (stimuli from angulo-perkins)
   stim_voice = np.arange(60)
   stim_song = np.arange(60)
   stim_music = np.arange(60)

   # 4 fictive (randomized) block-sequences, will be replaced with neuropowertool-generated sequences
   block_seq = 12*['voice','song','music']
   block_seq1 = copy.deepcopy(block_seq)
   block_seq2 = copy.deepcopy(block_seq)
   block_seq3 = copy.deepcopy(block_seq)
   block_seq4 = copy.deepcopy(block_seq)
   rd.shuffle(block_seq1)
   rd.shuffle(block_seq2)
   rd.shuffle(block_seq3)
   rd.shuffle(block_seq4)

   # experiment-array for one participant (4 runs, 36 blocks each)
   sequences = [block_seq1] + [block_seq2] + [block_seq3] + [block_seq4]

   # set counter for runfiles 1 - 4
   counter = 1

   for x in sequences:

       # randomize the stimulus-order
       rd.shuffle(stim_voice)
       rd.shuffle(stim_song)
       rd.shuffle(stim_music)

       # sort randomized stimuli into blocks of same modalities (5 stimuli/block, 12 blocks for each modality in total)
       blocks_voice = np.split(stim_voice, 12)
       blocks_song = np.split(stim_song, 12)
       blocks_music = np.split(stim_music, 12)

       # set indices
       voice_index = 0
       song_index = 0
       music_index = 0

       # create a csv-file
       ofile = open('run%i.csv' % counter, 'w')
       ofile.write('run,stimuli,block\n')

       # sort the block_modalities (blocks_voice, blocks_song, blocks_music) by the sequences for the 4 runs
       # write information about run, stimuli, blocks into csv-file
       for y in range(len(x)):
           if x[y] == 'voice':
               temp = blocks_voice[voice_index]
               for number in temp:
                   ofile.write('%s,"/voice/voice_%s.wav","block_%s"\n' % (counter, number, x[y]))
               #ofile.write('%s,"pause:%s"\n' % (counter, inter_block_delay[y]))
               voice_index = voice_index +1
           elif x[y] == 'song':
               temp = blocks_song[song_index]
               for number in temp:
                   ofile.write('%s,"/song/song_%s.wav","block_%s"\n' % (counter, number, x[y]))
               #ofile.write('%s,"pause:%s"\n' % (counter, inter_block_delay[y]))
               song_index = song_index +1
           elif x[y] == 'music':
               temp = blocks_music[music_index]
               for number in temp:
                   ofile.write('%s,"/music/music_%s.wav","block_%s"\n' % (counter, number, x[y]))
               #ofile.write('%s,"pause:%s"\n' % (counter, inter_block_delay[y]))
               music_index = music_index +1

       ofile.close()
       counter = counter + 1
