### week 01 - 08:

- wrote a history log on [data-analysis](https://github.com/weissbe92/MSc_thesis_BenediktWeiss/blob/master/open%20lab%20notebook/analysis_steps.pdf) and worked on my (functional) preprocessing workflow in jupyter notebooks
  - prep_tnac now includes all nodes until coregistration via bbregister and works to this point (version on gdrive)
  - still to implement: coregistration for normalisation, normalisation, smoothing
  - for normalisation inform on [nipype-page](http://miykael.github.io/nipype-beginner-s-guide/normalize.html)
 
- stimuli from angulo-perkins arrived on thursday, renamed the files to voice_0-59.wav, song_0-59.wav, music_0-59.wav to fit into the nomenclatur within the run.csv-files for the psychopy-experiment (4 runfiles)
- changed the randomisation-file to 4 runs and relative paths and created 4 test-csv-files
- experiment-test at scanner
- concatenated the 8 movies from mirjam to 4 movies, which have to be cutted to run-length:
  - cut movies: concatenate 2 of mirijams videos and then cut to length we need (for 4 runs) 
  - installed: sudo apt-get install mkvtoolnix mkvtoolnix-gui
  - bash-example: mkvmerge -o concat_movie7+8.mkv movie007.mkv + movie008.mkv
